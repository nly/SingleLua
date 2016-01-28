--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/21
-- Time: 下午2:06
--

local PLA = require(app_config["plugin_path"] .. "abstract")
local _P = PLA

function _P:routerStartup()
    -- ngx.say("routerStartup")
end

function _P:routerShutdown()
    -- ngx.say("routerShutdown")
end

function _P:preDispatch()
    -- ngx.say('preDispatch')
end

function _P:postDispatch()
    -- ngx.say('postDispatch')
end

return _P