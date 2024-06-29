local vide = require(script.Parent.Parent.Parent.vide)
local checkbox = require(script.Parent.Parent.components.controls.toggle)
local safe_story = require(script.Parent.safe_story)


return function(target)
	local checked = vide.source(false)

	return safe_story(checkbox, target, {
		toggled = checked,
		update_toggled = checked
	})

end