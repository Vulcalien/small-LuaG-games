function new_Particle(x, y, lasting_time)
    local result = new_Entity(x, y)
    result.entity_type['particle'] = true

    result.lasting_time = lasting_time

    result.on_remove = function() end

    result.tick = function(self)
        result.lasting_time = result.lasting_time - 1
        if result.lasting_time == 0 then
            level:remove(self)

            self:on_remove()
        end
    end

    return result
end
