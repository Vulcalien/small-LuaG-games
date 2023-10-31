ENEMY_INVULNERABILITY = 40

function new_Enemy(max_hp)
    local result = new_Mob(max_hp)
    result.entity_type['enemy'] = true

    result.die = function(self)
        level:remove(self)
    end

    result.blocks_movement = function(self, e)
        if e.entity_type['enemy'] then
            return false
        end

        return true
    end

    result.draw_hp_bar = function(self)
        pix(self.x - 8, self.y - 11, 0xcccccc, {
            w = 16, h = 5, alpha = 0xaa
        })

        local hp_col

        local hp = self.hp / self.max_hp
        if hp > 0.75 then
            hp_col = 0x33ff33
        elseif hp > 0.5 then
            hp_col = 0x99ff33
        elseif hp > 0.25 then
            hp_col = 0xffff33
        else
            hp_col = 0xff3333
        end
        pix(self.x - 7, self.y - 10, hp_col, {
            w = math.ceil(14 * hp), h = 3
        })
    end

    result.invulnerability = 0

    return result
end
