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

        pix(0, scr_h - 8, 0x000000, { w = scr_w, h = 8 })
        for i=0,1 do
            write(
                'Score: ' .. score,
                i == 0 and 0x7a7a7a or 0xcccccc,
                1, scr_h - font_h + 1 - i
            )
        end

    end
}
