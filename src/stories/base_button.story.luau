local base_button = require(script.Parent.Parent.components.controls.base_button)
local safe_story = require(script.Parent.safe_story)


return function(target)
	return safe_story(base_button, target, {})

end