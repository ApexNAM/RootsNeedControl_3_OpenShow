local function sqrts(x)
    return x * x 
end

function Distance(target, current_object)
    return math.sqrt(sqrts(target.x - current_object.x) + sqrts(target.y - current_object.y))
end

function DistanceX(target, current_object)
    return math.sqrt(sqrts(target.x - current_object.x))
end

function DistanceY(target, current_object)
    return math.sqrt(sqrts(target.y - current_object.y))
end

function Distance_Value(t1, t2)
    return math.sqrt(sqrts(t1 - t2))
end

function Lerp(target, positon, percent)
    return (1 - percent) * target + percent * positon
end