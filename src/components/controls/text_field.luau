local TextService = game:GetService("TextService")

local vide = require(script.Parent.Parent.Parent.Parent.vide)
local constants = require(script.Parent.Parent.Parent.modules.constants)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local tween = require(script.Parent.Parent.Parent.modules.tween)

local create = vide.create
local source = vide.source
local read = vide.read
local spring = vide.spring
local changed = vide.changed

type can<T> = (() -> T) | T
type props = {

	position: can<UDim2>?,
	size: can<UDim2>?,

	text: () -> string,
	update_text: (new: string) -> (),
	focus_lost: (new: string, enter: boolean) -> (),

	foreground_color: can<Color3>?,
	placeholder_text: can<string>?,
	layout_order: can<number>?,
	zindex: can<number>?,

}

return function(props: props)

	local focused = source(false)
	local gui_state = source(Enum.GuiState.Idle)
	local canvas_position = source(Vector2.zero)

	local function padding()
		if focused() then
			return UDim.new(0, 2)
		else
			return UDim.new(0, 1)
		end
	end

	return create "ImageButton" {

		Size = props.size or UDim2.fromOffset(200, 42),
		Position = props.position or UDim2.fromScale(0, 0),
		LayoutOrder = props.layout_order or 1,
		ZIndex = props.zindex or 1,

		BackgroundTransparency = 1,

		Image = constants.rounded.id,
		ImageColor3 = spring(function()
			if focused() then
				return read(props.foreground_color) or scheme:consume().Accent
			elseif gui_state() == Enum.GuiState.Hover then
				return scheme:consume().Color.Text.Secondary
            else
                return scheme:consume().Color.Text.Tertiary
            end
		end, 0.2),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = constants.rounded.center,
		SliceScale = constants.rounded_values[8],

		create "UIPadding" {
			PaddingTop = padding,
			PaddingBottom = padding,
			PaddingLeft = padding,
			PaddingRight = padding
		},

		create "ImageLabel" {

			Size = UDim2.new(1, 0, 1, 0),
			ClipsDescendants = true,

			BackgroundTransparency = 1,

			Image = constants.rounded.id,
			ImageColor3 = scheme:consume().Elevation[2],
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = constants.rounded.center,
			SliceScale = function()
				if focused() then
					return constants.rounded_values[6]
				else
					return constants.rounded_values[7]
				end
			end,

			create "ScrollingFrame" {

				Position = function()
					return UDim2.fromOffset(scheme:consume().Typography.Body.Size, 0)
				end,
				Size = function()
					return UDim2.new(1, -scheme:consume().Typography.Body.Size * 2, 1, 0)
				end,

				CanvasPosition = tween(function()
					return canvas_position()
				end, TweenInfo.new(0.1, Enum.EasingStyle.Quint)),
				CanvasSize = spring(
					function()
						local size = TextService:GetTextSize(
							props.text(),
							scheme:consume().Typography.Body.Size,
							scheme:consume().Typography.Body.Font,
							Vector2.new(math.huge, math.huge)
						)

						return UDim2.fromOffset(size.X, size.Y)
					end,
					0.1
				),

				BackgroundTransparency = 1,
				ScrollBarThickness = 0,
				ScrollingDirection = Enum.ScrollingDirection.X,
				ClipsDescendants = false,

				create "TextBox" {

					Size = UDim2.new(1, 0, 1, 0),
				
					Font = scheme:consume().Typography.Body.Font,
					PlaceholderText = props.placeholder_text or "Click to type",
					Text = props.text or "",
					TextColor3 = scheme:consume().Color.Text.Primary,
					TextSize = scheme:consume().Typography.Body.Size,
					TextXAlignment = Enum.TextXAlignment.Left,
					PlaceholderColor3 = scheme:consume().Color.Text.Tertiary,
				
					BackgroundTransparency = 1,
				
					changed("Text", props.text),
					changed("CursorPosition", function(cursor)
						canvas_position(
							TextService:GetTextSize(
								string.sub(props.text(), 1, cursor),
								scheme:consume().Typography.Body.Size,
								scheme:consume().Typography.Body.Font,
								Vector2.new(math.huge, math.huge)
							)
						)
					end),
	
					Focused = function()
						focused(true)
					end,
	
					FocusLost = function(enter)
						focused(false)
						props.focus_lost(props.text(), enter)
					end,
				
				}

			}

		}

	}

end

