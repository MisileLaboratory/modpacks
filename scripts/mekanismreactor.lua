reactormodems = {0, 1, 3, 8, 6, 2, 7, 5, 4}
reactors = {}
reactornumber = 1
numberofstring = 13
numberofstring = 19 - numberofstring
consolestring = ""
-- full screen width is 51, height is 19
for i, i2 in ipairs(reactormodems) do
	reactors[i] = peripheral.wrap("fissionReactorLogicAdapter_" .. i2)
end

while true do
	event = {os.pullEvent()}
	if event[1] == "key" then
		local _, key, _ = event[1]
		key = keys.getName(key)
	else
		key = nil
	end
	local timeout = os.startTimer(1)
	for i in reactormodems do
		if isHighTemperature(i) == true then
			i.scram()
		end
	end
	local reactor = reactormodems[reactornumber]
	if reactor ~= nil then
		local damage = getDamagePercent(reactor)
		damagestring = "not meltdown"
		if damage < 10 then
			if redstone.getOutput("back") then
				redstone.setOutput("back", false)
			end
		elseif damage >= 10 and damage < 30 then
			damagestring = "meltdown"
			redstone.setOutput("back", true)
		end
		print("===================================================")
		print("                        reactor: " .. tostring(reacotrnumber))
		print("                        status: " .. getStatusString(i))
		print("                        damage status: " .. damagestring)
		print("                        damage percent: " .. tostring(i.getDamagePercentage()))
		print("                        heat: " .. tostring(i.getTemperature()))
		print("                        fuel amount: " .. tostring(i.getFuel()) .. "/" .. tostring(i.getFuelCapacity()))
		print("                        fuel percentage: " .. tostring(i.getFuelFilledPercentage()))
		print("                        coolant amount: " .. tostring(i.getCoolant()) .. "/" .. tostring(i.getCoolantCapacity()))
		print("                        coolant percentage: " .. tostring(i.getCoolantFilledPercentage()))
		print("                        waste amount: " .. tostring(i.getWaste()) .. "/" .. tostring(i.getWasteCapacity()))
		print("                        waste percentage: " .. tostring(i.getWasteFilledPercentage()))
		print("===================================================")
		if key ~= nil then
			if key == "enter" then
				reactornumber = tonumber(consolestring)
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

function getDamagePercent(reactor) 
	if reactor.isForceDisabled() == true or reactor.getStatus() == false then
		return 0
	else
		return reactor.getDamagePercentage()
	end
end

function getStatusString(reactor)
	if reactor.isForceDisabled() == true then
		return "Force disabled"
	elseif reactor.getStatus() == true then
		return "enabled"
	else 
		return "disabled"
	end
end

function isHighTemperature(reactor)
	if reactor.isForceDisabled() == false and reactor.getStatus() == true and reactor.getTemperature() <= 1000 then
		return true
	else
		return false
	end
end