--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/15
-- Time: 下午12:17
--

root_path = ngx.var.document_root
app_path = "app."

app_config = require(app_path .. "config.app")
container = require(app_config["lib_path"] .. ".container")

local kernel = require(sys_path .. ".sys_kernel")
kernel:run();