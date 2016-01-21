--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/21
-- Time: 下午1:41
--

local _CTR = {}

--- main function of controllers
--
function _CTR:new()
    -- init action
    if type(self["init"]) == "function" then
        self:init()
    end
    -- index action
    if type(self["index"]) == "function" then
        self:index()
    end
end

return _CTR;