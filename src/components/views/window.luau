local vide = require(script.Parent.Parent.Parent.Parent.vide)
local constants = require(script.Parent.Parent.Parent.modules.constants)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local shadow = require(script.Parent.Parent.shadow)

local create = vide.create
local derive = vide.derive
local read = vide.read

type can<T> = (() -> T) | T
type props = {

	aspect_ratio: () -> number

}

return function(props)

	local should_create_aspect_ratio = derive(function()
		return props.aspect_ratio and read(props.aspect_ratio) > 0
	end)

	return create "Frame" {
		Name = "Window",

		Size = UDim2.fromOffset(700, 700),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		BackgroundTransparency = 1,

		function()
			return if should_create_aspect_ratio() then
					create "UIAspectRatioConstraint" {
						AspectRatio = props.aspect_ratio,
						AspectType = Enum.AspectType.ScaleWithParentSize,
						DominantAxis = Enum.DominantAxis.Width
					}
				else
					{}
		end,

		create "ImageLabel" {
			Name = "Content",

			Size = UDim2.fromScale(1, 1),

			BackgroundTransparency = 1,

			Image = constants.rounded.id,
			ImageColor3 = scheme:consume().Elevation[2],
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = constants.rounded.center,
			SliceScale = constants.rounded_values[8],

			unpack(props)

		},

		shadow {
			elevation = constants.elevation[4],
			layout = {ZIndex = 0}
		}
	}

end
