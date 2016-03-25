--
-- mysql test
-- User: leandre
-- Date: 16/2/22
-- Time: 下午3:22
--

local CTR = require("controllers.abstract")
local _M = {}
setmetatable(_M, { __index = CTR })

--- test index action
--
function _M:index()
    local model = require("model.test")
    local res, err = model:getTest()
    if res ~= ngx.ERROR then
        self:succ("", "", res)
    else
        self.error("", "", err)
    end
end

return _M

