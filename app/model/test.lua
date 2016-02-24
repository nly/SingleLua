--
-- test model
-- User: leandre
-- Date: 16/2/22
-- Time: 下午3:24
--

local _M = { pool_name = "alpha" }
local container = ngx.ctx.container
local mysql = container["mysql"]

function _M:getTest()
    return mysql:query(self.pool_name, "select * from users")
end

return _M