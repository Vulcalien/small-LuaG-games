function level_init()
    level_grow_time = {}
    for i = 1, map_w * map_h do
        level_grow_time[i] = 0
    end
end

function level_tick()
    for tile = 1, map_w * map_h do
        local t_x = (tile - 1) % map_w
        local t_y = math.floor((tile - 1) / map_w)

        local t = get_tile(t_x, t_y)
        if t >= 1 and t <= 4 then
            local g_time = level_grow_time[tile]
            level_grow_time[tile] = g_time + 1

            if g_time == 900 and t ~= 4 then
                level_set_tile(t_x, t_y, t + 1)
            end
        end
    end

    maprender()
end

function level_set_tile(xt, yt, id)
    set_tile(xt, yt, id)

    level_grow_time[xt + yt * map_w + 1] = 0
end
