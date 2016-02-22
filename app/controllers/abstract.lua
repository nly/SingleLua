--
-- controller abstract
-- User: leandre
-- Date: 16/1/21
-- Time: 下午1:41
--

local _CTR = {}

local CODE = {
    SUCC = 1000,
    ERROR = 1001
}

--- main function of controllers
--
function _CTR:new()
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
function _CTR:succ(code, msg, data)
    local app_config = ngx.ctx.app_config
    local json = require(app_config["lib_path"] .. "json")
    if code == "" then
        code = CODE['SUCC']
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
function _CTR:error(code, msg, data)
    local app_config = ngx.ctx.app_config
    local json = require(app_config["lib_path"] .. "json")
    if code == "" then
        code = CODE['ERROR']
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

return _CTR