local context = require(script.Parent.context)
local store = require(script.Parent.store)
local tween = require(script.Parent.tween)
local Dark = require(script.schemes.Dark)

--todo: figure out a cleaner way to handle this
local scheme_cascade = context(store.new_deep(
    Dark,
    function(state)

        return {
            
        }

    end
))

function scheme_cascade:tween<T>(callback: () -> T): () -> T
    return tween(callback, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut))
end

return scheme_cascade :: typeof(scheme_cascade) & {tween: <T>(callback: () -> T) -> () -> T}