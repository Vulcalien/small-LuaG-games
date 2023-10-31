function new_Portal_particle(xt, yt)
    local result = new_Particle(xt * 8 + 4, yt * 8 + 4, 100)
    result.entity_type['particle_portal'] = true

    result.render = function(self)
        spr(69, self.x - 4, self.y - 4, {
            alpha = math.floor(0xff * (100 - result.lasting_time) / 100)
        })
    end

    result.on_remove = function(self)
        set_tile(xt, yt, 69)
    end

    return result
end
