local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")


local volume = {}

volume = wibox.widget.textbox()
volume:set_align("right")

volume.config = {
   textbegin = " Vol: ",
   textend = "%",
   textperso,
   icon = awful.util.getdir("config") .. "/images/volume.png"
}

volume.info = {
   raw,
   status,
   percentage
}

function volume.update(widget)
   local statusio = io.popen("amixer sget Master")
   volume.info.raw = statusio:read("*all")
   
   local statustmp = string.match(volume.info.raw, "(%d?%d?%d)%%")
   volume.info.percentage = string.format("% 3d", statustmp)

   volume.info.status = string.match(volume.info.raw, "%[(o[^%]]*)%]")
   statusio:close()

   --create a string for the notification
   percentagenumber = tonumber(volume.info.percentage)

   if widget.config.textperso == nil then
	  widget:set_markup(volume.config.textbegin .. volume.info.percentage .. volume.config.textend )
   else
	  widget:set_markup(widget.config.textperso)	  
   end
end

return volume
