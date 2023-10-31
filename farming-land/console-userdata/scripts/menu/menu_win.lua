function menu_win_init()

end

function menu_win_tick()
    write('You Won!', menu_rainbow_colors[math.floor(ticks / 20) % 7 + 1], 56, 76)
    write('Made by Vulcalien', 0xaaaaaa, 1, 152)
end
