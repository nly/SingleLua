--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/28
-- Time: 下午1:46
--

sys_controller = {}

sys_code = {
    SUCC = 1000,
    ERROR = 1001
}

--- main function of controllers
--
function sys_controller:new()
    -- init action
    if type(self["init"]) == "function" then
        self:init()
    end
    -- index action
    if type(self["index"]) == "function" then
        self:index()
    end
end

--- out json success
-- @param code
-- @param msg
-- @param data
--
function sys_controller:succ(code, msg, data)
    local json = require(sys_lib_path .. ".json")
    if code == "" then
        code = sys_code['SUCC']
    end
    if msg == "" then
        msg = "ok"
    end
    if data == "" then
        data = {}
    end
    ngx.say(json:encode({ code = code, msg = msg, data = data }))
    return true
end

--- out json error
-- @param code
-- @param msg
-- @param data
--
function sys_controller:error(code, msg, data)
    local json = require(sys_lib_path .. ".json")
    if code == "" then
        code = sys_code['ERROR']
    end
    if msg == "" then
        msg = "error"
    end
    if data == "" then
        data = {}
    end
    ngx.say(json:encode({ code = code, msg = msg, data = data }))
    return true
end

return sys_controller;

