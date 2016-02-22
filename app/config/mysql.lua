--
-- mysql config
-- User: leandre
-- Date: 16/2/1
-- Time: 上午11:21
--

local _P = {
    alpha = {
        master = {
            host = "127.0.0.1",
            port = "3306",
            user = "root",
            password = "root",
            database = "test"
        },
        slave = {
            host = "127.0.0.1",
            port = "3306",
            user = "root",
            password = "root",
            database = "test"
        }
    }
}
return _P