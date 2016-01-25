--
-- Created by IntelliJ IDEA.
-- http://www.kyne.com.au/~mark/software/lua-cjson.php
-- User: leandre
-- Date: 16/1/25
-- Time: 下午1:20
--

local cjson_safe = require('cjson.safe')

local _M = {}

--- encode
-- @param table
--
function _M:encode(table)
    return cjson_safe.encode(table)
end

--- decode
-- @param string
--
function _M:decode(string)
    return cjson_safe.decode(string)
end

return _M