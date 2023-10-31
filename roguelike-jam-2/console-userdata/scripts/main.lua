-- For Documentation, see 'https://github.com/Vulcalien/LuaG-Console/wiki'

function init()
    debug_info = false

    ticks = 0

    settransparent(0xff00ff)

    loadscript('level.lua')

    loadscript('entity/entity.lua')
    loadscript('entity/mob.lua')
    loadscript('entity/player.lua')

    loadscript('entity/enemy.lua')
    loadscript('entity/virus.lua')

    loadscript('entity/particle/particle.lua')
    loadscript('entity/particle/text.lua')
    loadscript('entity/particle/spray.lua')
    loadscript('entity/particle/portal.lua')

    loadscript('item/item.lua')
    loadscript('item/spray.lua')

    loadscript('menu/game.lua')
    loadscript('menu/pause.lua')

    lvl = 1
    level = new_Level()

    player = new_Player()
    player.item_a = new_Spray()
    level:insert(player)

    -- DEBUG
    player.x = map_w * 8 // 2
    player.y = map_h * 8 // 2

    level:insert(new_Virus(3, 3))

    level:insert(new_Portal_particle(4, 5))
end

function tick()
    if menu then
        menu:tick()
    else
        level:tick()
    end

    ticks = ticks + 1
end

function render()
    do --draw background
        clear(0x333377)

        for i=0,scr_h / (font_h + 2) - 1 do
            local sin = math.sin(ticks / 180 + i * 2)

            write(
                '01010110 01110101 01101100 01100011',
                0x77cc77,
                (i % 5) * 2 - 30 + math.floor(sin * 30), 1 + i * (font_h + 2),
                { alpha = math.floor(math.abs(sin) * 0x18) }
            )
        end
    end

    level:render()

    if menu then
        menu:render()
    end
end
