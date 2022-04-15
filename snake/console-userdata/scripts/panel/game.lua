game_panel = {
    tick = function(self)
        do -- change player.dir
            local old_dir = player.dir

            if     key_pressed(0) then player.dir = 0
            elseif key_pressed(1) then player.dir = 1
            elseif key_pressed(2) then player.dir = 2
            elseif key_pressed(3) then player.dir = 3
            end

            if math.abs(player.dir - old_dir) % 2 == 0 then
                player.dir = old_dir
            end
        end

        if ticks % 15 == 0 then
            player:move()
        end
    end,

    render = function(self)
        player:render()
    end
}
