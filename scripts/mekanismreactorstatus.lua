reactormodems = {9, 10, 11, 12, 13, 14}
reactors = {}
reactornumber = 1
numberofstring = 19 + 5
numberofstring = 95 - numberofstring
consolestring = ""
-- full screen height is 19
for i, i2 in ipairs(reactormodems) do
    reactors[i] = peripheral.wrap("fissionReactorLogicAdapter_" .. i2)
end
 
function getDamagePercent(reactor) 
    if reactor.isForceDisabled() == true or reactor.getStatus() == false then
        return 0
    else
        return reactor.getDamagePercentage()
    end
end
 
function getStatusString(reactor)
    if reactor.isForceDisabled() == true then
        return "force disabled"
    elseif reactor.getStatus() == true then
        return "enabled"
    else 
        return "disabled"
    end
end
 
function isHighSteam(turbine)
    if turbine.getSteamFilledPercentage() <= 60 then
        return true
    else
        return false
    end
end
 
while true do
    local turbine = peripheral.wrap("turbineValve_0")
    local highenergy = isHighSteam(turbine)
    for i2 in reactors do
        if highenergy == true and i2.getStatus() == false then
            i2.scram()
        end
    end
    reactor = reactors[reactornumber]
    if reactor ~= nil then
        local damage = getDamagePercent(reactor)
        damagestring = "not meltdown"
        if damage < 5 then
            if redstone.getOutput("front") then
                redstone.setOutput("front", false)
            end
        elseif damage >= 5 and damage < 30 then
            damagestring = "meltdown"
            redstone.setOutput("back", true)
        end
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
        print("turbine steam amount:" .. tostring(turbine.getSteam()) .. "/" .. tostring(turbine.getSteamCapacity()))
        print("turbine steam percentage" .. tostring(turbine.getSteamFilledPercentage()))
        for _=1,numberofstring do
            print("                                               ")
        end
    else
        print("reactor is nil")
    end
    os.sleep(0.5)
end