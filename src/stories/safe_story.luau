--[[

Creates a safe story that will make sure that vide properly cleans up.

]]

local vide = require(script.Parent.Parent.Parent.vide)

return function<T, U...>(callback: (U...) -> T, target: Instance, ...: U...)

	local t: {any} = {...}

	return vide.mount(function()

		local function error_handler(err)
			return debug.traceback(err, 2)
		end

		local ok, result = xpcall(callback, error_handler, unpack(t))

		if not ok then
			warn(result)
			return nil
		else
			return result
		end

	end, target)

end
