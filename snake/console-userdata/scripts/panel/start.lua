start_panel = {
    tick = function(self)
        if key_pressed('start') then
            current_panel = game_panel
            -- TODO sound
        end

        if key_pressed('select') then
            current_panel = credits_panel
        end
    end,

    render = function(self)
        local color_boost = math.abs(math.sin(ticks / 120))

        clear(math.floor(color_boost * 0x11 + 0x44) << 8)

        do -- press START text
            local text = 'Press START';
            local len = string.len(text)

            local col
            if (ticks // 40) % 2 == 0 then
                col = 0x999999
            else
                col = 0xbbbbbb
            end

            write(
                text, col,
                (scr_w - len * (font_w + 1)) // 2,
                scr_h - 2 * font_h
            )
        end

        do -- SNAKE title
            spr(
                0,                     -- id
                (scr_w - 6 * 16) // 2, -- x
                (scr_h - 2 * 16) // 2 - (((ticks // 60) % 2) * 4), -- y
                {
                    scale = 2,
                    sw = 6,
                    sh = 2,
                    col_mod = math.floor(color_boost * 0x33 + 0xcc) << 16
                }
            )
        end

        do -- credits
            write('Press SELECT for credits', 0x555555, 1, 1)
        end
    end
}
