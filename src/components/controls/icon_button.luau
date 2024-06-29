local vide = require(script.Parent.Parent.Parent.Parent.vide)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local base_button = require(script.Parent.base_button)

local create = vide.create

type can<T> = (() -> T) | T
export type props = {

	icon: can<string>?,
	icon_size: can<UDim2>?,
	foreground_color: can<Color3>?,

	activated: (() -> ())?,

	layout: base_button.props?

}

return function(props: props)

	local layout = props.layout or {}

	layout.activated = props.activated

	table.insert(layout, {
		create "UIAspectRatioConstraint" {
			AspectRatio = 1
		},

		create "ImageLabel" {
			Size = props.icon_size or UDim2.fromScale(0.45, 0.45),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),

			BackgroundTransparency = 1,
			Image = props.icon,
			ImageColor3 = props.foreground_color or scheme:consume().Color.Text.Primary

		}
	})

	return base_button(layout)

end