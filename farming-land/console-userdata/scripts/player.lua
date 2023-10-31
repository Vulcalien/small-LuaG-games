function player_init()
    player_x = 10 * 8
    player_y = 10 * 8
    player_dir = 0

    player_coins = 10
    player_seeds = 0

    player_movecount = 0
    player_was_interact_pressed = false
end

function player_tick()
    local xm = 0
    local ym = 0

    if key(0) then ym = ym - 1 end
    if key(1) then xm = xm - 1 end
    if key(2) then ym = ym + 1 end
    if key(3) then xm = xm + 1 end

    player_move(xm, ym)

    if key(4) then
        if not player_was_interact_pressed then
            player_interact()
            player_was_interact_pressed = true
        end
    else
        player_was_interact_pressed = false
    end

    player_render()
end

function player_render()
    local spr_id = -1

    if player_dir == 0 then spr_id = 16
    else spr_id = 17 end

    local move_phase = math.floor((player_movecount + 9) / 10) % 2
    spr_id = spr_id + 16 * move_phase

    spr(spr_id, player_x - 4, player_y - 4)
end

function player_move(xm, ym)
    if xm ~= 0 or ym ~= 0 then
        player_movecount = player_movecount + 1
    else
        player_movecount = 0
        return
    end

    local xt0 = (player_x - 4) / 8
    local yt0 = (player_y - 4) / 8
    local xt1 = (player_x + 4) / 8
    local yt1 = (player_y + 4) / 8

    local new_x = player_x + xm
    local new_y = player_y + ym

    local xto0 = (new_x - 4) / 8
    local yto0 = (new_y - 4) / 8
    local xto1 = (new_x + 4) / 8
    local yto1 = (new_y + 4) / 8

    local can_move_x = true
    local can_move_y = true
    for y = yto0, yto1 do
        if y < 0 or y >= map_h then can_move_y = false end
        for x = xto0, xto1 do
            if x < 0 or x >= map_w then can_move_x = false end
        end
    end

    if can_move_x then player_x = new_x end
    if can_move_y then player_y = new_y end

    if xm < 0 then player_dir = 0
    elseif xm > 0 then player_dir = 1 end
end

function player_interact()
    local interact_x = player_x
    local interact_y = player_y

    local interact_xt = math.floor(interact_x / 8)
    local interact_yt = math.floor(interact_y / 8)

    player_interact_on_tile(interact_xt, interact_yt)
end

function player_interact_on_tile(xt, yt)
    if xt < 0 or xt >= map_w or yt < 0 or yt >= map_h then
        return
    end

    t_id = get_tile(xt, yt)
    if t_id == 0 then -- dirt tile without seeds
        player_try_plant(xt, yt)
    elseif t_id >= 1 and t_id <= 4 then -- dirt with seeds/crops
        player_harvest(xt, yt)
    elseif (t_id >= 48 and t_id <= 51) or (t_id >= 64 and t_id <= 67) then -- buy seeds tiles
        player_try_buy()
    end
end

function player_try_plant(xt, yt)
    if player_seeds > 0 then
        player_seeds = player_seeds - 1
        level_set_tile(xt, yt, 1)
        sfx('plant_seed')
    end
end

function player_harvest(xt, yt)
    local tile = get_tile(xt, yt)
    if tile == 3 then -- perfect grown crop
        player_coins = player_coins + math.random(2, 6)

        if player_coins >= 1000 then
            win_game()
        end
    end

    level_set_tile(xt, yt, 0) -- set clean dirt
    sfx('harvest')
end

function player_try_buy()
    if player_coins > 0 then
        player_seeds = player_seeds + 1
        player_coins = player_coins - 1
        sfx('buy_seed')
    end
end
