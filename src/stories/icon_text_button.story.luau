local icon_button = require(script.Parent.Parent.components.controls.icon_text_button)
local icons = require(script.Parent.Parent.modules.icons)
local safe_story = require(script.Parent.safe_story)


return function(target)
	return safe_story(icon_button, target, {
		icon = icons["info"],
		text = "hello!"
	})

end