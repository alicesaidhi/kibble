local text_button = require(script.Parent.Parent.components.controls.text_button)
local safe_story = require(script.Parent.safe_story)


return function(target)
	return safe_story(text_button, target, {

		text = "meow!"

	})

end