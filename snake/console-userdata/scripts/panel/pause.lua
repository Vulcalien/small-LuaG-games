pause_panel = {
    tick = function(self)
        if key_pressed('start') or key_pressed('select') or
           key_pressed('a')     or key_pressed('b')      then
            current_panel = game_panel
        end
    end,

    render = function(self)
        game_panel:render()

        -- TODO improve this
        write('Game Paused', 0xffffff, 1, 1)
    end
}
