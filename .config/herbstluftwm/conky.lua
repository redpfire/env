-- vim: ts=4 sw=4 noet ai cindent syntax=lua

--[[
Conky, a system monitor, based on torsmo
]]

conky.config = {
    out_to_x = false,
    out_to_console = true,
    short_units = true,
    update_interval = 1
}

-- http://fontawesome.io/
FontAwesome = '^fn(Font Awesome 5 Free:style=Solid:pixelsize=10)'

-- icon
preIcon  = '^fg(\\#ffffff)' .. FontAwesome
postIcon = '^fn()^fg()'

--[[
Segment
]]


conkyPre = 'conky\t^fg(\\#ffffff)'
timeIcon     = ' ' .. preIcon .. '' .. postIcon .. ' '
ssidIcon 	 = ' ' .. preIcon .. '' .. postIcon .. ' '

batteryFull 			= ' ' .. preIcon .. '' .. postIcon .. ' '
batteryThreeQuarters 	= ' ' .. preIcon .. '' .. postIcon .. ' '
batteryHalf 			= ' ' .. preIcon .. '' .. postIcon .. ' '
batteryQuarter 			= ' ' .. preIcon .. '' .. postIcon .. ' '
batteryCritical 		= ' ' .. preIcon .. '^fg(\\#ee0000)' .. '' .. postIcon .. ' '

memIcon = ' ' .. preIcon .. '' .. postIcon .. ' '

battery = [[\
${if_match ${battery_percent}<=15}\
]] .. batteryCritical .. '++${battery_percent}%' .. [[
${else}${if_match ${battery_percent}<=25}\
]] .. batteryQuarter .. '++${battery_percent}%' .. [[
${else}${if_match ${battery_percent}<=50}\
]] .. batteryHalf .. '++${battery_percent}%' .. [[
${else}${if_match ${battery_percent}<=75}\
]] .. batteryThreeQuarters .. '++${battery_percent}%' .. [[
${else}${if_match ${battery_percent}>75}\
]] .. batteryFull .. '++${battery_percent}%' .. [[
${endif}${endif}${endif}${endif}${endif}\
]]

ssidText = ssidIcon .. '${wireless_essid wlp1s0}'

memText = memIcon .. ' ${mem}/${memmax}'

--[[
Execute Conky
]]

conky.text = [[\
]] .. conkyPre .. [[\
 \
]] .. '[${battery_short}]' .. [[\
 \
]] .. battery .. [[\
 \
]] .. memText .. [[\
 \
]] .. ssidText .. [[\
 \
]] .. timeIcon ..[[\
]]
