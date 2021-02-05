displayTime = 300 

ESX = nil

blip = nil
blips = {}
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
end)

function loadESX()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(0)
	end
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('cvc:setBlip')
AddEventHandler('cvc:setBlip', function(x, y, z)
	loadESX()
	blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 78) -- Id del blip
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 3)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Aviso')
	EndTextCommandSetBlipName(blip)
	table.insert(blips, blip)
	Wait(displayTime * 1000)
	for i, blip in pairs(blips) do 
		RemoveBlip(blip)
	end
end)

RegisterNetEvent('cvc:sendMugshot')
AddEventHandler('cvc:sendMugshot', function(msg, type, robber)
	loadESX()
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(robber)))

	UnregisterPedheadshot(mugshot)
	ESX.ShowAdvancedNotification("Alarma de mecánico", "Ayuda", msg, mugshotStr, 4)
end)

RegisterCommand('ayudameca', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local street = GetStreetNameAtCoord(x, y, z)
    local location = GetStreetNameFromHashKey(street)
	local msg = table.concat(args, ' ')
	local tipo = 'ayudameca'
    if args[1] == nil then
        TriggerEvent('chatMessage', '^5ayudamecánico', {255,255,255}, ' ^7Por favor indica la *1ayuda del mecánico.')
	else
		TriggerEvent('chatMessage', '', {255,255,255}, '^8 [OOC] Has envíado una señal de ayuda al mecánico.')
		TriggerServerEvent('cvc:aviso', location, msg, x, y, z, tipo)
    end
end)
-- Si no funciona, poner esto: end, false)