--
-- memcached
-- User: leandre
-- Date: 16/3/25
-- Time: 12:48
--
local _M = {}
local _config = {}

--- init memcache config
--
function _M:init()
    local app_path = 'app.'
    _config = require(app_path .. "config.memcache")
    return _config
end

--- connect to memcache
-- @param pool_name
-- @param is_slave
--
function _M:connect(pool_name)
    local memcached = require "resty.memcached"
    local memc, err = memcached:new()
    if not memc then
        return ngx.ERROR, err
    end

    memc:set_timeout(1000) -- 1 sec

    -- or connect to a unix domain socket file listened
    -- by a memcached server:
    --     local ok, err = memc:connect("unix:/path/to/memc.sock")

    local ok, err = memc:connect(_config[pool_name]['host'], _config[pool_name]['port'])
    if not ok then
        return ngx.ERROR, err
    end

    return memc
end

--- get
-- @param key
-- @param poolname
--
function _M:get(key, poolname)
    if key == "" then
        return ngx.ERROR
    end

    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, flags, err0 = memc:get(key)

    -- put it into the connection pool of size 100,
    -- with 10 seconds max idle timeout
    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, flags, err0
end

--- gets
-- @param keys
-- @param poolname
--
function _M:gets(keys, poolname)
    if key == "" then
        return ngx.ERROR
    end

    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:gets(keys)

    -- put it into the connection pool of size 100,
    -- with 10 seconds max idle timeout
    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, err0
end

--- set
-- @param key
-- @param value
-- @param exptime
-- @param flags
-- @param poolname
--
function _M:set(key, value, exptime, flags, poolname)
    if key == "" or value == "" then
        return ngx.ERROR
    end

    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:set(key, value, exptime, flags)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, flags, err0
end

--- get reused times for the current connection
-- @param poolname
--
function _M:get_reused_times(poolname)
    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local times, err = memc:get_reused_times()

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return times, err
end

--- close a connect
-- @param poolname
--
function _M:close(poolname)
    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    return memc:close()
end

--- add
-- Inserts an entry into memcached if and only if the key does not exist
-- @param key
-- @param value
-- @param exptime
-- @param flags
-- @param poolname
--
function _M:add(key, value, exptime, flags, poolname)
    if key == "" or value == "" then
        return ngx.ERROR
    end

    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:add(key, value, exptime, flags)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, flags, err0
end

--- replace
-- Inserts an entry into memcached if and only if the key does exist
-- @param key
-- @param value
-- @param exptime
-- @param flags
-- @param poolname
--
function _M:replace(key, value, exptime, flags, poolname)
    if key == "" or value == "" then
        return ngx.ERROR
    end

    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:replace(key, value, exptime, flags)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, flags, err0
end

--- append
-- Appends the value to an entry with the same key that already exists in memcached
-- @param key
-- @param value
-- @param exptime
-- @param flags
-- @param poolname
--
function _M:append(key, value, exptime, flags, poolname)
    if key == "" or value == "" then
        return ngx.ERROR
    end

    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:append(key, value, exptime, flags)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, flags, err0
end

--- prepend
-- Prepends the value to an entry with the same key that already exists in memcached
-- @param key
-- @param value
-- @param exptime
-- @param flags
-- @param poolname
--
function _M:prepend(key, value, exptime, flags, poolname)
    if key == "" or value == "" then
        return ngx.ERROR
    end

    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:prepend(key, value, exptime, flags)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, flags, err0
end

--- touch
-- Update the expiration time of an existing key
-- @param key
-- @param exptime
-- @param poolname
--
function _M:touch(key, exptime, poolname)
    if key == "" or exptime == "" then
        return ngx.ERROR
    end

    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:touch(key, exptime)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, err0
end

--- Flushes all the keys in the memcached server immediately (by default)
--- or after the expiration specified by the time argument (in seconds)
-- @param time
-- @param poolname
--
function _M:flush_all(time, poolname)
    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:flush_all(time)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, err0
end

--- Deletes the key from memcached immediately
-- @param key
-- @param poolname
--
function _M:delete(key, poolname)
    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:delete(key)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, err0
end

--- Increments the value of the specified key by the integer value specified in the delta argument
-- @param key
-- @param delta
-- @param poolname
--
function _M:incr(key, delta, poolname)
    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:incr(key, delta)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, err0
end

--- Decrements the value of the specified key by the integer value specified in the delta argument
-- @param key
-- @param delta
-- @param poolname
--
function _M:decr(key, delta, poolname)
    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:decr(key, delta)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, err0
end

--- Returns memcached server statistics information with an optional args argument
-- Possible args argument values are items, sizes, slabs, among others
-- @param args
-- @param poolname
--
function _M:stats(args, poolname)
    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:stats(args)
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, err0
end

--- Returns the server version number, like 1.2.8
-- @param poolname
--
function _M:version(poolname)
    local poolname = poolname or "default"

    local memc, err = self:connect(poolname)

    if memc == ngx.ERROR then
        return ngx.ERROR, err
    end

    local res, err0 = memc:version()
    if not res then
        return ngx.ERROR, err0
    end

    local ok, err1 = memc:set_keepalive(10000, 100)
    if not ok then
        return ngx.ERROR, err1
    end

    return res, err0
end

return _M
