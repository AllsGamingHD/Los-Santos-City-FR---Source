Citizen.CreateThread(function()
local hospitalPickup = {
	{x= 1839.03, y= 3673.25, z=34.28}
}

local hospitals = {
	{id=61, x= 1839.6, y= 3672.93, z= 34.28}
}

-- Create blips on the map for all the hospitals
for _, map in pairs(hospitals) do
	map.blip = AddBlipForCoord(map.x, map.y, map.z)
	SetBlipSprite(map.blip, map.id)
	SetBlipAsShortRange(map.blip, true)
end

-- Spawn the pickup items
for _, item in pairs(hospitalPickup) do
	pickup = CreatePickup(GetHashKey("PICKUP_HEALTH_STANDARD"), item.x, item.y, item.z)
end

end)