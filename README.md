# HexOBinary
Convert strings and numbers into Binary, Octal and Hexadecimal!!

Example Code:

```lua
local HexOBinary = require(path.to.module)

local encoder = HexOBinary.new()

local hex = encoder:Hexadecimal('Hello World!') --> 48 65 6C 6C 6F 20 57 6F 72 6C 64 21
print(encoder:Decode()) --> Hello World!
```