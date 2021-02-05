ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('cvc:aviso')
AddEventHandler('cvc:aviso', function(location, msg, x, y, z, type)
	local _source = source
	--print("Aviso tipo: "..type.." Mandado por: ".._source)

	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'mechanic' then
			Meca = xPlayer.source
			if type == 'ayudameca' then
				local playername = GetPlayerName(_source)
				local ped = GetPlayerPed(_source)
				local mensaje = '^*^4Ayuda Mecánico | Steam Name: ^r' .. playername .. '^*^4 | Sitio: ^r' .. location .. '^*^4 | Motivo: ^r' .. msg
				local mensajeNotification = '~r~[Entorno] ~w~Sitio: ' .. location .. '<br>Reporte: ' .. msg
				local type = 'ayudameca'
				
				TriggerClientEvent('cvc:setBlip', Meca, x, y, z)
				TriggerClientEvent('chatMessage', Meca, mensaje)
				TriggerClientEvent('esx:showNotification', Meca, mensajeNotification)
			end
		end
	end	
end)

