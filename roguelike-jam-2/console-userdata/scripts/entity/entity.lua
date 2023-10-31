function new_Entity(x, y)
    return {
        entity_type = {},

        x = x,
        y = y,

        xr = 0,
        yr = 0,

        tick = function(self) end,
        render = function(self) end,

        intersects = function(self, x, y, xr, yr)
            return x - xr <= self.x + self.xr and
                   y - yr <= self.y + self.yr and
                   x + xr >= self.x - self.xr and
                   y + yr >= self.y - self.yr
        end,

        blocks_movement = function(self, e)
            return false
        end,

        touch = function(self, e) end,
        touched_by = function(self, e) end
    }
end
