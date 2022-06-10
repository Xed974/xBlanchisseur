Citizen.CreateThread(function()
    local hash = GetHashKey("ig_ortega")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", "ig_ortega", 915.6, -1703.59, (51.26)-1, 0.79, false, true)
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)