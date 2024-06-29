local vide = require(script.Parent.Parent.Parent.Parent.vide)
local constants = require(script.Parent.Parent.Parent.modules.constants)
local icons = require(script.Parent.Parent.Parent.modules.icons)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local tween = require(script.Parent.Parent.Parent.modules.tween)
local base_button = require(script.Parent.base_button)

local create = vide.create
local source = vide.spring
local spring = vide.spring
local effect = vide.effect

type can<T> = (() -> T) | T
type props = {
	toggled: () -> (),
	update_toggled: (new: boolean) -> (),

	position: can<UDim2>?,
	zindex: can<number>?
}

return function(props: props)

	local position = spring(
		function()
			return if props.toggled() then
				UDim2.new(0.5, 0, 0, 3)
			else
				UDim2.new(0, 3, 0, 3)
		end,
		0.15
	)
	local function size()
		local distance = 0.25 - math.abs(0.25 - position().X.Scale)

		return UDim2.new(0, 18 + distance * 32, 0, 18)
	end


	return base_button {
		size = UDim2.fromOffset(41, 24),
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

		rounded_value = 1,
		zindex = props.zindex,

		create "Frame" {

			Size = UDim2.fromScale(1, 1),

			BackgroundTransparency = 1,

			create "ImageLabel" {

				Size = size,
				Position = position,

				BackgroundTransparency = 1,

				Image = constants.rounded.id,
				ImageColor3 = scheme:consume().Elevation[2],
	
			},

		},

		activated = function()
			props.update_toggled(not props.toggled())
		end

	}

end