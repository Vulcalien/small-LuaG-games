food = {
    spawn = function(self)
        ::try_again::

        local x = math.random(0, game_w - 1)
        local y = math.random(0, game_h - 1)

        if x == player.head.x or y == player.head.y then
            goto try_again
        end

        for _,part in ipairs(player.body) do
            if x == part.x or y == part.y then
                goto try_again
            end
        end

        self.x = x
        self.y = y
    end,

    render = function(self)
        spr(22, self.x * 8, self.y * 8, {
            col_mod = 0xff0000
        })
    end
}
