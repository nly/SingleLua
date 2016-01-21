--
-- Created by IntelliJ IDEA.
-- User: leandre
-- Date: 16/1/13
-- Time: 下午1:47
--

local _M = { _VERSION = 0.1 }

--- string explode
-- @param split_char
-- @param str
--
function _M.lua_string_split(split_char, str)
    local sub_str_tab = {};
    local i = 0;
    local j = 0;
    while true do
        j = string.find(str, split_char, i + 1);
        if j == nil then
            table.insert(sub_str_tab, string.sub(str, i + 1));
            break;
        end;
        table.insert(sub_str_tab, string.sub(str, i + 1, j - 1));
        i = j;
    end
    return sub_str_tab;
end

--- print array
-- @param arr
--
function _M.print_arr(arr)
    for key, val in ipairs(arr) do
        if type(val) == "table" then
            ngx.say(key, ": ", table.concat(val, ", "))
        else
            ngx.say(key, ": ", val)
        end
    end
end

--- filter empty array
-- @param arr
--
function _M.array_filter(arr)
    local sub_tab = {};
    for key, val in ipairs(arr) do
        if val ~= "" then
            table.insert(sub_tab, val)
        end
    end
    return sub_tab
end

--- implode arr to string
-- @param split_char
-- @param arr
--
function _M.lua_string_merge(split_char, arr)
    return table.concat(arr, split_char)
end

return _M