-- @Date:   2017-05-10T23:34:27+02:00
-- @Project: FiveM Tools
-- @Last modified time: 2017-07-02T17:20:51+02:00
-- @License: GNU General Public License v3.0

------------------------------------------------------------------------------------------
-------------------------------------Configuration----------------------------------------
------------------------------------------------------------------------------------------

language = "fr" -- "fr" or "en" to change the language.

config = {
  menu = {  -- Change the color of the menu and markers
    red = 120,
    blue = 120,
    green = 0,
  },
  enableDeposit = true, -- true to enable deposit at ATM
  enableWithdraw = true, -- true to enable deposit at ATM
  enableTransfer = true, -- true to enable transfer at ATM
  taxe = 10, -- You can choose the transaction fee rate here [ 100 - 0 ] pourcent
}

-- Here you can add your own language if you wish.
translation = {
  ["fr"] = {
    -- MainMenu
    title = "Distributeur",
    menuTitle = "Distributeur",
    firstButton = "Balance",
    secondeButton = "Tout déposer",
    thirdButton = "Déposer",
    fourButton = "Retirer",
    fiveButton = "Transfert",
  },
  ["en"] = {
    -- MainMenu
    title = "ATM",
    menuTitle = "ATM",
    firstButton = "Balance",
    secondeButton = "Deposit all",
    thirdButton = "Deposit",
    fourButton = "Withdraw",
    fiveButton = "Transfer",
  },
}

------------------------------------------------------------------------------------------
-------------------------------------Do not touch below-----------------------------------
------------------------------------------------------------------------------------------

Menu = {
  ATMmenu = {
    settings = {
      title = translation[language].title,
			menuTitle = translation[language].menuTitle,
      red = config.menu.red,
			blue = config.menu.blue,
			green = config.menu.green,
    },
    buttons = {
      { text = translation[language].firstButton, menu = "BalanceMenu", hoverCallback = GenerateBankBalance },
    },
  },
}