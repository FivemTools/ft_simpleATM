-- @Project: FiveM Tools
-- @License: GNU General Public License v3.0

local FirstJoinProper = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if NetworkIsSessionStarted() then
      if not FirstJoinProper then
        generateButton()
        
        if config.showBlips then
          for k, pos in pairs (config.locationATM) do
            exports.ft_blips:Add("simpleATMBlips"..tostring(k), {text = translation[language].title, colorId = 2, imageId = 277, x = pos[1], y = pos[2], z = pos[3] })
          end
        end
        
        for k, pos in pairs (config.locationATM) do
          exports.ft_markers:Add("simpleATMMarkers"..tostring(k), { x = pos[1], y = pos[2], z = pos[3], type = 1, weight = 1, height = 0.5, red = config.menu.red, green = config.menu.green, blue = config.menu.blue, enable = true })
          exports.ft_areas:Add("simpleATMAreas"..tostring(k), {x = pos[1], y = pos[2], z = pos[3] , weight = 2, active = { callback = enterATM }, exit = { callback = exitATM }, enable = true })
        end
        
      end
      
     if IsControlJustPressed(1, 246) then
        if not exports.ft_menuBuilder:IsOpened() and GetLastInputMethod(2) then
          exports.ft_menuBuilder:Open("ATMmenu")
        else
          exports.ft_menuBuilder:Close()
        end
      end
      
      FirstJoinProper = true
    end
  end
end)