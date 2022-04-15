game_panel = {
    tick = function(self)
        -- pause game
        if key_pressed('start') or key_pressed('select') then
            current_panel = pause_panel
        end

        -- change player.dir
        for i=0,3 do
            if key_pressed(i) then
                player:change_dir(i)
                break
            end
        end

        if ticks % 13 == 0 then
            player:move()
        end
    end,

    render = function(self)
        player:render()
        food:render()
    end
}
