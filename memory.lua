local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local math = require("math")

local memory = {}


memory = wibox.widget.textbox()
memory:set_align("right")

memory.config = {
   textbegin = " Ram: ",
   textend = "%",
   textperso,
   icon = awful.util.getdir("config") .. "/images/battery.png"
}


memory.info = {
   total,
   free,
   inuse,
   inusepercentage,
   cached,
   swap = {
	  total,
	  free,
   },
   status
}

function memory.update(widget)

   local memtmp = {
		 f, -- free 
		 b, -- buffered 
		 c, -- cached
   }
	 
   
   for line in io.lines("/proc/meminfo") do
	  for i, j in string.gmatch(line,"([%a]+):[%s]+([%d]+).+") do
		 if i == "MemTotal" then memory.info.total = math.floor(j/1024)
		 elseif i == "MemFree" then memtmp.f = math.floor(j/1024)
		 elseif i == "Buffers" then memtmp.b = math.floor(j/1024)
		 elseif i == "Cached" then memtmp.c = math.floor(j/1024)
		 elseif i == "SwapTotal" then memory.info.swap.total = math.floor(j/1024)
		 elseif i == "SwapFree" then memory.info.swap.free = math.floor(j/1024)
		 end
	  end
   end
   
   memory.info.free = memtmp.f + memtmp.b + memtmp.c
   memory.info.inuse = memory.info.total - memory.info.free
   memory.info.inusepercentage = math.floor(memory.info.inuse / memory.info.total * 100)

   if widget.config.textperso == nil then
	  widget:set_markup(memory.config.textbegin .. memory.info.inusepercentage .. memory.config.textend)
   else
	  widget:set_markup(widget.config.textperso)	  
   end
end

return memory
