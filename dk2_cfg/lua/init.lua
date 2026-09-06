require "hatchery"
require "patrols"
require "helper"
require "casino"

function OnCampaignGameStart()
    CasinoInit()                                                -- casino code 
    RegisterTimerEvent(CheckForStunDeaths, 1, true)             -- Repeat each frame
    Game.CoopRange = 2                                          -- Coop range in subtiles
end

-- Function that kills all creatures that are close to waking up from stun
function CheckForStunDeaths()
    for _, creature in ipairs(GetThingsOfClass("Creature")) do  -- Get all creatures
        if creature.conscious_back_turns == 1 then              -- If one will wake up next turn
            creature:kill()                                     -- Kill it
        end
    end
end
