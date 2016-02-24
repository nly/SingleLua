--
-- Cookie support
-- User: leandre
-- Date: 16/2/24
-- Time: 下午12:34
-- https://github.com/cloudflare/lua-resty-cookie
--

local ck = require(ngx.ctx.app_config["lib_path"] .. "resty.cookie")
local cookie, err = ck:new()
if not cookie then
    ngx.log(ngx.ERR, err)
    return ngx.ERROR, err
end

local _M = { ck = cookie }

function _M:set(name, value, expires, path, domain, secure, httponly)
    if not name or name == "" then
        return ngx.ERROR, "cookie name must not be empty"
    end

    if type(expires) == "number" and expires ~= 0 then
        expires = ngx.cookie_time(ngx.now() + expires)
    end

    if not path then
        path = "/"
    end

    local ok, err = self["ck"]:set({
        key = name,
        value = value,
        expires = expires,
        path = path,
        domain = domain,
        secure = secure,
        httponly = httponly
    })

    if not ok then
        ngx.log(ngx.ERR, err)
        return ngx.ERROR, err
    end

    return ok
end


--- get a single cookie
-- @param name
--
function _M:get(name)
    if not name or name == "" then
        return ngx.ERROR, "cookie name must not be empty"
    end

    local value, err = self["ck"]:get(name)
    if not value then
        ngx.log(ngx.ERR, err)
    end
    return value
end

--- get all cookies
--
function _M:get_all()
    local values, err = self["ck"]:get_all()
    if not values then
        ngx.log(ngx.ERR, err)
    end
    return values
end



return _M