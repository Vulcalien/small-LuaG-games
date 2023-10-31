local function move2(mob, xm, ym)
    if xm == 0 and ym == 0 then
        return false
    end

    -- check map borders
    if mob.x - mob.xr + xm < 0 or
       mob.y - mob.yr + ym < 0 or
       mob.x + mob.xr + xm - 1 >= map_w * 8 or
       mob.y + mob.yr + ym - 1 >= map_h * 8 then
        return false
    end

    -- check for solid entities
    for i,e in ipairs(level.room.entities) do
        if e == mob then
            goto loop_end
        end

        if e:intersects(mob.x + xm, mob.y + ym, mob.xr, mob.yr) then
            if mob.touch then
                mob:touch(e)
            end

            if e.touched_by then
                e:touched_by(mob)
            end

            if e:blocks_movement(mob) then
                return false
            end
        end

        ::loop_end::
    end

    mob.x = mob.x + xm
    mob.y = mob.y + ym
    return true
end

function new_Mob(max_hp)
    local result = new_Entity()
    result.entity_type['mob'] = true

    result.blocks_movement = function(self, e)
        return true
    end

    result.max_hp = max_hp
    result.hp = max_hp

    -- by default, all mobs face towards the screen
    result.dir = 2

    result.mov_animation = 0

    result.move = function(self, xm, ym)
        if xm == 0 and ym == 0 then
            self.mov_animation = 0
            return
        end

        move2(self, xm, 0)
        move2(self, 0, ym)

        if     xm < 0 then self.dir = 1
        elseif xm > 0 then self.dir = 3
        end

        if     ym < 0 then self.dir = 0
        elseif ym > 0 then self.dir = 2
        end

        self.mov_animation = self.mov_animation + 1
    end

    return result
end
