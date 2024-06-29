local vide = require(script.Parent.Parent.Parent.Parent.vide)

local create = vide.create
local source = vide.source
local ref = vide.action
local effect = vide.effect

type can<T> = (() -> T) | T
type props = {

	size: can<UDim2>?,
	position: can<UDim2>?,
	anchor_point: can<Vector2>?,
	automatic_size: can<Enum.AutomaticSize>?,

	transparency: () -> number,
	layer: Instance

}

return function(props: props)

	local function display_canvas()
		return props.transparency() > 0
	end

	local canvas = source()
	local opaque = source()

	effect(function()
		if display_canvas() then
			props.layer.Parent = canvas()
		else
			props.layer.Parent = opaque()
		end
	end)

	return create "Frame" {
		Name = "AnimationLayer",

		Size = props.size or UDim2.fromScale(1, 1),
		Position = props.position,
		AnchorPoint = props.anchor_point,
		AutomaticSize = props.automatic_size,
		BackgroundTransparency = 1,

		create "CanvasGroup" {
			Name = "Transparent",

			Size = UDim2.fromScale(1, 1),
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,

			GroupTransparency = props.transparency,

			ref(canvas)
		},

		create "Frame" {
			Name = "Opaque",

			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,

			ref(opaque)
		}

	}
end