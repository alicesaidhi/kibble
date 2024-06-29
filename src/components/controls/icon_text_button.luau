local vide = require(script.Parent.Parent.Parent.Parent.vide)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local base_button = require(script.Parent.base_button)

local create = vide.create
local read = vide.read

type can<T> = (() -> T) | T
export type props = {

	icon: can<string>,
	text: can<string>,
	icon_size: can<UDim2>?,
	foreground_color: can<Color3>?,
	icon_layout_order: can<number>?,
	zindex: can<number>?,

	activated: (() -> ())?,

	layout: base_button.props?

}

return function(props: props)

	local layout = props.layout or {}

	layout.activated = props.activated

	table.insert(layout, {

		create "Frame" {
			Size = UDim2.fromScale(1, 1),
			
			BackgroundTransparency = 1,

			create "UIListLayout" {

				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center

			},

			create "ImageLabel" {
				
				Size = UDim2.fromScale(0.45, 0.45),

				BackgroundTransparency = 1,

				Image = props.icon,
				ImageColor3 = props.foreground_color or scheme:consume().Color.Text.Primary,
				LayoutOrder = props.icon_layout_order,

				create "UIAspectRatioConstraint" {
					AspectRatio = 1
				}

			},

			create "TextLabel" {

				AutomaticSize = Enum.AutomaticSize.XY,
				LayoutOrder = 1,

				BackgroundTransparency = 1,

				Font = scheme:consume().Typography.Button.Font,
				Text = props.text,
				TextColor3 = props.foreground_color or scheme:consume().Color.Text.Primary,
				TextSize = scheme:consume().Typography.Button.Size,

				Visible = function()
					return read(props.text) ~= nil and read(props.text) ~= ""
				end

			}

		}


	})

	return base_button(layout)

end