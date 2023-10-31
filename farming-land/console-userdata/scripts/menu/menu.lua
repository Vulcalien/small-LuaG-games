function menu_init()
    loadscript('menu/menu_start.lua')
    loadscript('menu/menu_win.lua')

    menu_start_init()
    menu_win_init()

    menu_rainbow_colors = {
        0xFF0000,
        0xFF7F00,
        0xFFFF00,
        0x00FF00,
        0x0000FF,
        0x4B0082,
        0x8B00FF
    }
end

function menu_tick()
    local rendered = true
    if game_menu == 'start' then
        menu_start_tick()
    elseif game_menu == 'win' then
        menu_win_tick()
    else
        rendered = false
    end

    return rendered
end
