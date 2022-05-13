-- For Documentation, see 'https://github.com/Vulcalien/LuaG-Console/wiki'

function init()
    dice_size = 6
    ops = 1 * 1000 * 1000

    results = {}
    for i=1,dice_size do
        results[i] = 0
    end

    for i=1,ops do
        local dice_result = math.random(1, dice_size)
        results[dice_result] = results[dice_result] + 1
    end
end

function tick()

end

function render()
    clear(0x000000)

    write('Facce: ', 0xffffff, 1, 1)
    for i=1,dice_size do
        write(
            ' ' .. i .. ': ' .. results[i] .. ' -> ' .. (results[i] / ops) * 10000 // 1 / 100  .. '%',
            0xffffff,
            1, 1 + (font_h + 1) * i
        )
    end
end
