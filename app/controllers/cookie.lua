--
-- cookie test
-- User: leandre
-- Date: 16/2/24
-- Time: 下午12:46
--

local CTR = require("controllers.abstract")
local _M = {}
setmetatable(_M, { __index = CTR })

--- test index action
--
function _M:index()
    local cookie = require("cookie")

    local res, err = cookie:set('one', 'two')
    ngx.say(res)

    local test = cookie:get("one")
    ngx.say(test)

    local all = cookie:get_all()
    ngx.say(all['one'])
end

return _M
