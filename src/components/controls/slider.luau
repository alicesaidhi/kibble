local UserInputService = game:GetService("UserInputService")

local vide = require(script.Parent.Parent.Parent.Parent.vide)
local constants = require(script.Parent.Parent.Parent.modules.constants)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local tooltip = require(script.Parent.Parent.views.tooltip)
local base_button = require(script.Parent.base_button)

local create = vide.create
local source = vide.source
local cleanup = vide.cleanup
local effect = vide.effect
local read = vide.read
local spring = vide.spring

type can<T> = (() -> T) | T
type props = {

	value: () -> number,
	update_value: (new: number) -> (),
	max: can<number>,

	stepper: can<number>?,
	position: can<UDim2>?,
	width: can<number>?,
	gradient_color: can<ColorSequence>?,

}

return function(props: props)

	local is_listening = source(false)

	local bar = base_button {

		size = UDim2.new(0, 200, 0, 8),
		position = props.position,
		rounded_value = 1,

		create "UISizeConstraint" {
			MaxSize = Vector2.new(math.huge, 8),
			MinSize = Vector2.new(0, 8)
		},

		create "UIGradient" {
			Color = props.gradient_color,
			Offset = spring(function()
				return Vector2.new(props.value() / read(props.max) - 0.5, 0)
			end, 0.1)
		},

		base_button {

			size = UDim2.fromScale(3, 3),
			position = spring(function()
				return UDim2.fromScale(props.value() / read(props.max), 0.5)
			end, 0.1),
			anchor_point = Vector2.new(0.5, 0.5),
			rounded_value = 1,

			background_color = scheme:consume().Accent,
			background_opacity = 0,
			zindex = 3,

			down = function()
				is_listening(true)
			end,

			up = function()
				is_listening(false)
			end,

			create "UIAspectRatioConstraint" {
				AspectRatio = 1
			},

			create "ImageLabel" {
				Size = spring(function()
					return if is_listening() then UDim2.fromScale(0.6, 0.6)
					else UDim2.fromScale(0.7, 0.7)
				end, 0.2),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),

				BackgroundTransparency = 1,

				ImageColor3 = scheme:consume().Elevation[4],
				Image = constants.rounded.id,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = constants.rounded.center,
				SliceScale = 1,
			},

			tooltip {
				text = function()
					return string.format("%.10g", props.value())
				end,
				visible = is_listening
			}

		},

		down = function()
			is_listening(true)
		end,

		up = function()
			is_listening(false)
		end

	}

	local function get_closest_step(value: number)
		local step = read(props.stepper) or 0
		if step == 0 then return value end
		local closest = math.round(value / step) * step
		return closest
	end

	local function update(input: InputObject)

		if is_listening() then
			local percentage

			if table.find({
				Enum.UserInputType.MouseMovement,
				Enum.UserInputType.Touch,
				Enum.UserInputType.MouseButton1
			}, input.UserInputType) then
				local delta = input.Position.X - bar.AbsolutePosition.X
				percentage = delta / bar.AbsoluteSize.X
			end

			if percentage then
				local nearest = get_closest_step(math.clamp(percentage, 0, 1) * read(props.max))
				props.update_value(nearest)
			end
		end

	end

	cleanup(UserInputService.InputChanged:Connect(update))
	cleanup(UserInputService.InputBegan:Connect(update))
	cleanup(UserInputService.InputEnded:Connect(function(input)
		if not is_listening() then return end
		if table.find({
			Enum.UserInputType.MouseMovement,
			Enum.UserInputType.Touch,
			Enum.UserInputType.MouseButton1
		}, input.UserInputType) then
			is_listening(false)
		end
	end))
	
	effect(function()
		props.update_value(get_closest_step(math.clamp(props.value() / read(props.max), 0, 1) * read(props.max)))
	end)

	return bar
end