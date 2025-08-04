-- ********************************************
--
--           Lua Basics and Triggers
--           by Trotim Apr 2025
--
-- ********************************************
-- Fully commented simple example map using only Lua instead of old DK level script.


-- OnGameStart() is a built-in function.
-- It happens when the level has finished loading and the map is about to start.


function SpawnHorny()
    Game.Horny = AddCreatureToLevel(PLAYER0, "BUG",2,1,0)
    Game.HornyZoomStartTurn = PLAYER0.GAME_TURN
    RegisterTimerEvent(Zoom,1,true)
end


function Zoom(eventData,triggerData)
    ZoomToLocation(PLAYER0,Game.Horny.pos)
    if Game.HornyZoomStartTurn + 500 < PLAYER0.GAME_TURN then
        triggerData.destroyAfterUse = true
    end
end
