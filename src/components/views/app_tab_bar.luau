local vide = require(script.Parent.Parent.Parent.Parent.vide)

local create = vide.create

return function(props: {[any]: any})

	return create "Frame" {
		BackgroundTransparency = 1,
		
		Size = UDim2.fromScale(1, 1),
		ClipsDescendants = true,

		create "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center
		},

		props

	}


end