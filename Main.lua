local Data = require("fs").readFileSync("./Data")

local function ReadFile(TeleData)

    local function Split(TheString, Decr)
        Lines = {}
        for s in TheString:gmatch("[^" .. Decr .. "]+") do
            table.insert(Lines, s)
        end
        return Lines
    end

    local function Parse(ToParse)
        local ToReturn = {}
        for i, v in pairs(ToParse) do
            table.insert(ToReturn, string.sub(v, 5))
        end
        return ToReturn
    end

    local function ParseData(ToParse)
        local ToReturn = {}
        for i, v in pairs(ToParse) do
            local ParsedString = Split(v, "(")
            local Key = ParsedString[1]
            table.remove(ParsedString, 1)

            for u, b in pairs(ParsedString) do
                ParsedString[u] = tonumber(Split(Split(b, ")")[1], "*")[1])
            end

            ToReturn[Key] = ParsedString
        end
        return ToReturn
    end

    local DataTable = Split(TeleData, "\n")
    
    table.remove(DataTable, 1)
    table.remove(DataTable, 1)
    table.remove(DataTable, #DataTable)

    local ParsedDataTable = Parse(DataTable)
    local KeyParsed = ParseData(ParsedDataTable)

    

    return KeyParsed

end

local Dat = ReadFile(Data)

for i, v in pairs(Dat) do
    print("Key", i)
    for u, b in pairs(v) do
        print(u, b)
    end
end