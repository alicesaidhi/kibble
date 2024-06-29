local vide = require(script.Parent.Parent.Parent.vide)
local scheme = require(script.Parent.Parent.modules.scheme)

local create = vide.create

type props = {[any]: any}

return function(props: props)
	return create "Frame" {

		Name = "Divider",

		--todo: figure out a cleaner way to handle this
		BackgroundColor3 = scheme:consume().Color.Divider,
		ZIndex = 1,

		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 0, 0),
		AnchorPoint = Vector2.new(0, 0),

		props
	}
end