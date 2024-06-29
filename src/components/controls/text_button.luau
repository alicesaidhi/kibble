local vide = require(script.Parent.Parent.Parent.Parent.vide)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local base_button = require(script.Parent.base_button)

local create = vide.create

type can<T> = (() -> T) | T
type props = {

	text: can<string>?,
	foreground_color: can<Color3>?,
	foreground_opacity: can<number>?,
	
	activated: (() -> ())?,

	layout: base_button.props?

}

return function(props: props)

	local layout = props.layout or {}

	layout.activated = props.activated

	table.insert(layout, create "TextLabel" {

		Name = "Text",

		Size = UDim2.fromScale(0, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		Text = props.text,
		TextColor3 = props.foreground_color or scheme:consume().Color.Text.Primary,
		TextTransparency = props.foreground_opacity,
		Font = scheme:consume().Typography.Button.Font,
		TextSize = scheme:consume().Typography.Button.Size,

	})

	return base_button(layout)

end