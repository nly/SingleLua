--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/15
-- Time: 下午12:11
--

local _K = {}

tools = require(app_config["lib_path"] .. ".tools")
container = require(app_config["lib_path"] .. ".container")

--- call bootstrap function list
--
local function bootstrap()
    local bootstrap = require(app_path .. ".bootstrap")
    for k, v in pairs(bootstrap) do
        if string.sub(k, 1, 4) == "init" then
            v()
        end
    end
end

--- kernel run
--
function _K.run()

    local uri_arr = tools.array_filter(tools.lua_string_split("/", ngx.var.uri))
    local ctr_file = tools.lua_string_merge(".", uri_arr);
    container['ctr_file'] = ctr_file
    bootstrap()
    local ctr = require(app_config["ctr_path"] .. container['ctr_file'])
    ctr.index()
end

return _K;