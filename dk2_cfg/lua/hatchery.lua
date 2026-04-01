function CheckForEggs(coop)
    if CheckForRemoval(coop) then
        coop:delete() 
        return
    end

    RandomizeRotation(coop)

    local coopPos = coop.pos
    for _, object in ipairs(GetThingsOfClass("Object")) do
        local model = object.model
        if model == "CHICKEN_GRW" or
        model == "CHICKEN_STB" or
        model == "CHICKEN_WOB" or
        model == "CHICKEN_CRK" then
            if object.pos.stl_x >= coopPos.stl_x - Game.CoopRange and
            object.pos.stl_x <= coopPos.stl_x + Game.CoopRange and
            object.pos.stl_y >= coopPos.stl_y - Game.CoopRange and
            object.pos.stl_y <= coopPos.stl_y + Game.CoopRange then
                object.sprite_size = 0
                object.pos = coopPos
            end
        end
    end
end


function CheckForRemoval(coop)
    local x = coop.pos.slb_x
    local y = coop.pos.slb_y

    --local isInvalid = ((x * y) + x) % 2 == 0
    local isInvalid = not (((x * y) + x) % 3 == 1)
    return isInvalid
end


function RandomizeRotation(coop) -- functions name and which object to modify 
    if coop.creation_turn == PLAYER0.GAME_TURN then
        coop.orientation = math.random(0, 3) * 512 -- Only 0, 512, 1024 and 1536 are possible (so only direct North, East, South or West)
    end 
end