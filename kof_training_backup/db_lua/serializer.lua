local function serialize(o, indent)
    indent = indent or ""
    local t = type(o)

    if t == "number" or t == "boolean" then
        return tostring(o)
    elseif t == "string" then
        return string.format("%q", o)
    elseif t == "table" then
        local s = "{\n"
        for k, v in pairs(o) do
            s = s .. indent .. "  [" .. serialize(k) .. "] = " .. serialize(v, indent .. "  ") .. ",\n"
        end
        return s .. indent .. "}"
    else
        return "nil"
    end
end

return serialize
