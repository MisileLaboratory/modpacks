reactormodems = {9, 10, 11, 12, 13, 14}
reactors = {}
reactornumber = 1
numberofstring = 12 + 5
numberofstring = 19 - numberofstring
consolestring = ""
-- full screen width is 51, height is 19
for i, i2 in ipairs(reactormodems) do
    reactors[i] = peripheral.wrap("fissionReactorLogicAdapter_" .. i2)
end
 
function getDamagePercent(reactora) 
    if reactora.isForceDisabled() == true or reactora.getStatus() == false then
        return 0
    else
        return reactora.getDamagePercentage()
    end
end
 
function getStatusString(reactorb)
    if reactorb.isForceDisabled() == true then
        return "Force disabled"
    elseif reactorb.getStatus() == true then
        return "enabled"
    else 
        return "disabled"
    end
end
 
function isHighTemperature(reactorc)
    if reactorc.isForceDisabled() == false and reactorc.getStatus() == true and reactorc.getTemperature() >= 1000 then
        return true
    else
        return false
    end
end
 
while true do
 os.startTimer(0.5)
    event = {os.pullEvent()}
    if event[1] == "key" then
        local a, key, b = unpack(event)
  print(key)
        key = keys.getName(key)
    else
        key = nil
    end
    local timeout = os.startTimer(1)
    for i, i2 in ipairs(reactors) do
        if isHighTemperature(i2) == true then
            i2.scram()
        end
    end
    reactor = reactors[reactornumber]
    if reactor ~= nil then
        local damage = getDamagePercent(reactor)
        damagestring = "not meltdown"
        if damage < 10 then
            if redstone.getOutput("front") then
                redstone.setOutput("front", false)
            end
        elseif damage >= 10 and damage < 30 then
            damagestring = "meltdown"
            redstone.setOutput("back", true)
        end
        print("===================================================")
        print("reactor: " .. tostring(reactornumber))
        print("status: " .. getStatusString(reactor))
        print("damage status: " .. damagestring)
        print("damage percent: " .. tostring(reactor.getDamagePercent() * 100))
        print("heat: " .. tostring(reactor.getTemperature()))
        print("fuel amount: " .. tostring(reactor.getFuel()["amount"]) .. "/" .. tostring(reactor.getFuelCapacity()))
        print("fuel percentage: " .. tostring(reactor.getFuelFilledPercentage() * 100))
        print("coolant amount: " .. tostring(reactor.getCoolant()["amount"]) .. "/" .. tostring(reactor.getCoolantCapacity()))
        print("coolant percentage: " .. tostring(reactor.getCoolantFilledPercentage() * 100))
        print("waste amount: " .. tostring(reactor.getWaste()["amount"]) .. "/" .. tostring(reactor.getWasteCapacity()))
        print("waste percentage: " .. tostring(reactor.getWasteFilledPercentage() * 100))
        print("===================================================")
        if key ~= nil then
            if key == "enter" then
                if consolestring == "select " then
                    reactornumber = tonumber(consolestring:gsub('select ', ''))
                elseif consolestring == "disable " then
                    reactor.scram()
                elseif consolestring == "enable " then
                    reactor.activate()
                end
                consolestring = ""
            elseif key == "backspace" then
                consolestring = consolestring:sub(1, -2)
            else
                consolestring = consolestring .. key
            end
        end
        if consolestring ~= "" then
            print("                                               ")
        else
            print(consolestring)
        end
        for _=1,numberofstring do
            print("                                               ")
        end
    else
        print("reactor is nil")
    end
end