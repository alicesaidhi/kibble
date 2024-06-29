local base_button = require(script.Parent.Parent.components.controls.base_button)
local tooltip = require(script.Parent.Parent.components.views.tooltip)
local safe_story = require(script.Parent.safe_story)

return function(target)
	return safe_story(function()
		
		return base_button {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			
			tooltip {text = "hellooo~!"}
		}
		
	end, target)

end