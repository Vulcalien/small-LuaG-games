function menu_start_init()

end

function menu_start_tick()
    write('Farming Land', menu_rainbow_colors[math.floor(ticks / 20) % 7 + 1], 45, 76)
    write('Press "Enter" to start', 0xdddddd, 14, 140)
    write('Copyright 2019 Vulcalien', 0xaaaaaa, 1, 1)

    if key(6) then
        game_menu = nil
        sfx('start_game')
    end
end
