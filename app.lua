--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/15
-- Time: 下午12:17
--

app_path = "app"
app_config = require(app_path .. ".config.app")
local kernel = require(app_path .. ".kernel")
kernel.run();