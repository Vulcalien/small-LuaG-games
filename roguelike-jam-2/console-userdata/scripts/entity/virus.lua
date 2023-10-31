local WALK_TIME     = 120
local DELIVERY_TIME = 180

function new_Virus(x0, y0)
    local result = new_Enemy(30)
    result.entity_type['virus'] = true

    result.x = x0 * 8
    result.y = y0 * 8

    result.xr = 3
    result.yr = 4

    result.fertility = 3

    result.is_pregnant = false
    result.pause_time = 1
    result.walk_time = 0
    result.pregnant_delivery_time = 0

    result.ignore_one_axis_time = 0

    result.tick = function(self)
        if ticks % 2 == 0 and not self.is_pregnant then
            return
        end

        local xdiff = math.abs(player.x - self.x)
        local ydiff = math.abs(player.y - self.y)

        if self.walk_time > 0 and self.invulnerability == 0 then
            self.walk_time = self.walk_time - 1

            if self.walk_time == 0 then
                -- if pregnant, start the delivery time
                if self.is_pregnant then
                    if self.fertility > 0 then
                        self.pregnant_delivery_time = DELIVERY_TIME
                    else
                        self.is_pregnant = false
                    end
                end

                self.pause_time = math.random(120, 240)
            end

            if self.ignore_one_axis_time == 0 and math.random(1, 50) == 1 then
                self.ignore_one_axis_time = math.random(30, 120)
            end

            local xm = 0
            local ym = 0

            local speed = 1

            if     player.x < self.x then xm = -speed
            elseif player.x > self.x then xm = speed
            end

            if     player.y < self.y then ym = -speed
            elseif player.y > self.y then ym = speed
            end

            if self.is_pregnant then
                xm = -xm
                ym = -ym
            end

            -- ignore one axis sometimes, just to add variety to the movement
            if xm ~= 0 and ym ~= 0 and self.ignore_one_axis_time > 0 then
                if xdiff < ydiff then
                    xm = 0
                elseif xdiff > ydiff then
                    ym = 0
                end

                self.ignore_one_axis_time = self.ignore_one_axis_time - 1
            end

            self:move(xm, ym)
        end

        if self.invulnerability > 0 then
            self.invulnerability = self.invulnerability - 1
        end

        if self.is_pregnant then
            self.pregnant_delivery_time = self.pregnant_delivery_time - 1

            if self.pregnant_delivery_time == 0 then
                self.is_pregnant = false

                local child = new_Virus(0, 0)
                child.x = self.x
                child.y = self.y

                self.fertility = self.fertility - 1
                child.fertility = self.fertility

                level:insert(child)
            end
        end

        if self.pause_time > 0 then
            if xdiff + ydiff > 8 * 4 then
                self.pause_time = self.pause_time - 1
            else
                self.pause_time = 0
            end

            if self.pause_time == 0 then
                self.walk_time = math.random(240, 480)
            end
        end
    end

    result.render = function(self)
        if self.invulnerability == 0 or (ticks // 10) % 2 == 0 then
            spr(self.is_pregnant and 6 or 5, self.x - 4, self.y - 4, {
                h_flip = (ticks // 18) % 2 == 0,
                v_flip = ((ticks + 31) // 18) % 2 == 0
            })

            self:draw_hp_bar()
        end

        if debug_info then
            write(
                'walk time: ' .. self.walk_time ..
                '\npause time: ' .. self.pause_time ..
                '\nignore axis time: ' .. self.ignore_one_axis_time ..
                '\npregnant: ' .. (self.is_pregnant and 1 or 0) ..
                '\n delivery time: ' .. self.pregnant_delivery_time,
                0x000000, self.x, self.y
            )
        end
    end

    result.touch = function(self, e)
        if e.entity_type['player'] then
            self.is_pregnant = true
            self.walk_time = WALK_TIME
        end

        if e.entity_type['particle_spray'] and self.invulnerability == 0 then
            self.hp = self.hp - e.dmg
            level:insert(
                new_Text_particle(self.x, self.y, e.dmg .. '', 0xff3333)
            )

            self.invulnerability = ENEMY_INVULNERABILITY

            if self.hp <= 0 then
                level:remove(self)
                -- TODO add virus death animation
            end
        end
    end

    return result
end
