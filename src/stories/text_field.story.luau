local vide = require(script.Parent.Parent.Parent.vide)
local text_field = require(script.Parent.Parent.components.controls.text_field)
local safe_story = require(script.Parent.safe_story)


return function(target)
	local text = vide.source("")
	
	return safe_story(text_field, target, {
		text = text,
		update_text = text,

		focus_lost = function()
			
		end
	})

end