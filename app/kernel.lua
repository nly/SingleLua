--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/15
-- Time: 下午12:11
--

local _K = {}

--- kernel run
--
function _K.run()
    local tools = require(app_config["lib_path"] .. ".tools")
    local uri_arr = tools.array_filter(tools.lua_string_split("/", ngx.var.uri))
    local ctr_file = tools.lua_string_merge(".", uri_arr);
    local ctr = require(app_config["ctr_path"] .. ctr_file)
    ctr.index()
end

return _K;