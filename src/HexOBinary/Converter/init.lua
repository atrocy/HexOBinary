local converter = {}
local StoredChars = require(script.Parent.StoredChars)
local Types = require(script.Parent.Types)

type option = Types.option

local options = {
    binary = 2,
    octal = 8,
    hexadecimal = 16
}

local hex = {
    [10] = 'A',
    [11] = 'B',
    [12] = 'C',
    [13] = 'D',
    [14] = 'E',
    [15] = 'F'
}

local hexnum = {
    ['A'] = 10,
    ['B'] = 11,
    ['C'] = 12,
    ['D'] = 13,
    ['E'] = 14,
    ['F'] = 15
}

local floor = math.floor

function converter.isChar(num: number)
    return (string.char(num) == '' and num) or string.char(num)
end

function converter.convert(input: string|number, option: option): string
    if not option then error('Provide an option.') return end
    if not input then error('Please provide an input to convert.') return end
    input = tostring(input)

    local optionNum = options[option]

    local result = ""
    local char_binary = ""

    local division_num = nil
    -- local firstchar = true

    local exit = false

    for char in input:gmatch('.') do
        if StoredChars:get(char, option) then result = result..StoredChars:get(char, option)..' ' continue end
        local byte = division_num or char:byte()

        while not exit do
            local old = division_num or byte
            division_num = floor((division_num or byte)/optionNum)

            local num = old-(division_num*optionNum)

            char_binary = char_binary..(hex[num] or num)

            -- add and not firstchar if something breaks :sob:
            if division_num < optionNum then exit = true char_binary = char_binary..(hex[division_num] or division_num) end

            -- firstchar = false
        end
        char_binary = char_binary:reverse()
        
        result = result..char_binary..' '
        StoredChars:apply(char, option, char_binary)

        exit = false
        division_num = nil
        -- firstchar = true
        char_binary = ""
    end

    return result:sub(1, -2)
end

function converter.decode(input: string, option: option): string|number
    if not option then error('Provide an option.') return end
    if not input then error('Please provide an input to decode.') return end

    local optionNum = options[option]

    local result = ""
    local charNum = 0

    local t = input:split(' ')

    for _, encoded in t do
        local charIndex = #encoded-1

        for i = 1, #encoded do
            local char = encoded:sub(i, i)
            local num = tonumber(char) or hexnum[char]
            if num == 0 then charIndex -= 1 continue end

            charNum += num*optionNum^charIndex
            charIndex -= 1
        end

        result = result..string.char(charNum)
        charNum = 0
    end

    return tonumber(result) or result
end

return converter