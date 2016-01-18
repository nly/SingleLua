--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/15
-- Time: 下午12:11
--

app_config = require(app_path .. ".config.app")
tools = require(app_config["lib_path"] .. ".tools")
container = require(app_config["lib_path"] .. ".container")

local _K = {}

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

--- not found
--
local function not_found()
    ngx.status = 404
    ngx.say("File not found.")
    ngx.exit(404)
end

--- kernel run
--
function _K.run()

    local uri_arr = tools.array_filter(tools.lua_string_split("/", ngx.var.uri))
    local ctr_file = tools.lua_string_merge(".", uri_arr);
    container['ctr_file'] = ctr_file

    bootstrap()

    ctr_file = app_config["ctr_path"] .. container["ctr_file"];

    local ctr_cache = ngx.shared.ctrs:get(ctr_file)

    if ctr_cache == nil then
        local ctr_realpath = root_path .. tools.lua_string_merge("/", tools.lua_string_split("%.", ctr_file)) .. ".lua"
        if io.open(ctr_realpath, "r") == nil then
            ngx.shared.ctrs:set(ctr_file, 0)
            not_found()
        else
            ngx.shared.ctrs:set(ctr_file, 1)
        end
    elseif ctr_cache == 0 then
        not_found()
    end
    local ctr = require(ctr_file)
    ctr.index()
end

return _K;