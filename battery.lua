local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")


local battery = {}


battery = wibox.widget.textbox()
battery:set_align("right")

battery.config = {
   textbegin = " Bat: ",
   textend = "%",
   textperso,
   icon = awful.util.getdir("config") .. "/images/battery.png"
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

	  if capacitynumber < 20 then
		 
		 naughty.notify({ title = "Low battery ! ",
						  text = "Plug your cable to the sector",
						  icon=battery.config.icon })

	  end
   end
   
   if widget.config.textperso == nil then
	  widget:set_markup(battery.config.textbegin .. battery.info.capacity .. battery.config.textend)
   else
	  widget:set_markup(widget.config.textperso)	  
   end

end

return battery



