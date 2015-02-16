local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")


local battery = {}


battery = wibox.widget.textbox()
battery:set_align("right")

battery.config = {
   textbegin = " Bat: ",
   textend = "%",
   color1 = "#CCCCCC",
   color2 = "#CCCCCC",
   colortmp = "#CCCCCC"
   --icon = awful.util.getdir("config") .. "/images/battery.png"
}


battery.info = {
   capacity,
   status
}

function battery.update(widget)
   
   local capacityio = io.popen("cat /sys/class/power_supply/BAT0/capacity")
   local statusio = io.popen("cat /sys/class/power_supply/BAT0/status")

   battery.info.capacity =  capacityio:read()
   battery.info.status = statusio:read()

   capacityio:close()
   statusio:close()

   local capacitynumber = tonumber(battery.info.capacity)

   if battery.info.status:match("Discharging") then
	  widget.config.textend = "%↓" 
	  widget.config.color2 = "#D61326"

	  if capacitynumber < 20 then
		 
		 naughty.notify({ title = "Low battery ! ",
						  text = "Plug your cable to the sector",
						  icon=battery.config.icon })
		 widget.config.color2 = "#FF0000"
		 
	  end

   else
	  widget.config.textend = "%↑" 
	  widget.config.color2 = widget.config.colortmp
	  
   end
   
   widget:set_markup('<span color="'.. widget.config.color1 .. '">' .. widget.config.textbegin .. '</span> <span color="' .. widget.config.color2 .. '">' .. widget.info.capacity .. widget.config.textend .. '</span>')

end

return battery



