--
-- mysql test
-- User: leandre
-- Date: 16/2/22
-- Time: 下午3:22
--

local app_config = require("app.config.app")
local CTR = require(app_config["ctr_path"] .. "abstract")
local _M = {}
setmetatable(_M, { __index = CTR })

--- test index action
--
function _M:index()
    local model = require("app.model.test")
    local res, err = model:getTest()
    if res ~= ngx.ERROR then
        self:succ("", "", res)
    else
        self.error("", "", err)
    end
end

return _M

