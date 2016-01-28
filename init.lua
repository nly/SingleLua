--
-- init_by_lua_file, prepare the system
-- User: leandre
-- Date: 16/1/28
-- Time: 下午1:41
--

sys_path = "system."
sys_lib_path = sys_path .. ".sys_library."

sys_tools = require(sys_lib_path .. "tools")
sys_container = require(sys_path .. "sys_container")
sys_controller = require(sys_path .. "sys_controller")