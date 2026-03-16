local translate_mod = {}

-- Store our loaded translation tables here
translate_mod.locales = {}
translate_mod.current_locale = "en" -- default fallback

-- Load a table directly into the locale registry
function translate_mod.load_locale(locale_code, data_table)
    translate_mod.locales[locale_code] = data_table
end

-- Load multiple locales at once
function translate_mod:load_locales(locales_table)
    for code, data in pairs(locales_table) do
        self.load_locale(code, data)
    end
end

-- Change the current global locale
function translate_mod.set_locale(locale_code)
    translate_mod.current_locale = locale_code
end

-- The main translation function similar to Rails I18n.t()
-- Usage: tl("activemodel.errors.models.character.attributes.health.blank", { model = "Pechan" })
function translate_mod.tl(key, vars)
    -- 1. Get the current dictionary
    local locale_data = translate_mod.locales[translate_mod.current_locale]

    -- If we don't have the locale loaded, just return the raw key
    if not locale_data then return key end

    -- 2. Traverse the dictionary using the dot notation ("a.b.c" -> table["a"]["b"]["c"])
    -- Check if the table has a root key equivalent to our locale (like Rails YAML usually does)
    local node = locale_data[translate_mod.current_locale] or locale_data

    for part in string.gmatch(key, "[^%.]+") do
        if type(node) == "table" and node[part] ~= nil then
            node = node[part]
        else
            -- Translation missing, return a descriptive string as a fallback
            return "Translation missing: " .. translate_mod.current_locale .. "." .. key
        end
    end

    -- 3. If the final value is a string, process variable interpolation %{like_this}
    if type(node) == "string" then
        local str = node
        if vars and type(vars) == "table" then
            str = string.gsub(str, "%%{(.-)}", function(var_name)
                -- If the variable exists in our 'vars' table, inject it. Otherwise leave it as is.
                return vars[var_name] and tostring(vars[var_name]) or "%{" .. var_name .. "}"
            end)
        end
        return str
    end

    -- If it points to an incomplete tree (a table instead of a string value)
    return "Invalid translation key (points to table): " .. key
end

return translate_mod
