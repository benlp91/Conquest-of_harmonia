function CoupChanger(coop)
    if CheckForRemoval(coop) then
        coop:delete() 
        return
    end
    RandomizeRotation(coop)
end

function CheckForEggs(coop)

    if CheckForRemoval(coop) then
        coop:delete()
        return
    end

    CheckForEggsOnSlab(coop, coop.pos.slb_x, coop.pos.slb_y)
end

function CheckForEggsOnSlab(coop, coopX, coopY)
    local eggsInRange = GetObjectsOnSlab(coopX, coopY)
    for _, object in ipairs(eggsInRange) do
        if object.model == "CHICKEN_GRW" then
            object.sprite_size = 0
            object.pos = coop.pos
        elseif object.model == "CHICKEN_STB" or
               object.model == "CHICKEN_WOB" or
               object.model == "CHICKEN_CRK" then
            object.sprite_size = 0
        end
    end
end

function CheckForRemoval(coop)

    local x = coop.pos.slb_x
    local y = coop.pos.slb_y

    local isInvalid = (x + y) % 2 == 0  -- Checkerboard pattern

    return isInvalid
end


function RandomizeRotation(coop)

    if coop.creation_turn == PLAYER0.GAME_TURN - 1 then

        -- trying to move it one subtile
        coop.pos = {val_x = coop.pos.val_x + (256 * math.random(-0.5, 0.5)), val_y = coop.pos.val_y + (256 * math.random(-0.5, 0.5)), val_z = coop.pos.val_z}
        
        -- Zufällige Rotation
        coop.orientation = math.random(0, 7) * 256

    end
end