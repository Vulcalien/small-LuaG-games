player = {
    head = { x = 0, y = 0 },
    body = { {x=1,y=0}, {x=2,y=0} },

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

        if self.head.x < 0 or self.head.x >= map_w or
           self.head.y < 0 or self.head.y >= map_h then
            -- TODO game over
        end

        if self.head.x == food.x and self.head.y == food.y then
            food:spawn()
            self.saturation = self.saturation + 1
        end
    end,

    change_dir = function(self, new_dir)
        if self.dir == new_dir or math.abs(self.dir - new_dir) % 2 ~= 0 then
            self.new_dir = new_dir
        end
    end,

    render = function(self)
        spr(0, self.head.x * 8, self.head.y * 8, {
            rot = self.dir
        })

        for _,part in ipairs(self.body) do
            spr(16, part.x * 8, part.y * 8)
        end
    end
}
