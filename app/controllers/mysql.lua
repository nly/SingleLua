--
-- mysql test
-- User: leandre
-- Date: 16/2/22
-- Time: 下午3:22
--

local CTR = require(app_config["ctr_path"] .. "abstract")
local _M = CTR

--- test index action
--
function _M:index()
    local model = require(app_path .. "model.test")
    local result = model:getTest()
    self:succ("", "", result)
end

return _M

