local vide = require(script.Parent.Parent.Parent.Parent.vide)
local icons = require(script.Parent.Parent.Parent.modules.icons)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local base_button = require(script.Parent.base_button)

local create = vide.create
local spring = vide.spring

type can<T> = (() -> T) | T
type props = {
	toggled: () -> (),
	update_toggled: (new: boolean) -> (),

	position: can<UDim2>?,
	zindex: can<number>?
}

return function(props: props)

	return base_button {
		size = UDim2.fromOffset(24, 24),
		position = props.position,

		background_color = spring(function()
			return if props.toggled() then
				scheme:consume().Accent
			else
				scheme:consume().Color.Text.Primary
		end, 0.1),
		background_opacity = spring(function()
			return if props.toggled() then
				0
			else
				0.6
		end, 0.1),

		create "Frame" {

			Size = UDim2.fromScale(0.7, 0.7),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),

			BackgroundTransparency = 1,

			create "ImageLabel" {

				Size = spring(function()
					return props.toggled() and UDim2.fromScale(1, 1) or UDim2.fromScale(0, 1)
				end, 0.2),
	
				BackgroundTransparency = 1,
	
				Image = icons.check,
				ImageColor3 = scheme:consume().Elevation[2],

				ImageRectSize = spring(function()
					return props.toggled() and Vector2.new(1024, 1024) or Vector2.new(0, 1024)
				end, 0.2),
				-- ImageTransparency = spring(function()
				-- 	return props.toggled() and 0 or 1
				-- end, 0.1),
	
			},

		},

		activated = function()
			props.update_toggled(not props.toggled())
		end

	}

end