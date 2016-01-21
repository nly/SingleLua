--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/21
-- Time: 下午1:40
--

local _PLA = { _VERSION = 0.1 }

--- register all hook function
--
function _PLA:register()
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
