--
-- mysql test
-- User: leandre
-- Date: 16/2/22
-- Time: 下午3:22
--

local app_config = ngx.ctx.app_config
local CTR = require(app_config["ctr_path"] .. "abstract")
local _M = {}
setmetatable(_M, {__index = CTR})

--- test index action
--
function _M:index()
    local model = require(ngx.ctx.app_path .. "model.test")
    local result = model:getTest()
    self:succ("", "", result)
end

return _M

