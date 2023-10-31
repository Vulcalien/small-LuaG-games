-- Copyright 2019 Vulcalien
-- Game made for Fantasy Console Game Jam #4
-- Theme: food

-- In this game the player has to gain coins by farming.
-- He has seeds that he plants.
-- Then crops grow up and if he picks them up when they are grown he gains coins.
-- If he doesn't pick them up in time the crops rot and he will gain 0 coins.
-- If he reaches a certain ammount of coins he wins.
-- If he reaches 0 coins, 0 seeds, and there are no growing crops, he loses.

function init()
    loadscript('level.lua')
    loadscript('player.lua')
    loadscript('gui.lua')
    loadscript('menu/menu.lua')

    settransparent(0xff00ff)

    menu_init()
    level_init()
    player_init()

    ticks = 0
    game_menu = 'start'
end

function tick()
    ticks = ticks + 1
    clear(0)

    if not menu_tick() then
        level_tick()
        player_tick()
        gui_tick()
    end
end

-- required by newer versions of LuaG Console
function render() end

function win_game()
    game_menu = 'win'
end
