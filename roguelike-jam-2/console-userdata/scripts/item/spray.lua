local names = {
    'Virus Defender',
    'Bit Protector',
    'McAbee',
    'Auast',
    'Clams Antivirus',
    'HTML Blocker',
    'TrustMe AV'
}

function new_Spray()
    local result = new_Item(
        names[math.random(1, #names)], icon,
        math.random(0, 0xffffff)
    )

    result.use = function(self, player)
        local x = player.x
        local y = player.y

        local range = 8
        local radius = 4

        if     player.dir == 0 then y = y - range - radius
        elseif player.dir == 1 then x = x - range - radius
        elseif player.dir == 2 then y = y + range + radius
        elseif player.dir == 3 then x = x + range + radius
        end

        level:insert(
            new_Spray_particle(
                x, y, self.item_col,
                math.random(2, 7)
            )
        )
    end

    return result
end
