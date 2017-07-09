-- @Date:   2017-07-01T12:38:45+02:00
-- @Project: FiveM Tools
-- @Last modified time: 2017-07-06T22:42:30+02:00
-- @License: GNU General Public License v3.0

RegisterServerEvent('ft_simpleATM:SvDespositMoney')
AddEventHandler('ft_simpleATM:SvDespositMoney', function(amount, taxe)

  TriggerEvent("ft_gamemode:SvGetPlayerData", source, "data", function (data)
    
    if tonumber(data.cash) >= amount then
      TriggerEvent('ft_simplebank:SvDepositBankMoney', source, amount)
      
      if taxe ~= nil and taxe > 0 then
        taxeprice = amount * (taxe * 0.01)
        TriggerEvent('ft_simplebank:SvRemoveBankMoney', source, taxeprice)
        TriggerClientEvent("ft_ui:ClNotification", source, "~h~Vous avez ~g~déposé~s~ "..tostring(amount).."$ dans votre ~b~compte bancaire~s~~n~~y~Frais de transaction:~s~ "..tostring(taxeprice).."$")
      else
        TriggerClientEvent("ft_ui:ClNotification", source, "~h~Vous avez ~g~déposé~s~ "..tostring(amount).."$ dans votre ~b~compte bancaire~s~.")
      end
      
    else
			TriggerClientEvent("ft_ui:ClNotification", source, "~h~~r~Erreur~s~: Vous n'avez pas assez d'argent!")
    end
    
  end)
  
end)

RegisterServerEvent('ft_simpleATM:SvWithdrawBank')
AddEventHandler('ft_simpleATM:SvWithdrawBank', function(amount, taxe)

  TriggerEvent("ft_gamemode:SvGetPlayerData", source, "data", function (data)
   
    if tonumber(data.bank) >= amount then
      TriggerEvent('ft_simplebank:SvWithdrawBankMoney', source, amount)
      
      if taxe ~= nil and taxe > 0 then
        taxeprice = amount * (taxe * 0.01)
        TriggerEvent('ft_simplebank:SvRemoveBankMoney', source, taxeprice)
        TriggerClientEvent("ft_ui:ClNotification", source, "~h~Vous avez ~g~retiré~s~ "..tostring(amount).."$ de votre ~b~compte bancaire~s~~n~~n~~y~Frais de transaction:~s~ "..tostring(taxeprice).."$")
      else
        TriggerClientEvent("ft_ui:ClNotification", source, "~h~Vous avez ~r~retiré~s~ "..tostring(amount).."$ de votre ~b~compte bancaire~s~.")
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
      TriggerEvent('ft_simplebank:SvTransferBankMoney', source, targetid, amount)
      
      if taxe ~= nil and taxe > 0 then
        local taxeprice = amount * (taxe * 0.01)
        TriggerEvent('ft_simplebank:SvRemoveBankMoney', source, taxeprice)
        TriggerClientEvent("ft_ui:ClNotification", source, "~h~Vous avez ~r~transféré~s~ "..tostring(amount).."$ de votre ~b~compte bancaire~s~~n~~n~~y~Frais de transaction:~s~ "..tostring(taxeprice).."$")
      else
        TriggerClientEvent("ft_ui:ClNotification", source, "~h~Vous avez ~r~transféré~s~ "..tostring(amount).."$ de votre ~b~compte bancaire~s~.")
      end
      
    else
			TriggerClientEvent("ft_ui:ClNotification", source, "~h~~r~Erreur~s~: Vous n'avez pas assez d'argent!")
    end
    
  end)
  
end)