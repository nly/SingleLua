--
-- bootstrap
-- User: leandre
-- Date: 16/1/15
-- Time: 下午8:55
--

local _B = {}

function _B:initDb()
--    local container = require("container")
--
--    local mysql = require("db.mysql")
--    mysql:init()
--    container["mysql"] = mysql -- put mysql to container
--
--    local memcache = require("cache.memcache")
--    memcache:init()
--    container["memcache"] = memcache -- put memcache to container
--
--    -- ngx.say("Db init")
--    local testPlugin = require("plugins.test")
--    testPlugin:register()
end

function _B:initTest()
--    local container = require("container")
--    local request = container['request']
--    local tools = require("tools")
--    ngx.say(request.http_method)
--    ngx.say(request.http_get_params.a)
--    tools.print_table(request.http_headers)
--    ngx.say(container['ctr_file'])
--    ngx.say("Test init")
end

return _B