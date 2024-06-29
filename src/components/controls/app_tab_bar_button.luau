local vide = require(script.Parent.Parent.Parent.Parent.vide)
local icons = require(script.Parent.Parent.Parent.modules.icons)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local tooltip = require(script.Parent.Parent.views.tooltip)
local icon_button = require(script.Parent.icon_button)

local read = vide.read
local spring = vide.spring

type can<T> = (() -> T) | T
type props = {
	icon: can<string>?,
	state: (() -> boolean),
	layout_order: can<number>?,

	activated: (() -> ())?,

}

return function(props)

	return icon_button {

		icon = props.icon or icons["loader-2"],
		icon_size = UDim2.fromScale(0.5, 0.5),

		foreground_color = function()
			return if read(props.state) then scheme:consume().Accent else scheme:consume().Color.Text.Secondary
		end,
		layout_order = props.layout_order,

		activated = props.activated,

		layout = {
			size = UDim2.fromScale(0.8, 0.8),
			
			background_color = scheme:consume().Accent,
			background_opacity = spring(function()
				return if read(props.state) then 0.9 else 1
			end, 0.1),

			tooltip {

				text = props.text

			}
		},

	}

end