local base_button = require(script.Parent.Parent.components.controls.base_button)
local text_button = require(script.Parent.Parent.components.controls.text_button)
local tooltip = require(script.Parent.Parent.components.views.tooltip)
local safe_story = require(script.Parent.safe_story)

return function(target)
	return safe_story(function()
		
		return text_button {
			layout = {
				position = UDim2.fromScale(0.5, 0.5),
				anchor_point = Vector2.new(0.5, 0.5),
			
				tooltip {text = "dont press it!!! it will definitely blow up the world!"}
			},

			text = "button does not blow up the world",
		}
		
	end, target)

end