function new_Text_particle(x, y, text, col)
    local result = new_Particle(x, y, 120)
    result.entity_type['particle_text'] = true

    -- TODO move text

    result.render = function(self)
        write(text, col, self.x - font_w // 2, self.y - font_h // 2, {
            alpha = 0xff * result.lasting_time // 120
        })
    end

    return result
end
