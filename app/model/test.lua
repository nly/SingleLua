--
-- test model
-- User: leandre
-- Date: 16/2/22
-- Time: 下午3:24
--

local _M = {}
local container = ngx.ctx.container
local mysql = container["mysql"]

function _M:getTest()
    local res = mysql:query("alpha", "select * from users")
    if res then
        return res
    end
    return false
end

return _M