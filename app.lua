--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/15
-- Time: 下午12:17
--

root_path = ngx.var.document_root
app_path = "app"

local kernel = require(app_path .. ".kernel")
kernel:run();