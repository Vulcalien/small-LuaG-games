player = {
    head = { x = 0, y = 0 },
    body = { {x=1,y=0}, {x=2,y=0} },

    dir = -1,
    saturation = 0,

    move = function(self)
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
            table.insert(self.body, 1, { x = self.head.x, y = self.head.y })
        end

        self.head.x = self.head.x + xm
        self.head.y = self.head.y + ym

        -- TODO check for out-of-bounds movement
    end,

    render = function(self)
        spr(0, self.head.x * 8, self.head.y * 8)

        for _,part in ipairs(self.body) do
            spr(16, part.x * 8, part.y * 8)
        end
    end
}
