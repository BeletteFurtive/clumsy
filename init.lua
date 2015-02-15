local clumsy = {}

battery = require("clumsy.battery")
volume = require("clumsy.volume")
brightness = require("clumsy.brightness")
memory = require("clumsy.memory")

function clumsy.widget(wi, timing, format)
   local widget
   
   if wi == "battery" then widget = battery
   elseif wi == "volume" then widget = volume
   elseif wi == "brightness" then widget = brightness
   elseif wi == "memory"  then widget = memory
   end

   if format == nil then
	  widget.config.textperso = nil
   else
	  widget.config.textperso = format
   end

   if timing == nil then
	  timing = 5
   end
	  
   clumsy.update(widget, timing)
   return widget
end


function clumsy.update(widget, timing)

   widget.update(widget)

   mytimer = timer({timeout = timing})
   mytimer:connect_signal("timeout", function()widget.update(widget) end)
   mytimer:start()

   
end


return clumsy



