local HWIDS = {}

function HWIDS.getDevelopers()
	return {
		"yomaxify",
		"jahibii",
		"L3ARNT",
	}
end

function HWIDS.KEYHWID()
	return {
		["22546EE2-F5D6-4271-8575-67299BEA5DCF"] = "dev",
		["D4F0CA54-889E-4BEB-BE49-2DABECCF1FB0"] = "Q8vcDQnWY2",
	}
end

function HWIDS.generateKey()
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	local key = ""
	for i = 1, 10 do
		local randomIndex = math.random(1, #chars)
		key = key .. chars:sub(randomIndex, randomIndex)
	end
	return key
end

return HWIDS
