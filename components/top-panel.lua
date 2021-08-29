--      ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--         ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--         ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--         ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--         ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
local screen = awful.screen.focused()


-- import widgets
local task_list = require("widgets.task-list")
local tag_list = require('widgets.tag-list')
local vseparator = require("widgets.vertical-separator")
local battery = require('widgets.battery')
local layout_box = require("widgets.layout-box")
local calendar = require("widgets.calendar")

-- define module table
local top_panel = {}


--create separator
wibox.widget {
    separator = wibox.widget.separator
}

local taskbarWidth = screen.geometry.width / 25 * 17

-- ===================================================================
-- Bar Creation
-- ===================================================================


top_panel.create = function(s)
   local panel = awful.wibar({
      bg = "#00000000",
      border_width = 3,
      border_color = "#00000000",
      screen = s,
      position = "top",
      shape = gears.shape.rounded_bar,
      height = beautiful.top_panel_height,
      width = s.geometry.width,
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      {
         layout = wibox.layout.fixed.horizontal,
         vseparator,
         tag_list.create(s),
         vseparator,
         wibox.container.constraint (task_list.create(s), 'max', taskbarWidth, dpi(28)),
      },
         separator,
      {
         layout = wibox.layout.fixed.horizontal,
         {
               	wibox.layout.margin(wibox.widget.systray(true), 5, 5, 3, 3),
              	shape = gears.shape.rounded_bar,
               	bg = "#283039",
              	widget = wibox.container.background
         },
         vseparator,
         {
               	battery,
               	shape = gears.shape.rounded_bar,
              	bg = "#283039",
               	widget = wibox.container.background
         },
         vseparator,
         {
               	layout_box,
               	shape = gears.shape.rounded_bar,
               	bg = "#283039",
               	widget = wibox.container.background
         },
         vseparator,
         {
               	calendar,
               	shape = gears.shape.rounded_bar,
               	bg = "#283039",
               	shape_clip = true,
               	widget = wibox.container.background
         },
         vseparator,

      }
   }
end

return top_panel
