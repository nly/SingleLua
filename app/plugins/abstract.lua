--
-- plugin abstract
-- User: leandre
-- Date: 16/1/21
-- Time: 下午1:40
--

local _PLA = {}

--- register all hook function
--
function _PLA:register()
    local container = require(ngx.ctx.app_config["lib_path"] .. "container")
    for k, v in pairs(self) do
        if k == "routerStartup" then
            table.insert(container['routerStartup'], v)
        elseif k == "routerShutdown" then
            table.insert(container['routerShutdown'], v)
        elseif k == "preDispatch" then
            table.insert(container['preDispatch'], v)
        elseif k == "postDispatch" then
            table.insert(container['postDispatch'], v)
        end
    end
    return true
end

return _PLA
