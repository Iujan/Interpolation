local Interpolation = {}

local function lerp(a, b, t)
    return a + (b - a) * t
end

function Interpolation.Vector2(start, target, t, style, direction)
    local x = Interpolation[style](start.x, target.x, t, direction)
    local y = Interpolation[style](start.y, target.y, t, direction)
    return Vector2.new(x, y)
end

function Interpolation.Number(start, target, t, style, direction)
    return Interpolation[style](start, target, t, direction)
end

function Interpolation.Color3(start, target, t, style, direction)
    local r = Interpolation[style](start.r, target.r, t, direction)
    local g = Interpolation[style](start.g, target.g, t, direction)
    local b = Interpolation[style](start.b, target.b, t, direction)
    return Color3.new(r, g, b)
end

Interpolation.Quad = function(a, b, t, direction)
    t = (direction == "inout") and t * 2 or t
    if t < 1 then
        return lerp(a, b, t * t)
    else
        return lerp(b, a, (t - 1) * (2 - t) + 1)
    end
end

Interpolation.Quart = function(a, b, t, direction)
    t = (direction == "inout") and t * 2 or t
    if t < 1 then
        return lerp(a, b, t * t * t * t)
    else
        t = t - 2
        return lerp(b, a, -(t * t * t * t - 2))
    end
end

return Interpolation
