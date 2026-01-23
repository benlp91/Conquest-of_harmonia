function OnCampaignGameStart()
    RegisterTimerEvent(CheckForStunDeaths, 1, true)             -- Repeat each frame
    Game.AllEggs = {}
end

-- Function that kills all creatures that are close to waking up from stun
function CheckForStunDeaths()
    for _, creature in ipairs(GetThingsOfClass("Creature")) do  -- Get all creatures
        if creature.conscious_back_turns == 1 then              -- If one will wake up next turn
            creature:kill()                                     -- Kill it
        end
    end
end

-- function to hide the health flower of horny when he collects the gem
function HideHornyFlower()
    local creatures = GetCreatures()

    for _, creature in ipairs(creatures) do

        if creature.model == "EVILLORD" then
            creature.force_health_flower_hidden = true
        end

    end
end
