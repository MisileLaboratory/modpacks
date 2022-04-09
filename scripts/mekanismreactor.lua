reactormodems = {0, 1, 3, 8, 6, 2, 7, 5, 4}
reactors = {}
reactornumber = 1
numberofstring = 6
-- full screen width is 51, height is 19
for i, i2 in ipairs(reactormodems) do
	reactors[i] = peripheral.wrap("fissionReactorLogicAdapter_" .. i2)
end

while True do
	for i in reactormodems do
		local damage = getDamagePercent(i)
		damagestring = "not meltdown"
		if damage < 10 then
			if redstone.getOutput("back") then
				redstone.setOutput("back", false)
			end
		elseif damage >= 10 and damage < 30 then
			damagestring = "maybe meltdown"
		elseif getDamagePercent(i) >= 30 and getDamagePercent(i) < 50 then
			damagestring = "meltdown"
			redstone.setOutput("back", false)
		elseif getDamagePercent(i) >= 40 then
			i.scram()
		end
	end
	print("===================================================")
	print("                        reactor: " .. tostring(reacotrnumber))
	print("                        status: " .. getStatusString(i))
	print("                        damage status: " .. damagestring)
	print("                        damage percent: " .. tostring(i.getDamagePercentage()))
	print("===================================================")
	for _=1,numberofstring do
		print("                                               ")
	end
	
	os.sleep(0.5)
end

function getDamagePercent(reactor) 
	if reactor.isForceDisabled() == true or reactor.getStatus() == false then
		return 0
	else
		return reactor.getDamagePercentage()
	end
end

function getStatusString(reactor)
	if reactor.isForceDisabled() then
		return "Force disabled"
	elseif reactor.getStatus() == true then
		return "enabled"
	else 
		return "disabled"
	end
end