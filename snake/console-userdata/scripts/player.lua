player = {
    head = { x = 8, y = 9 },
    body = { { x = 9, y = 9 }, { x = 10, y = 9 } },

    dir = -1,
    new_dir = -1,

    saturation = 0,

    move = function(self)
        self.dir = self.new_dir

        local xm = 0
        local ym = 0

        if     self.dir == 0 then ym = -1
        elseif self.dir == 1 then xm = -1
        elseif self.dir == 2 then ym = 1
        elseif self.dir == 3 then xm = 1
        else return end

        if self.saturation > 0 then
            self.saturation = self.saturation - 1
        else
            table.remove(self.body, #self.body)
        end
        table.insert(self.body, 1, { x = self.head.x, y = self.head.y })

        self.head.x = self.head.x + xm
        self.head.y = self.head.y + ym

        if self.head.x < 0 or self.head.x >= game_w or
           self.head.y < 0 or self.head.y >= game_h then
            current_panel = gameover_panel
        end

        if self.head.x == food.x and self.head.y == food.y then
            food:spawn()
            self.saturation = self.saturation + 1
            score = score + 1
        end
    end,

    change_dir = function(self, new_dir)
        if self.dir == new_dir or
           math.abs(self.dir - new_dir) % 2 ~= 0 or
           self.dir == -1 then
            self.new_dir = new_dir
        end
    end,

    render = function(self)
        spr(6, self.head.x * 8, self.head.y * 8, {
            rot = self.dir ~= -1 and 4 - self.dir or 3,
            col_mod = 0xffbb00
        })

        for _,part in ipairs(self.body) do
            spr(7, part.x * 8, part.y * 8, {
                col_mod = 0xffbb55
            })
        end
    end
}
