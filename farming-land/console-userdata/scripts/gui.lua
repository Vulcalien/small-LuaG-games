function gui_tick()
    spr(18, 0, 152)
    write(player_coins, 0xffffff, 9, 153)

    spr(19, 152, 152)
    write(player_seeds, 0xffffff, 151 - string.len(player_seeds) * 6 + 1, 153)
end
