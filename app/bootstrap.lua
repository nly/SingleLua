--
-- bootstrap
-- User: leandre
-- Date: 16/1/15
-- Time: 下午8:55
--

local app_config = require("app.config.app")
local _B = {}

function _B:initDb(request)
    local container = require(app_config["lib_path"] .. "container")

    local mysql = require(app_config["lib_path"] .. "db.mysql")
    mysql:init()
    container["mysql"] = mysql -- put mysql to container
    -- ngx.say("Db init")
    local testPlugin = require(app_config["plugin_path"] .. "test")
    testPlugin:register()
end

function _B:initTest()
--    local container = require(app_config["lib_path"] .. "container")
--    local request = container['request']
--    local tools = require(app_config["lib_path"] .. "tools")
--    ngx.say(request.http_method)
--    ngx.say(request.http_get_params.a)
--    tools.print_table(request.http_headers)
--    ngx.say(container['ctr_file'])
--    ngx.say("Test init")
end

return _B