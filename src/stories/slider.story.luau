local vide = require(script.Parent.Parent.Parent.vide)
local slider = require(script.Parent.Parent.components.controls.slider)
local window = require(script.Parent.Parent.components.views.window)
local scheme = require(script.Parent.Parent.modules.scheme)
local safe_story = require(script.Parent.safe_story)

return function(target)

	return safe_story(function()
		
		local value = vide.source(0)

		return window {

			slider {

				value = value,
				update_value = value,
				max = 10,
	
				position = UDim2.fromScale(0.5, 0.5),
				gradient_color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, scheme:consume().Accent),
					ColorSequenceKeypoint.new(0.499, scheme:consume().Accent),
					ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
					ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
				})
	
			},
		}

	end, target)

end