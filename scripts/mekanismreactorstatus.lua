reactormodems = {9, 10, 11, 12, 13, 14}
reactors = {}
reactornumber = 1
numberofstring = 13
numberofstring = 19 - numberofstring
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

function add_string(string, string2)
    return string .. string2 .. "\n"
end
 
while true do
    local turbine = peripheral.wrap("turbineValve_0")
    local highenergy = isHighSteam(turbine)
    for _, i2 in pairs(reactors) do
        if highenergy == true and i2.getStatus() == true then
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
        local a = ""
        a = add_string(a, "reactor: " .. tostring(reactornumber))
        a = add_string(a, "status: " .. getStatusString(reactor))
        a = add_string(a, "damage status: " .. damagestring)
        a = add_string(a, "damage percent: " .. tostring(reactor.getDamagePercent() * 100))
        a = add_string(a, "heat: " .. tostring(reactor.getTemperature()))
        a = add_string(a, "fuel amount: " .. tostring(reactor.getFuel()["amount"]) .. "/" .. tostring(reactor.getFuelCapacity()))
        a = add_string(a, "fuel percentage: " .. tostring(reactor.getFuelFilledPercentage() * 100))
        a = add_string(a, "coolant amount: " .. tostring(reactor.getCoolant()["amount"]) .. "/" .. tostring(reactor.getCoolantCapacity()))
        a = add_string(a, "coolant percentage: " .. tostring(reactor.getCoolantFilledPercentage() * 100))
        a = add_string(a, "waste amount: " .. tostring(reactor.getWaste()["amount"]) .. "/" .. tostring(reactor.getWasteCapacity()))
        a = add_string(a, "waste percentage: " .. tostring(reactor.getWasteFilledPercentage() * 100))
        a = add_string(a, "turbine steam amount:" .. tostring(turbine.getSteam()["amount"]) .. "/" .. tostring(turbine.getSteamCapacity()))
        a = add_string(a, "turbine steam percentage" .. tostring(turbine.getSteamFilledPercentage()))
        for _=1,numberofstring do
            add_string(a, "                                               ")
        end
        print(a)
    else
        print("reactor is nil")
    end
    os.sleep(0.5)
end