-- @Date:   2017-07-01T12:38:38+02:00
-- @Project: FiveM Tools
-- @Last modified time: 2017-07-06T19:18:17+02:00
-- @License: GNU General Public License v3.0

local lastPlayerId = nil
local taxeRating = 0

function generateButton()
  Citizen.CreateThread(function()
  
    if config.enableDeposit ~= nil and config.enableDeposit then
      table.insert(Menu.ATMmenu.buttons, { text = translation[language].secondeButton, callback = AllDespositBank })
      table.insert(Menu.ATMmenu.buttons, { text = translation[language].thirdButton, callback = DespositBank })
    end
    
    if config.enableWithdraw ~= nil and config.enableWithdraw then
      table.insert(Menu.ATMmenu.buttons, { text = translation[language].fourButton, callback = WithdrawBank })
    end
    
    if config.enableTransfer ~= nil and config.enableTransfer then
      table.insert(Menu.ATMmenu.buttons, { text = translation[language].fiveButton, menu = "PlayerListBank", hoverCallback = PlayerListBank })
    end
    
    if config.taxe ~= nil and config.taxe >= 0 and config.taxe <= 100 then
      taxeRating = config.taxe
    end
    
    exports.ft_menuBuilder:Generator(Menu)
    
  end)
end

function enterATM()
  Citizen.CreateThread(function()
  
    exports.ft_ui:Help("Appuyer sur ~INPUT_FRONTEND_ACCEPT~ pour utiliser le distributeur automatique", 0)
    if IsControlJustPressed(1, 38) then
      if not exports.ft_menuBuilder:IsOpened() and GetLastInputMethod(2) then
        exports.ft_menuBuilder:Open("ATMmenu")
      else
        exports.ft_menuBuilder:Close()
      end
    end
    
  end)
end

function exitATM()
  Citizen.CreateThread(function()
  
    if exports.ft_menuBuilder:IsOpened() then
      exports.ft_menuBuilder:Close()
    end
    
  end)
end

function OpenKeyboard()

  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 8)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult() ~= nil) then
        return GetOnscreenKeyboardResult()
    end
    
end

function getPlayers()
    local playerList = {}
    for i = 0, 32 do
        local player = GetPlayerFromServerId(i)
        if NetworkIsPlayerActive(player) and player ~= GetPlayerFromServerId(PlayerId()) then
            table.insert(playerList, player)
        end
    end
    return playerList
end

function PlayerListBank()
  Citizen.CreateThread(function()
  
    local settings = {
      title = translation[language].title,
			menuTitle = translation[language].menuTitle,
      red = config.menu.red,
			blue = config.menu.blue,
			green = config.menu.green,
    }
    local buttons = {}
    
    local players = getPlayers()
    for _, player in pairs(players) do
      table.insert(buttons, {text = GetPlayerName(player), callback = TransferBank, hoverCallback = setPlayerId, data = GetPlayerServerId(player)})
    end
    
    if buttons == {} then
      table.insert(buttons, {text = "Aucun joueur en ligne"})
    end
    
    exports.ft_menuBuilder:Add("PlayerListBank", buttons, settings)
    
  end)
end

function setPlayerId(data)
  if data ~= nil then
    lastPlayerId = data
  end
end

--------------------------
function GenerateBankBalance()
  Citizen.CreateThread(function()
  
    local bank = exports.ft_simpleBank:GetBankMoney()
 
    local settings = {
      title = translation[language].title,
			menuTitle = translation[language].menuTitle,
      red = config.menu.red,
			blue = config.menu.blue,
			green = config.menu.green,
    }
    
    local buttons = {
      {text = translation[language].firstButton.."   /   "..tostring(bank).."$"},
    }
    
    if taxeRating > 0 then
      table.insert(buttons, {text = "Frais de transaction : "..tostring(taxeRating).."%"})
    end
    
    exports.ft_menuBuilder:Add("BalanceMenu", buttons, settings)
    
  end)
end

function AllDespositBank()
  Citizen.CreateThread(function()
    local cash = tonumber(exports.ft_cash:GetCash())
    if cash > 0 then
      TriggerServerEvent('ft_simpleATM:SvDespositMoney', cash, taxeRating)
    else
      exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous n'avez pas assez d'argent!")
    end
  end)
end

function DespositBank()
  Citizen.CreateThread(function()
  
    local result = OpenKeyboard()
    if type(tonumber(result)) == "number" then
      if tonumber(result) > 0 then
        local cash = exports.ft_cash:GetCash()
        if tonumber(cash) >= tonumber(result) then
          TriggerServerEvent('ft_simpleATM:SvDespositMoney', tonumber(result), taxeRating)
        else
          exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous n'avez pas assez d'argent!")
        end
      else
        exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous devez entrer un montant supérieur à 0!")
      end
    else
      exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous devez saisir des chiffres seulement!")
    end
    
  end)
end

function WithdrawBank()
  Citizen.CreateThread(function()
  
    local result = OpenKeyboard()
    if type(tonumber(result)) == "number" then
      if tonumber(result) > 0 then
        local bank = exports.ft_simpleBank:GetBankMoney()
        if tonumber(bank) >= tonumber(result) then
          TriggerServerEvent('ft_simpleATM:SvWithdrawBank', tonumber(result), taxeRating)
        else
          exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous n'avez pas assez d'argent!")
        end
      else
        exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous devez entrer un montant supérieur à 0!")
      end
    else
      exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous devez saisir des chiffres seulement!")
    end
    
  end)
end

function TransferBank()
  Citizen.CreateThread(function()
  
    local result = OpenKeyboard()
    if type(tonumber(result)) == "number" then
      if tonumber(result) > 0 then
        local bank = exports.ft_simpleBank:GetBankMoney()
        if tonumber(bank) >= tonumber(result) then
          TriggerServerEvent('ft_simpleATM:SvTransferBank', lastPlayerId, tonumber(result), taxeRating)
        else
          exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous n'avez pas assez d'argent!")
        end
      else
        exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous devez entrer un montant supérieur à 0!")
      end
    else
      exports.ft_ui:Notification("~h~~r~Erreur~s~: Vous devez saisir des chiffres seulement!")
    end
    
  end)
end