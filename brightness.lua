local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

local brightness = {}

brightness = wibox.widget.textbox()
brightness:set_align("right")

brightness.config = {
   textbegin = " Bri: ",
   textend = "%",
   color1 = "#CCCCCC",
   color2 = "#CCCCCC",
   colortmp = "#CCCCCC"
   --icon = awful.util.getdir("config") .. "/images/brightness.png"
}

brightness.info = {
   status,
   raw
}

function brightness.update(widget)
   local statusio = io.popen("xbacklight")
   widget.info.raw = statusio:read("*all")

   statusio:close()

   local statustmp = string.match(brightness.info.raw, "%d?%d?%d")
   brightness.info.status = string.format("% 3d", statustmp)

   widget:set_markup('<span color="'.. widget.config.color1 .. '">' .. widget.config.textbegin ..'</span> <span color="' .. widget.config.color2 .. '">'..  widget.info.status .. brightness.config.textend .. '</span>')
   
end

return brightness
