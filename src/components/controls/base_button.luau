local vide = require(script.Parent.Parent.Parent.Parent.vide)
local constants = require(script.Parent.Parent.Parent.modules.constants)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)

local create = vide.create
local source = vide.source
local spring = vide.spring
local changed = vide.changed

type can<T> = (() -> T) | T
export type props = {

	size: can<UDim2>?,
	position: can<UDim2>?,
	anchor_point: can<Vector2>?,

	background_color: can<Color3>?,
	background_opacity: can<number>?,
	rounded_value: can<number>?,
	layout_order: can<number>?,
	zindex: can<number>?,

	activated: (() -> ())?,
	down: (() -> ())?,
	up: (() -> ())?,

	[number]: any

}

return function(props: props)

	local gui_state = source(Enum.GuiState.Idle)

	local function layer_opacity()
		return
			if gui_state() == Enum.GuiState.Press then 0.7
			elseif gui_state() == Enum.GuiState.Hover then 0.85
			else 1
	end

	return create "ImageButton" {

		Name = "BaseButton",

		Size = props.size or UDim2.fromOffset(200, 50),
		Position = props.size or UDim2.fromScale(0, 0),
		AnchorPoint = props.anchor_point or Vector2.new(0, 0),

		BackgroundTransparency = 1,
		
		Image = constants.rounded.id,
		ImageColor3 = props.background_color or scheme:consume().Color.Text.Primary,
		ImageTransparency = props.background_opacity or 0.85,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = constants.rounded.center,
		SliceScale = props.rounded_value or constants.rounded_values[8],

		LayoutOrder = props.layout_order,

		ZIndex = props.zindex or 1,
		
		create "ImageLabel" {

			Size = UDim2.fromScale(1, 1),

			BackgroundTransparency = 1,

			Image = constants.rounded.id,
			ImageColor3 = Color3.new(),
			ImageTransparency = spring(layer_opacity, 0.15),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = constants.rounded.center,
			SliceScale = props.rounded_value or constants.rounded_values[8],
			
			ZIndex = 2

		},

		changed("GuiState", gui_state),

		Activated = props.activated,
		MouseButton1Down = props.down,
		MouseButton1Up = props.up,

		unpack(props)

	}

end