--
-- mysql
-- User: leandre
-- Date: 16/2/1
-- Time: 上午11:18
--

local _M = {}
local _config = {}

--- init db config
--
function _M:init()
    local app_path = ngx.ctx.app_path
    _config = require(app_path .. "config.mysql")
    return _config
end

function _M:connect(pool_name, is_slave)
    local mysql = require("resty.mysql")
    local db, err = mysql:new()
    if not db then
        ngx.say("failed to instantiate mysql: ", err)
        return
    end

    db:set_timeout(1000) -- 1 sec

    local conf = {}
    if is_slave == true then
        conf = _config[pool_name]["slave"]
    else
        conf = _config[pool_name]["master"]
    end

    local ok, err, errno, sqlstate = db:connect {
        host = conf["host"],
        port = conf["port"],
        database = conf["database"],
        user = conf["user"],
        password = conf["password"],
        max_packet_size = 1024 * 1024
    }

    if not ok then
        ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
        return false
    end

    return db
end

function _M:query(poolname, sql)
    if poolname == "" or sql == "" then
        return false
    end

    local db
    if string.find(sql, "select") == 1 then
        db = self:connect(poolname, true) -- slave db
    else
        db = self:connect(poolname, false) -- master db
    end

    if not db then
        return false
    end


    local res, err, errno, sqlstate = db:query(sql)
    if not res then
        ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
        return false
    end

    -- put it into the connection pool of size 100,
    -- with 10 seconds max idle timeout
    local ok, err = db:set_keepalive(10000, 100)
    if not ok then
        ngx.say("failed to set keepalive: ", err)
        return false
    end

    return res
end

return _M