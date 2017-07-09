local FirstJoinProper = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if NetworkIsSessionStarted() then
      if not FirstJoinProper then
        generateButton()
      end
      if IsControlJustPressed(1, 38) then
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
