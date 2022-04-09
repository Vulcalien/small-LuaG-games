function draw_line(x, y, xd, yd, color)
    local len = math.sqrt(xd * xd + yd * yd)

    if len < 1 then
        return
    end

    local sin = yd / len
    local cos = xd / len

    for i=0,math.floor(len + 0.5) do
        pix(
            math.floor(x + cos * i + 0.5),
            math.floor(y + sin * i + 0.5),
            color
        )
    end
end

function new_body(name, icon, mass, pos, vel)
    local result = {
        name = name,
        icon = icon,
        mass = mass, -- mass in kg * 10^11
        pos  = {},   -- position
        vel  = {},   -- velocity
        acc  = {},   -- acceleration
        update = function(self)
            for i=0,ndim-1 do
                self.acc[i] = 0
            end
            for _,body in ipairs(bodies) do
                if body == self then
                    goto continue
                end

                local d = {}
                local dist = 0
                for i=0,ndim-1 do
                    d[i] = body.pos[i] - self.pos[i]
                    dist = dist + d[i] * d[i]
                end
                dist = math.sqrt(dist)

                local g = 6.67 * body.mass / dist / dist

                for i=0,ndim-1 do
                    self.acc[i] = self.acc[i] + g * d[i] / dist
                end
                ::continue::
            end
        end,
        move = function(self)
            for i=0,ndim-1 do
                self.vel[i] = self.vel[i] + self.acc[i] / (60 * tps_mult)
                self.pos[i] = self.pos[i] + self.vel[i] / (60 * tps_mult)
            end
        end,
        render = function(self, xoff, yoff)
            local xr = xoff + math.floor(self.pos[0] / scale + 0.5)
            local yr = yoff + math.floor(self.pos[1] / scale + 0.5)

            spr(icon, xr - 4, yr - 4)

            if gui.body_info >= 1 then
                do -- write position
                    local str = ''
                    for i=0,ndim-1 do
                        if i ~= 0 then
                            str = str .. ' '
                        end
                        str = str .. math.floor(self.pos[i] + 0.5)
                    end
                    write(str, 0xffffff, xr + 4, yr - 4 - font_h)
                end

                draw_line(xr, yr, self.vel[0], self.vel[1], 0xffff00)
                draw_line(xr, yr, self.acc[0], self.acc[1], 0xff0000)
            end

            if gui.body_info >= 2 then
                do -- write velocity
                    local str = ''
                    for i=0,ndim-1 do
                        if i ~= 0 then
                            str = str .. ' '
                        end
                        str = str .. math.floor(self.vel[i] + 0.5)
                    end
                    write(str, 0xffff00, xr + 4, yr - 4)
                end
                do -- write acceleration
                    local str = ''
                    for i=0,ndim-1 do
                        if i ~= 0 then
                            str = str .. ' '
                        end
                        str = str .. math.floor(self.acc[i] + 0.5)
                    end
                    write(str, 0xff0000, xr + 4, yr - 4 + font_h)
                end
            end
        end
    }

    for i=0,ndim-1 do
        -- hack around arrays starting at 1
        result.pos[i] = pos[i + 1]
        result.vel[i] = vel[i + 1]

        result.acc[i] = 0
    end

    return result
end

function init()
    settransparent(0x000000)

    gui = {
        body_info = 0,
        generic_info = true
    }

    offset = {}
    offset[0] = 0
    offset[1] = 0

    -- variables that must be set:
    --     ndim     - number of dimensions
    --     tps_mult - tps multiplier
    --     scale    - scale at the beginning
    --     bodies   - a set of bodies made by new_body
    loadscript('config.lua')
end

function tick()
    for _=1,tps_mult do
        for _,body in ipairs(bodies) do
            body:update()
        end
        for _,body in ipairs(bodies) do
            body:move()
        end
    end

    -- move camera
    local xm = 0
    local ym = 0
    if key(0) then ym = ym - 1 end
    if key(1) then xm = xm - 1 end
    if key(2) then ym = ym + 1 end
    if key(3) then xm = xm + 1 end

    offset[0] = offset[0] - xm
    offset[1] = offset[1] - ym

    -- adjust scale
    if     scroll() < 0 then scale = scale - 1
    elseif scroll() > 0 then scale = scale + 1 end

    if scale == 0 then
        scale = 1
    end

    -- toggle info
    if key_pressed(4) then
        gui.body_info = (gui.body_info + 1) % 3
    end
    if key_pressed(5) then
        gui.generic_info = not gui.generic_info
    end
end

function render()
    clear(0x000000)

    local xoff = scr_w / 2 + offset[0]
    local yoff = scr_h / 2 + offset[1]

    for _,body in ipairs(bodies) do
        body:render(xoff, yoff)
    end

    if gui.generic_info then
        write("scale: " .. scale, 0xaaaaaa, 1, scr_h - font_h)
    end
end
