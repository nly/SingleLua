-- https://github.com/bungle/lua-resty-fileinfo/
local setmetatable = setmetatable
local ipairs       = ipairs
local assert       = assert
local type         = type
local ffi          = require "ffi"
local ffi_load     = ffi.load
local ffi_gc       = ffi.gc
local ffi_str      = ffi.string
local ffi_cdef     = ffi.cdef
local bit          = require "bit"
local bor          = bit.bor

ffi_cdef[[
typedef struct magic_set *magic_t;
magic_t magic_open(int);
void magic_close(magic_t);
const char *magic_getpath(const char *, int);
const char *magic_file(magic_t, const char *);
const char *magic_descriptor(magic_t, int);
const char *magic_buffer(magic_t, const void *, size_t);
const char *magic_error(magic_t);
int magic_setflags(magic_t, int);
int magic_version(void);
int magic_load(magic_t, const char *);
int magic_compile(magic_t, const char *);
int magic_check(magic_t, const char *);
int magic_list(magic_t, const char *);
int magic_errno(magic_t);
]]

local flgs = {
    none              = 0x000000,
    debug             = 0x000001,
    symlink           = 0x000002,
    compress          = 0x000004,
    devices           = 0x000008,
    mime_type         = 0x000010,
    continue          = 0x000020,
    check             = 0x000040,
    preserve_atime    = 0x000080,
    raw               = 0x000100,
    error             = 0x000200,
    mime_encoding     = 0x000400,
    mime              = bor(0x000010, 0x000400),
    apple             = 0x000800,
    no_check_compres  = 0x001000,
    no_check_tar      = 0x002000,
    no_check_soft     = 0x004000,
    no_check_apptype  = 0x008000,
    no_check_elf      = 0x010000,
    no_check_text     = 0x020000,
    no_check_cdf      = 0x040000,
    no_check_tokens   = 0x100000,
    no_check_encoding = 0x200000
}

local lib = ffi_load "magic"

local function getflags(flags)
    local t = type(flags)
    local f = 0
    if t == "number" then
        f = flags
    elseif t == "table" then
        for _, v in ipairs(flags) do
            if type(v) == "number" then
                f = bor(v, f)
            else
                f = bor(flags[v] or 0, f)
            end
        end
    end
    return f
end

local fileinfo = { version = lib.magic_version(), flags = flgs }

fileinfo.__index = fileinfo

function fileinfo:__call(path, flags, magic)
    if self.context then
        return self:file(path, flags)
    else
        local context = ffi_gc(lib.magic_open(getflags(flags)), lib.magic_close)
        assert(lib.magic_load(context, magic) == 0 , "Unable to load magic database.")
        local value = lib.magic_file(context, path)
        if value == nil then
            return nil
        else
            return value == nil and false or ffi_str(value)
        end
    end
end

function fileinfo.new(flags, magic)
    local self = setmetatable({ context = ffi_gc(lib.magic_open(getflags(flags)), lib.magic_close) }, fileinfo)
    assert(self:load(magic), "Unable to load magic database.")
    return self
end

function fileinfo:file(path, flags)
    if flags then
        self:setflags(flags)
    end
    local value = lib.magic_file(self.context, path)
    return value == nil and false or ffi_str(value)
end

function fileinfo:buffer(str, flags)
    if flags then
        self:setflags(flags)
    end
    local value = lib.magic_buffer(self.context, str, #str)
    return value == nil and false or ffi_str(value)
end

function fileinfo:setflags(flags)
    return lib.magic_setflags(self.context, getflags(flags)) == 0
end

function fileinfo:load(path)
    return lib.magic_load(self.context, path) == 0
end

function fileinfo:compile(path)
    return lib.magic_compile(self.context, path) == 0
end

function fileinfo:check(path)
    return lib.magic_check(self.context, path) == 0
end

function fileinfo:list(path)
    return lib.magic_list(self.context, path) == 0
end

function fileinfo:errno()
    return lib.magic_errno(self.context)
end

return setmetatable({}, fileinfo)