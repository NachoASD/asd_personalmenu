--------------------------
---By NachoASD @2020   ---
---NachoASD#5887       ---
--------------------------
local patata       = 1
ESX                = nil
local PlayerData   = {}
local firstname    = "Null"
local lastname     = "Null"
local birthday     = "Null"
local sex          = "Null"
local altura       = "Null"

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  	PlayerData.job = job
end)

RegisterNetEvent("GetPlayerData")
AddEventHandler("GetPlayerData", function(data)
    if data == nil then
        return
    end
    lastname  = data[1].lastname
    firstname = data[1].firstname
    birthday  = data[1].dateofbirth
    sex       = data[1].sex
    altura    = data[1].height
end)

---------------------------------------------------------------------------
-- HOW TO USE THE FUNCTIONS
---------------------------------------------------------------------------

function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

function GetPlayerFromPed(ped)
	for a = 0, 64 do
		if GetPlayerPed(a) == ped then
			return a
		end
	end
	return -1
end

--- Menu ---

local isMenuOpen = false

local options = {
    {label = "Ver tu DNI", value = 'see_dni'},
}

function OpenMenu()
    isMenuOpen = true

    ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'ASD_personalMenu', -- Replace the menu name
  {
        title    = ('ASD_personal'),
        align = 'top-left', -- Menu position
        elements = options
    }, function(data, menu)
        if data.current.value == 'back' then
            menu.close()
            isMenuOpen = false
            ChangeDNI(false)
            Citizen.Wait(50)
            OpenMenu()
        end
        if data.current.value == 'see_dni' then
            menu.close()
            isMenuOpen = false
            ChangeDNI(true)
            Citizen.Wait(50)
            OpenMenu()
        end
        if data.current.value == 'info' then
            ESX.ShowNotification('Unete a nuestro discord: '.. Config.Discord, false, false, 200)
            menu.close()
            isMenuOpen = false
        end
    end,
    function(data, menu) --- Close menu
        menu.close()
        isMenuOpen = false
    end)

end

--- ---- ---
Citizen.CreateThread(function()
    TriggerServerEvent('GetPlayerData')
    while true do
        TriggerServerEvent('GetPlayerData')
        Citizen.Wait(60000)
        TriggerServerEvent('GetPlayerData')
    end
end)

Citizen.CreateThread(function()
    while true do
        local _char = PlayerPedId()
        if IsControlJustPressed(0, Config.Input) and not isMenuOpen then
            print("Abrir")
            OpenMenu()
        end
        if IsControlJustPressed(0, 38) then
            local ped = GetPedInFront()

            if ped ~= 0 then
                local pedPlayer = GetPlayerFromPed(ped)
                if pedPlayer ~= -1 then
                    print("PLAYER CLIENT ID: " .. pedPlayer)
                    print("PLAYER SERVER ID: " .. GetPlayerServerId(pedPlayer))
                end
            end
        end
        Citizen.Wait(0)
    end
end)    

function ChangeDNI(value)
    if value then
        options = {
            {label = "Nombre: ".. firstname, value = ''},
            {label = "Apellido: ".. lastname, value = ''},
            {label = "Fecha de nacimiento: ".. birthday, value = ''},
            {label = "Sexo: ".. sex, value = ''},
            {label = "Altura: ".. altura, value = ''},
            {label = "@NachoASD ", value = 'info'},
            {label = "Volver ", value = 'back'},
        }
    else
        options = {
            {label = "Ver tu DNI", value = 'see_dni'},
        }
    end
end