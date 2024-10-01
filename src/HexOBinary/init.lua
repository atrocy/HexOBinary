--[[
    Made by Romazka57(aka atrocy/cheez1i)
    #HexOBinary - Convert input into Binary, Octal and Hexadecimal

    Documentation can be read in https://github.com/atrocy/HexOBinary/wiki !
]]

local hexobinary = {}
hexobinary.__index = hexobinary

--Constants--
local DEFAULT_SEPARATOR = ' '

--Random--
local Rand = Random.new()

--Modules--
local Converter = require(script.Converter)
local Types = require(script.Types)

--Types--
type option = Types.option

--Constructors--
function hexobinary.new()
    local self = setmetatable({}, hexobinary)

    self.action = 'none'
    self.encoded = 0
    self.space_encoded = 0

    return self
end

--Decoders--
function hexobinary:Decode(): string|number
    return Converter.decode(self:Get(true), self.action)
end

--Convertions--
function hexobinary:Binary(input: string|number, separator: string?)
    local converted = Converter.convert(input, 'binary')
    self.space_encoded = converted
    self.encoded = converted:gsub(' ', separator or DEFAULT_SEPARATOR or '')
    self.action = 'binary'

   return converted
end

function hexobinary:Octal(input: string|number, separator: string?)
    local converted = Converter.convert(input, 'octal')
    self.space_encoded = converted
    self.encoded = converted:gsub(' ', separator or DEFAULT_SEPARATOR or '')
    self.action = 'octal'

    return converted
end

function hexobinary:Hexadecimal(input: string|number, separator: string?)
    local converted = Converter.convert(input, 'hexadecimal')
    self.space_encoded = converted
    self.encoded = converted:gsub(' ', separator or DEFAULT_SEPARATOR or '')
    self.action = 'hexadecimal'

    return self:Get()
end

-- function hexobinary:Random(input: string|number)
--     local chosen = Rand:NextInteger(1,3)
    
-- end

--Getters--
function hexobinary:Get(getWithSpaces: boolean?): string --returns the converted value
    return (getWithSpaces and self.space_encoded) or self.encoded
end

--Non-Object Convertions (less features)--
function hexobinary.Convert(input: string|number, option: option, separator: string?)
    local converted = Converter.convert(input, option)
    converted = converted:gsub(' ', separator or DEFAULT_SEPARATOR or ' ')

    return converted
end

function hexobinary.Deconvert(converted: string, option: option, usingSeparator: string?)
    converted = converted:gsub(usingSeparator or DEFAULT_SEPARATOR or ' ', DEFAULT_SEPARATOR or ' ')
    local deconverted = Converter.decode(converted, option)

    return deconverted
end

return hexobinary