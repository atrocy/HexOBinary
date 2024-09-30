-- made this store module so the module only needed to calculate the characters only once in the entire run time!!

local stored = {}
local Types = require(script.Parent.Types)

type option = Types.option

function stored:apply(char: string|number, option: option, value: string|number)
    if not self[char] then self[char] = {binary = false, octal = false, hexadecimal = false} end
    if self[char][option] == nil then return end

    self[char][option] = value
end

function stored:get(char: string|number, option: option?)
    if self[char] then
        if option then return self[char][option] else return self[char] end
    end
end

return stored