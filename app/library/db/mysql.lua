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
    _config = require("config.mysql")
    return _config
end

--- connect to mysql db
-- @param pool_name
-- @param is_slave
--
function _M:connect(pool_name, is_slave)
    local mysql = require("resty.mysql")
    local db, err = mysql:new()
    if not db then
        return ngx.ERROR, err
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
        return ngx.ERROR, err, errno, sqlstate
    end

    return db
end

--- query a SQL
-- @param sql
-- @param poolname
--
function _M:query(sql, poolname)
    if sql == "" then
        return ngx.ERROR
    end

    local poolname = poolname or "default"

    local db, err
    if string.find(sql, "select") == 1 then
        db, err = self:connect(poolname, true) -- slave db
    else
        db, err = self:connect(poolname, false) -- master db
    end

    if db == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err, errno, sqlstate = db:query(sql)
    if not res then
        return ngx.ERROR, err, errno, sqlstate
    end

    -- put it into the connection pool of size 100,
    -- with 10 seconds max idle timeout
    local ok, err = db:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err
    end

    return res
end

return _M
