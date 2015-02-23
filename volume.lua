local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")


local volume = {}

volume = wibox.widget.textbox()
volume:set_align("right")

volume.config = {
   textbegin = " Vol: ",
   textend = "%",
   color1 = "#CCCCCC",
   color2 = "#D61326",
   colortmp = "#CCCCCC",
   --icon = awful.util.getdir("config") .. "/images/volume.png"
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
   widget.info.percentage = string.format("% 3d", statustmp)

   widget.info.status = string.match(volume.info.raw, "%[(o[^%]]*)%]")
   statusio:close()
   

   if widget.info.status == "off" then
	  widget.config.textend = "M" 
	  widget.config.color2 = "#D61326"
   elseif widget.info.status == "on" then
	  widget.config.textend = "%"
	  widget.config.color2 =  widget.config.colortmp
   end

   
   widget:set_markup('<span color="'.. widget.config.color1 .. '">' .. widget.config.textbegin ..'</span> <span color="' .. widget.config.color2 .. '">'..widget.info.percentage .. widget.config.textend..'</span>')

end

return volume
