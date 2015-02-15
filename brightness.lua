local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

local brightness = {}

brightness = wibox.widget.textbox()
brightness:set_align("right")

brightness.config = {
   textbegin = " Bri: ",
   textend = "%",
   textperso,
   icon = awful.util.getdir("config") .. "/images/brightness.png"
}

brightness.info = {
   status,
   raw
}

function brightness.update(widget)
   local statusio = io.popen("xbacklight")
   brightness.info.raw = statusio:read("*all")

   statusio:close()

   local statustmp = string.match(brightness.info.raw, "%d?%d?%d")
   brightness.info.status = string.format("% 3d", statustmp)

   if widget.config.textperso == nil then
	  widget:set_markup(brightness.config.textbegin .. brightness.info.status .. brightness.config.textend)
   else
	  widget:set_markup(widget.config.textperso)	  
   end

end

return brightness
