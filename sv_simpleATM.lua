-- @Project: FiveM Tools
-- @License: GNU General Public License v3.0

RegisterServerEvent('ft_simpleATM:SvDespositMoney')
AddEventHandler('ft_simpleATM:SvDespositMoney', function(amount)

  TriggerEvent("ft_gamemode:SvGetPlayerData", source, "data", function (data)
    
    if tonumber(data.cash) >= amount then
      TriggerEvent('ft_simplebank:SvDespositMoney', source, math.floor(amount))
      
      TriggerClientEvent("ft_ui:ClNotification", source, "~h~Vous avez ~g~déposé~s~ "..tostring(amount).."$ dans votre ~b~compte bancaire~s~.")    
      
    else
			TriggerClientEvent("ft_ui:ClNotification", source, "~h~~r~Erreur~s~: Vous n'avez pas assez d'argent!")
    end
    
  end)
  
end)

RegisterServerEvent('ft_simpleATM:SvWithdrawBank')
AddEventHandler('ft_simpleATM:SvWithdrawBank', function(amount, taxe)

  TriggerEvent("ft_gamemode:SvGetPlayerData", source, "data", function (data)
   
    if tonumber(data.bank) >= amount then
      TriggerEvent('ft_simplebank:SvWithdrawBankMoney', source, math.floor(amount))
      
      TriggerClientEvent("ft_ui:ClNotification", source, "~h~Vous avez ~r~retiré~s~ "..tostring(amount).."$ de votre ~b~compte bancaire~s~.")
      
      if taxe ~= nil and taxe > 0 then
        taxeprice = math.floor(amount * (taxe * 0.01))
        TriggerEvent('ft_simplebank:SvRemoveBankMoney', source, taxeprice)
        TriggerClientEvent("ft_ui:ClNotification", source, "~y~Frais de transaction:~s~ "..tostring(taxeprice).."$")
      end 
      
    else
			TriggerClientEvent("ft_ui:ClNotification", source, "~h~~r~Erreur~s~: Vous n'avez pas assez d'argent!")
    end
    
  end)
  
end)

RegisterServerEvent('ft_simpleATM:SvTransferBank')
AddEventHandler('ft_simpleATM:SvTransferBank', function(targetid, amount, taxe)

  TriggerEvent("ft_gamemode:SvGetPlayerData", source, "data", function (data)
   
    if tonumber(data.bank) >= amount then
      TriggerEvent('ft_simplebank:SvTransferBankMoney', source, targetid, math.floor(amount))
      
      TriggerClientEvent("ft_ui:ClNotification", source, "~h~Vous avez ~r~transféré~s~ "..tostring(amount).."$ de votre ~b~compte bancaire~s~.")
      
      if taxe ~= nil and taxe > 0 then
        local taxeprice = math.floor(amount * (taxe * 0.01))
        TriggerEvent('ft_simplebank:SvRemoveBankMoney', source, taxeprice)
        TriggerClientEvent("ft_ui:ClNotification", source, "~y~Frais de transaction:~s~ "..tostring(taxeprice).."$")
      end
      
    else
			TriggerClientEvent("ft_ui:ClNotification", source, "~h~~r~Erreur~s~: Vous n'avez pas assez d'argent!")
    end
    
  end)
  
end)