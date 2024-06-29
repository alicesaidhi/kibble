local vide = require(script.Parent.Parent.Parent.Parent.vide)
local constants = require(script.Parent.Parent.Parent.modules.constants)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local shadow = require(script.Parent.Parent.shadow)
local delay = require(script.Parent.Parent.Parent.modules.delay)
local transparent = require(script.Parent.Parent.animation.transparent)

local create = vide.create
local source = vide.source
local spring = vide.spring
local read = vide.read

type props = {

	text: string,
	visible: (() -> boolean)?,
	position: (() -> UDim2) | UDim2?,
	anchor_point: (() -> Vector2) | Vector2?

}

return function(props: props)

	local hovering = source(false)
	local visible = delay(2, hovering)

	local function is_visible()
		return hovering() and visible() or read(props.visible)
	end

	return {

		MouseEnter = function()
			hovering(true)
		end,

		MouseLeave = function()
			hovering(false)
		end,

		transparent {

			position = props.position or UDim2.new(0.5, 0, 0, -6),
			anchor_point = props.anchor_point or Vector2.new(0.5, 1),
			automatic_size = Enum.AutomaticSize.XY,
			size = UDim2.new(),

			transparency = spring(function()
				return is_visible() and 0 or 1
			end, 0.25),

			layer = create "Frame" {

				Size = UDim2.fromScale(1, 1),
				
				BackgroundTransparency = 1,
		
				create "ImageLabel" {
		
					Size = spring(function()
						return is_visible() and UDim2.new(1, -2, 1, -2) or UDim2.new(1, -24, 1, -4)
					end, 0.4),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
		
					BackgroundTransparency = 1,
		
					Image = constants.rounded.id,
					ImageColor3 = scheme:consume().Elevation[4],
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = constants.rounded.center,
					SliceScale = constants.rounded_values[7],
		
				},
		
				create "TextLabel" {
		
					Size = UDim2.fromScale(1, 1),
					AutomaticSize = Enum.AutomaticSize.XY,
	
					BackgroundTransparency = 1,
		
					Font = scheme:consume().Typography.Secondary.Font,
					Text = props.text,
					TextColor3 = scheme:consume().Color.Text.Primary,
					TextSize = scheme:consume().Typography.Secondary.Size,
					TextWrapped = false,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
		
					ZIndex = 2,
	
					create "UIPadding" {
		
						PaddingLeft = UDim.new(0, 24),
						PaddingRight = UDim.new(0, 24),
						PaddingTop = UDim.new(0, 4),
						PaddingBottom = UDim.new(0, 4),
			
					},
		
				},
		
				shadow {
					elevation = constants.elevation[2],
					layout = {
						Size = spring(function()
							return is_visible() and UDim2.fromScale(1, 1) or UDim2.new(1, -22, 1, -2)
						end, 0.4)
					}
				},
			}

		}

	}
end