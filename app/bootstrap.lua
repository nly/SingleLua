--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/15
-- Time: 下午8:55
--

local _B = { _VERSION = 0.1 }

function _B:initDb()
    ngx.say("Db init")
    local testPlugin = require(app_config["plugin_path"] .. ".test")
    testPlugin:register()
end

function _B:initTest()
    ngx.say(container['ctr_file'])
    ngx.say("Test init")
end

return _B;