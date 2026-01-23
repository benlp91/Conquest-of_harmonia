function CheckForEggs(coop)
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