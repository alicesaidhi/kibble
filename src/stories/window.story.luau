local vide = require(script.Parent.Parent.Parent.vide)
local app_bar_button = require(script.Parent.Parent.components.controls.app_bar_button)
local app_tab_bar_button = require(script.Parent.Parent.components.controls.app_tab_bar_button)
local app_tab_bar = require(script.Parent.Parent.components.views.app_tab_bar)
local bottom_app_bar = require(script.Parent.Parent.components.views.bottom_app_bar)
local top_app_bar = require(script.Parent.Parent.components.views.top_app_bar)
local window = require(script.Parent.Parent.components.views.window)
local icons = require(script.Parent.Parent.modules.icons)
local safe_story = require(script.Parent.safe_story)

local create = vide.create
local source = vide.source

return function(target)

	local s = source(1)

	return safe_story(function()
		
		return window {

			top_app_bar {
				icon = "",
				title = "gorp",
				subtitle = "Registry Editor",

				app_bar_button {
					icon = icons["sunset"],
				}
			},

			bottom_app_bar {

				app_tab_bar {

					app_tab_bar_button {
						icon = icons["CD"],
						state = function()
							return s() == 1
						end,
	
						activated = function()
							s(1)
						end
					},
	
					app_tab_bar_button {
						icon = icons["alarm-clock-off"],
						state = function()
							return s() == 2
						end,
	
						activated = function()
							s(2)
						end
					}

				}
			}

		}
		
	end, target)
end