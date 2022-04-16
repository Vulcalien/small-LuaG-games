-- Copyright 2022 Vulcalien
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

function init()
    ticks = 0

    score = 0

    game_w = 20
    game_h = 19

    settransparent(0xff00ff)

    loadscript('player.lua')
    loadscript('food.lua')

    loadscript('panel/start.lua')
    loadscript('panel/credits.lua')
    loadscript('panel/game.lua')
    loadscript('panel/pause.lua')
    loadscript('panel/gameover.lua')

    current_panel = start_panel

    food:spawn()
end

function tick()
    ticks = ticks + 1

    current_panel:tick()
end

function render()
    local background_color = math.floor(
        math.abs(math.sin(ticks / 120)) * 0x11 + 0x44
    ) << 8
    clear(background_color)

    current_panel:render()
end
