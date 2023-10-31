local name_pools = {
    -- nodeJS
    {
        'index.js',
        'package.json',

        'user.js',
        'class.js',
        'store.js',
        'game.js',
        'login.js',
        'register.js',
        'delete.js',
        'report.js',
        'modules.js',
        'routes.js',

        'page.ejs',
        'template.ejs',
        'info.ejs'
    },

    -- php
    {
        'index.php',

        'config.php',
        'login.php',
        'preview.php',
        'register.php',
        'contacts.php',
        'profile.php',
        'personal.php',
        'public.php',
        'database.php',
        'neo.php',
        'header.php',
        'footer.php',

        'links.json',
    },

    -- hidden
    {
        '.gitignore',
        '.gitattributes'
    }
}

local function new_Room(name)
    local room = {
        name = name,

        tick = function(self)
            for i,e in ipairs(self.entities) do
                e:tick()
            end
        end,

        render = function(self)
            maprender()

            for i,e in ipairs(self.entities) do
                e:render()
            end
        end,

        entities = {},
        enemy_count = 0,

        insert = function(self, entity)
            if entity.is_enemy then
                self.enemy_count = self.enemy_count + 1
            end

            table.insert(self.entities, entity)
        end,

        remove = function(self, entity)
            for i,e in ipairs(self.entities) do
                if e == entity then
                    if entity.is_enemy then
                        self.enemy_count = self.enemy_count - 1

                        if self.enemy_count == 0 then
                            level:insert(
                                new_Portal_particle(
                                    math.random(0, map_w),
                                    math.random(0, map_h)
                                )
                            )
                        end
                    end

                    table.remove(self.entities, i)
                    break
                end
            end
        end
    }

    return room
end

local function generate_rooms(name_pool)
    local result = {}

    local room_count = math.random(5, #name_pool)
    local used_names = {}

    result[1] = new_Room(name_pool[1])

    do -- clone name_pool (removing the first name)
        local new_table = {}
        for i=2,#name_pool do
            new_table[i - 1] = name_pool[i]
        end
        name_pool = new_table
    end

    for i=2,room_count do
        local name_index = math.random(1, #name_pool)
        local name = name_pool[name_index]
        table.remove(name_pool, name_index)

        result[i] = new_Room(name)
    end

    return result
end

function new_Level()
    local result = {
        tick = function(self)
            self.room:tick()
        end,

        render = function(self)
            self.room:render()
        end,

        insert = function(self, entity)
            self.room:insert(entity)
        end,

        remove = function(self, entity)
            self.room:remove(entity)
        end
    }

    local name_pool = name_pools[math.random(1, #name_pools - 1)]

    result.rooms = generate_rooms(name_pool)

    result.room_index = 1
    result.room = result.rooms[1]

    return result
end
