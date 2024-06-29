local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local icon_button = require(script.Parent.icon_button)


type can<T> = (() -> T) | T
type props = {

	icon: can<string>?,
	text: can<string>?,
	layout_order: can<number>?,

	activated: (() -> ())?

}

return function(props: props)
	return icon_button {

		icon_size = UDim2.fromScale(0.5, 0.5),
		icon = props.icon,
		layout_order = props.layout_order,
		
		foreground_color = scheme:consume().Color.Text.Secondary,

		activated = props.activated,

		layout = {
			size = UDim2.fromScale(0.8, 0.8),
			background_opacity = 1
		}

	}
end