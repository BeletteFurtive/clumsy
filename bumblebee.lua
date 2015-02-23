local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

local bumblebee = {}

bumblebee = wibox.widget.textbox()
bumblebee:set_align("right")

bumblebee.config = {
   textbegin = " Nvidia: ",
   textend = "off",
   color1 = "#CCCCCC",
   color2 = "#CCCCCC",
   colortmp = "#CCCCCC"
   --icon = awful.util.getdir("config") .. "/images/brightness.png"
}

bumblebee.info = {
   status,
   raw
}

function bumblebee.update(widget)
   local statusio = io.popen("cat /proc/acpi/bbswitch")
   bumblebee.info.raw = statusio:read("*all")
   statusio:close()

   widget.info.status = string.match(bumblebee.info.raw, "%u%u%u?")

   if widget.info.status == "ON" then
	  widget.config.textend = "on" 

   elseif widget.info.status == "OFF" then
	  widget.config.textend = "off" 
   end

   widget:set_markup('<span color="'.. widget.config.color1 .. '">' .. widget.config.textbegin ..'</span> <span color="' .. widget.config.color2 .. '">'.. widget.config.textend..'</span>')

end


return bumblebee
