
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local constants = require(script.Parent.Parent.Parent.modules.constants)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local divider = require(script.Parent.Parent.divider)

local create = vide.create

return function(props)

	return create "Frame" {
		Name = "BottomAppBar",

		Size = UDim2.new(1, 0, 0, 50),
		Position = UDim2.fromScale(0, 1),
		AnchorPoint = Vector2.new(0, 1),

		BackgroundTransparency = 1,

		divider {
			ZIndex = 2
		},

		create "ImageLabel" {
			
			Name = "Content",

			Size = UDim2.fromScale(1, 1),

			BackgroundTransparency = 1,

			Image = constants.bottom_rounded.id,
			ImageColor3 = scheme:consume().Elevation[4],
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = constants.bottom_rounded.center,
			SliceScale = constants.rounded_values[8],

			unpack(props)

		}
	}
end