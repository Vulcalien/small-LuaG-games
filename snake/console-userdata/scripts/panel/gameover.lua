gameover_panel = {
    tick = function(self)
        if key_pressed('start') or key_pressed('select') or
           key_pressed('a')     or key_pressed('b')      then
            current_panel = start_panel
        end
    end,

    render = function(self)
        -- TODO improve this
        write('Game Over', 0xffffff, 1, 1)
    end
}
