function new_Item(name, icon, icon_col)
    return {
        name = name,
        icon = icon,
        icon_col = icon_col,

        use = function(self, player) end,

        render = function(self, x, y)
            spr(self.icon, x, y, { col_mod = self.icon_col })
        end
    }
end
