credits_panel = {
    tick = function(self)
        -- press any key to go back
        for i=0,7 do
            if key_pressed(i) then
                current_panel = start_panel
            end
        end
    end,
    render = function(self)
        clear(0x004400)
        for i=0,1 do
            write(
                'Copyright 2022 Vulcalien\n' ..
                '\n' ..
                'This is free software\n' ..
                'License: GPL 3 or later',
                i == 0 and 0x7a0000 or 0xcc0000,
                1, 2 - i
            )
        end

        do -- press any key
            local text = 'Press any key'
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
    end
}
