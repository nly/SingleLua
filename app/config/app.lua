--
-- app config
-- User: leandre
-- Date: 16/1/15
-- Time: 下午12:17
--

local app_path = ngx.ctx.app_path

--- app config
-- @field lib_path
-- @field ctr_path
-- @field plugin_path
--
local _C = {
    lib_path = app_path .. "library.",
    ctr_path = app_path .. "controllers.",
    plugin_path = app_path .. "plugins."
}

return _C