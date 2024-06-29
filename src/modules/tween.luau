local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local vide = require(script.Parent.Parent.Parent.vide)

local cleanup = vide.cleanup
local effect = vide.effect
local source = vide.source

local updating_tweens = {}
local clock = 0

local function tween<T>(goal: () -> T, tween_info: TweenInfo): () -> T

	local output = source(goal())

	local tween = {
		start = goal(),
		goal = goal(),
		started_at = os.clock(),
		output = output,
		tween_info = tween_info,
	}

	effect(function()
		local new_goal = goal()

		if new_goal == tween.goal then return end
		
		tween.start = output()
		tween.goal = goal()
		tween.started_at = clock

		updating_tweens[tween] = true
	end)

	cleanup(function()
		updating_tweens[tween] = nil
	end)

	return output

end

local function lerp<T>(a: T, b: T, t: number)

	assert(typeof(a) == typeof(b), `start and goal are not the same type. ({typeof(a)}, {typeof(b)})`)

	if typeof(a) == "number" then
		return a + (b - a) * t
	elseif typeof(a) == "boolean" then
		local a_ = if a == true then 1 else 0
		local b_ = if b == true then 1 else 0
		local v: number = lerp(a_, b_, t)
		
		return if v < 0.5 then false else true
	elseif typeof(a) == "CFrame" then
		return a:Lerp(b, t)
	elseif typeof(a) == "Rect" and typeof(b) == "Rect" then
		return Rect.new(
			lerp(a.Min.X, b.Min.X, t),
			lerp(a.Min.Y, b.Min.Y, t),
			lerp(a.Max.X, b.Max.X, t),
			lerp(a.Max.Y, b.Max.Y, t)
		)
	elseif typeof(a) == "Color3" then
		return a:Lerp(b, t)
	elseif typeof(a) == "UDim" and typeof(b) == "UDim" then
		return UDim.new(lerp(a.Scale, b.Scale, t), lerp(a.Offset, b.Offset, t))
	elseif typeof(a) == "UDim2" then
		return a:Lerp(b, t)
	elseif typeof(a) == "Vector2" then
		return a + (b - a) * t
	elseif typeof(a) == "Vector2int16" then
		return a + (b - a) * t
	elseif typeof(a) == "Vector3" then
		return a + (b - a) * t
	elseif typeof(a) == "Vector3int16" then
		return a + (b - a) * t
	end

	error(`cannot tween {typeof(a)}`)

end

local function get_alpha(starts_at: number, tween_info: TweenInfo)

	local offset = clock - starts_at
	if offset < 0 then return 0 end
	
	local duration = tween_info.DelayTime + tween_info.Time * (tween_info.Reverses and 2 or 1)
	local repeat_count = offset // duration

	if repeat_count > tween_info.RepeatCount then
		return if tween_info.Reverses then 0 else 1
	end

	local local_offset = offset - duration * repeat_count - tween_info.DelayTime

	if local_offset < 0 then
		return 0
	elseif local_offset < tween_info.Time then
		return TweenService:GetValue(
			local_offset / tween_info.Time,
			tween_info.EasingStyle,
			tween_info.EasingDirection
		)
	else
		return 1 - TweenService:GetValue(
			(local_offset - tween_info.Time) / tween_info.Time,
			tween_info.EasingStyle,
			tween_info.EasingDirection
		)
	end

end

local function update_tweens(dt: number)

	debug.profilebegin("update tween")
	clock += dt

	for tween in updating_tweens do
		local alpha = get_alpha(tween.started_at, tween.tween_info)

		tween.output(lerp(tween.start, tween.goal, alpha))
		
		if alpha == 1 then
			updating_tweens[tween] = nil
		end	
	end
	debug.profileend()

end

RunService.RenderStepped:Connect(update_tweens)

return tween