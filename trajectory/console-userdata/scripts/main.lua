function new_body(name, mass, pos, vel)
    local result = {
        name = name,
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
                    break
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

            pix(xr, yr, 0xffffff)
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
end

function render()
    local xoff = scr_w / 2 + offset[0]
    local yoff = scr_h / 2 + offset[1]

    for _,body in ipairs(bodies) do
        body:render(xoff, yoff)
    end
end
