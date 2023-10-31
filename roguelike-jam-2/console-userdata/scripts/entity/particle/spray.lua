function new_Spray_particle(x, y, col, dmg)
    local result = new_Particle(x, y, 80)
    result.entity_type['particle_spray'] = true

    result.render = function(self)
        spr(128, self.x - 4, self.y - 4, {
            col_mod = col,
            h_flip = (result.lasting_time // 10) % 2 == 0,
            alpha = 0xff * result.lasting_time // 80
        })
    end

    result.dmg = dmg

    return result
end
