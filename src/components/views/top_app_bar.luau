local vide = require(script.Parent.Parent.Parent.Parent.vide)
local constants = require(script.Parent.Parent.Parent.modules.constants)
local scheme = require(script.Parent.Parent.Parent.modules.scheme)
local divider = require(script.Parent.Parent.divider)

local create = vide.create
local read = vide.read

type can<T> = (() -> T) | T
type props = {

	icon: can<string>,
	title: can<string>,
	subtitle: can<string>?,

	zindex: can<number>?,

	[number]: any

}

return function(props)

	return create "Frame" {

		Name = "TopAppBar",

		Size = UDim2.new(1, 0, 0, 50),

		BackgroundTransparency = 1,

		ZIndex = props.zindex,

		divider {
			Position = UDim2.fromScale(0, 1),
			AnchorPoint = Vector2.new(0, 1),

			ZIndex = 2,
		},

		create "ImageLabel" {
			Name = "Content",

			Size = UDim2.fromScale(1, 1),

			BackgroundTransparency = 1,

			Image = constants.top_rounded.id,
			ImageColor3 = scheme:consume().Elevation[4],
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = constants.top_rounded.center,
			SliceScale = constants.rounded_values[8],

			create "Frame" {

				Name = "Left",

				Size = UDim2.fromScale(1, 1),

				BackgroundTransparency = 1,

				create "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
				},

				create "Frame" {
					Name = "Icon",

					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,

					create "UIAspectRatioConstraint" {
						AspectRatio = 1
					},

					create "ImageLabel" {

						Size = UDim2.fromScale(0.4, 0.4),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						
						BackgroundTransparency = 1,
						
						Image = props.icon,
						ImageColor3 = scheme:consume().Color.Text.Primary,
						ScaleType = Enum.ScaleType.Fit,

					}

				},

				create "Frame" {
					Name = "Text",
					
					Size = UDim2.fromScale(0, 1),

					create "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						VerticalAlignment = Enum.VerticalAlignment.Center
					},

					create "TextLabel" {
						Name = "Title",

						Text = props.title,

						Font = scheme:consume().Typography.Header.Font,
						TextColor3 = scheme:consume().Color.Text.Primary,
						TextSize = scheme:consume().Typography.Header.Size,
						TextXAlignment = Enum.TextXAlignment.Left,

						Size = function()
							return UDim2.fromOffset(
								0,
								scheme:consume().Typography.Header.Size
							)
						end,
					},

					create "TextLabel" {
						Name = "Subtitle",

						Size = function()
							return UDim2.fromOffset(0, scheme:consume().Typography.Subheader.Size)
						end,

						BackgroundTransparency = 1,

						Font = scheme:consume().Typography.Subheader.Font,
						Text = props.subtitle,
						TextColor3 = scheme:consume().Color.Text.Primary,
						TextSize = scheme:consume().Typography.Subheader.Size,
						TextXAlignment = Enum.TextXAlignment.Left,

						Visible = function()
							return props.subtitle and read(props.subtitle) ~= ""
						end,

						LayoutOrder = 2,
					}
				}
			},

			create "Frame" {
				Name = "Right",

				Size = UDim2.fromScale(1, 1),

				BackgroundTransparency = 1,

				create "UIPadding" {
					PaddingRight = UDim.new(0, 6),
				},

				create "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				},

				unpack(props)
			}
		}
	}
end