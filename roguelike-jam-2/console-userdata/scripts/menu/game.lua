local map_panel = {
    titlebar = '*---SITEMAP---------------*',

    tick = function(self)
    end,

    render = function(self)
        for i,room in ipairs(level.rooms) do
            local col

            if level.room == room then
                col = 0xff0000
            else
                col = i % 2 == 0 and 0xddddee or 0xccccee
            end
            write(' ' .. room.name, col, 0, i * (font_h + 1))
        end
    end
}

local storage_panel = {
    titlebar = '*---STORAGE---------------*';

    tick = function(self)
    end,

    render = function(self)
    end
}

local panel_list = {
    map_panel,
    storage_panel
}

-- assign right and left to each panel
for i,v in ipairs(panel_list) do
    if i == 1 then
        v.left = panel_list[#panel_list]
    else
        v.left = panel_list[i - 1]
    end

    if i == #panel_list then
        v.right = panel_list[1]
    else
        v.right = panel_list[i + 1]
    end
end

menu_game = {
    panel = map_panel,

    tick = function(self)
        if key_pressed('select') then
            menu = nil
        end

        if key_pressed('left') then
            self.panel = self.panel.left
            -- TODO play sound
        end

        if key_pressed('right') then
            self.panel = self.panel.right
            -- TODO play sound
        end

        self.panel:tick()
    end,

    render = function(self)
        pix(0, 0, 0x000000, { w = scr_w, h = scr_h, alpha = 0x99 })
        write(
            self.panel.titlebar .. '\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '|                         |\n' ..
            '*-------------------------*',
            0xddddee, 0, 0
        );

        self.panel:render()
    end
}
