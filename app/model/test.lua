--
-- test model
-- User: leandre
-- Date: 16/2/22
-- Time: 下午3:24
--


local _M = {}

local container = require("container")
local json = require("json")

local mysql = container["mysql"]
local memcache = container["memcache"]


function _M:getTest()
    local res, err = mysql:query("select * from users")
    if res == ngx.ERROR then
        ngx.log(ngx.ERR, err)
    end

    return res, err
end

function _M:getTest2()
    local res, err = memcache:get("users")
    if not res then
        res, err = mysql:query("select * from users")
        if res == ngx.ERROR then
            ngx.log(ngx.ERR, err)
        else
            local ok, err1 = memcache:set("users", json:encode(res), 3600)
            if not ok then
                ngx.log(ngx.WARN, err1)
            end
        end
    else
        res = json:decode(res)
    end

    return res, err
end

return _M