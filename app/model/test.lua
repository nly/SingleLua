--
-- test model
-- User: leandre
-- Date: 16/2/22
-- Time: 下午3:24
--

local app_config = require("app.config.app")
local _M = { pool_name = "alpha" }
local container = require(app_config["lib_path"] .. "container")
local mysql = container["mysql"]

function _M:getTest()
    local res, err = mysql:query(self.pool_name, "select * from users")
    if res == ngx.ERROR then
        ngx.log(ngx.ERR, err)
    end

    return res, err
end

return _M