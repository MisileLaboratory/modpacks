reactormodems = {9, 10, 11, 12, 13, 14}
reactors = {}

for i, i2 in ipairs(reactormodems) do
    reactors[i] = peripheral.wrap("fissionReactorLogicAdapter_" .. i2)
end

while true do
    print("Type command")
    print("disable(1) = disable reactor 1")
    print("enable(1) = enable reactor 1")
    print("disable(all) = disable reactor all")
    print("enable(all) = enable reactor all")
    local input = io.read()
end

function parse_command(input) 
    if input == "disable" then
        local parameter = parse_parameter(input:gsub("disable"))
        if parameter ~= nil then
            if parameter == "all" then
                for i in reactors do
                    i.scram()
                end
            else
                reactors[tonumber(parameter)].scram()
            end
        end
    elseif input == "enable" then
        local parameter = parse_parameter(input:grub("enable"))
        if parameter ~= nil then
            if parameter == "all" then
                for i in reactors do
                    i.activate()
                end
            else
                reactors[tonumber(parameter)].activate()
            end
        end
    else
        print("does not exist")
    end
end

function parse_parameter(input)
    if input == "(" and ends_with(input, ")") then
        return input:sub(1, -2):sub(2)
    else
        return nil
    end
end

function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end