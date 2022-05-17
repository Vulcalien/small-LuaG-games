-- For Documentation, see 'https://github.com/Vulcalien/LuaG-Console/wiki'

function init()
    keys = {
        'up', 'left', 'down', 'right',
        'a', 'b', 'start', 'select'
    }

    colors = {}
    for i=1,#keys do
        colors[i] = 0xffffff
    end
end

function tick()
    for i,k in ipairs(keys) do
        if key_pressed(k) then
            colors[i] = 0x0000ff
            print(k .. ' was pressed')
        elseif key_released(k) then
            colors[i] = 0x00ff00
            print(k .. ' was released')
        elseif key_down(k) then
            colors[i] = 0xff0000
        else
            colors[i] = 0xffffff
        end
    end
end

function render()
    clear(0x333333)

    for i,k in ipairs(keys) do
        write(k, colors[i], 1, 1 + (i - 1) * (font_h + 1))
    end
end
