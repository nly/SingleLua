--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/13
-- Time: 下午1:53
--

local CTR = require(app_config["ctr_path"] .. ".abstract")
local _M = CTR

--- test init action
--
function _M:init()
    ngx.say("controller init");
end

--- test index action
--
function _M:index()
    ngx.say("controller index");
end

return _M