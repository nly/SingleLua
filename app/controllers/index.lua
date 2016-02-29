--
-- index controller
-- User: leandre
-- Date: 16/1/13
-- Time: 下午1:53
--

local app_config = require("app.config.app")
local CTR = require(app_config["ctr_path"] .. "abstract")
local _M = {}
setmetatable(_M, { __index = CTR })

--- test init action
--
function _M:init()
    -- ngx.say("controller init")
end

--- test index action
--
function _M:index()
    ngx.say("<h1>Hello SingleLua</h1>")
    -- self:succ("", "", { 1, 2, 3 })
    -- self:error("", "", { 4, 5, 6 })
end

return _M