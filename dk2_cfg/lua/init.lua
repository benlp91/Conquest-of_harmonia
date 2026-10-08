require "hatchery"
require "patrols"
require "helper"
require "casino"

function OnCampaignGameStart()
    CasinoInit()                                                -- casino code 
    RegisterTimerEvent(CheckForStunDeaths, 1, true)             -- Repeat each frame
    Game.CoopRange = 2                                          -- Coop range in subtiles
    RegisterSlabKindChangeEvent(LavaBecomesBridge, "LAVA", "BRIDGE_FRAME")
end

-- Function that kills all creatures that are close to waking up from stun
function CheckForStunDeaths()
    for _, creature in ipairs(GetThingsOfClass("Creature")) do  -- Get all creatures
        if creature.conscious_back_turns == 1 then              -- If one will wake up next turn
            creature:kill()                                     -- Kill it
        end
    end
end

function LavaBecomesBridge(eventData)

    local rotTimer = RegisterTimerEvent(BridgeRot, 300, false)
    rotTimer.triggerData.Slab = eventData.Slab

    local burnTimer = RegisterTimerEvent(BridgeBurn, 500, false)
    burnTimer.triggerData.Slab = eventData.Slab

end

function BridgeRot(eventData, triggerData)

    local slab = triggerData.Slab
    ChangeSlabType(slab.slb_x, slab.slb_y, "BRIDGE_FRAME_BURNED")
    PlayMessage(PLAYER0, "SOUND", 78)
    CreateEffectAtPos("EFFECT_BRIDGEBURN", slab.slb_x* 3 + 1, slab.slb_y* 3 + 1, 1)
    CreateEffectAtPos("EFFECT_SPANGLE_RED", slab.slb_x* 3 + 1, slab.slb_y* 3 + 1, 1)
end

function BridgeBurn(eventData, triggerData)

    local slab = triggerData.Slab
    ChangeSlabType(slab.slb_x, slab.slb_y, "LAVA")
    CreateEffectAtPos("EFFECT_BRIDGEBURN", slab.slb_x* 3 + 1, slab.slb_y* 3 + 1, 1)
    CreateEffectAtPos("EFFECT_SPANGLE_RED", slab.slb_x* 3 + 1, slab.slb_y* 3 + 1, 1)
end