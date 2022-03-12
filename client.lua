QBCore = exports["qb-core"]:GetCoreObject()

local cooldown = false

local function DrawText3D(x, y, z, text) -- Draw text
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function spawnBike()
    local ped = PlayerPedId()    
    local hash = GetHashKey(Config.bikeModel)   
    if not IsModelInCdimage(hash) then 
        return 
    end    
    RequestModel(hash)    
    while not HasModelLoaded(hash) do 
        Wait(10) 
    end    
    local vehicle = CreateVehicle(hash, GetEntityCoords(ped), GetEntityHeading(ped), true, false)    
    TaskWarpPedIntoVehicle(ped, vehicle, -1)    
    SetModelAsNoLongerNeeded(vehicle)    
    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
    cooldown = true
    Wait(Config.cooldownTime)
    cooldown = false
end

local function callTaxi() -- Put your dispatch code here
    QBCore.Functions.TriggerCallback('kz-freebike:server:GetTaxi', function(cb)
    if cb >= 1 then
    local PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('dispatch:addCall', 
	"TAXI", -- CODE EX: 10-70, 10-71, 10-39 ...
	'Person requiring taxi',  -- YOU CAN ADD TITLE OF CALL
	{
		icon = 'fa-user-friends', -- ICON CAN YOU USE FROM https://fontawesome.com/
		message = 'Person requiring taxi ride', -- MESSAGE TO DISPLAY
		isUrgent = false, -- IF THAT IS TRUE IT WILL BE BLINKING
		phoneNumber = PlayerData.charinfo.phone -- You can display the phone number of the person who made the call here if it is a call; Or can be null
	},
	GetEntityCoords(PlayerPedId()),
	"taxi", -- JOB YOU WILL RECEIVE
	5000, -- TIMER TO SHOW IN DISPATCH IN MILLISECONDS
	280, -- BLIP SPRITE  https://docs.fivem.net/docs/game-references/blips/
	57, -- BLIP COLOR
	false -- IF IT IS TRUE IT WILL BE LIKE A PHONE CALL
    )

    QBCore.Functions.Notify("A request has been sent to the taxi company, please stay where you are.", "success")
    cooldown = true
    Wait(Config.cooldownTime)
    cooldown = false
    else
        QBCore.Functions.Notify("Sorry, there isnt any taxi drivers on duty. Try again later", "error")
    end
    end)
end

CreateThread(function() -- Main thread
	while cooldown == false do
		Wait(0)         
		for _, bike in pairs(Config.bikeLocations) do 
			local pos = GetEntityCoords(PlayerPedId())
            local distance = #(pos - bike)
            
			if distance <= 10 then
                DrawMarker(38, bike.x, bike.y, bike.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 255, 255, 255, 155, 0, 0, 0, 1, 0, 0, 0)
                if distance <= 2 then
                   if Config.taxiDispatch == true then 
                    DrawText3D(bike.x, bike.y, bike.z -0.1, "~g~E~w~ - Free bike </br> ~g~H~w~ - Call for a taxi ")
                   if IsControlJustReleased(0, 38) then
                    spawnBike()
                   elseif IsControlJustReleased(0, 74) then
                    callTaxi()
                    end
                    else
                        DrawText3D(bike.x, bike.y, bike.z -0.1, "~g~E~w~ - Free bike")
                        if IsControlJustReleased(0, 38) then
                         spawnBike()
                        end
                    end
                end    
            end
        end
    end
end)


