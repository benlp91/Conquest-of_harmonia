

function InitPrinces()

    Game.Prince1 = AddCreatureToLevel(PLAYER_GOOD, "BALDER",  3, 10, 1000, DEFAULT)
    Game.Prince2 = AddCreatureToLevel(PLAYER_GOOD, "FELIX",   4, 10, 1000, DEFAULT)
    Game.Prince3 = AddCreatureToLevel(PLAYER_GOOD, "TRISTAN", 5, 10, 1000, DEFAULT)
    Game.IsFleeing = false
    RegisterThingDamageEvent(function() PrinceTookDamage(1) end, Game.Prince1)
    RegisterThingDamageEvent(function() PrinceTookDamage(2) end, Game.Prince2)
    RegisterThingDamageEvent(function() PrinceTookDamage(3) end, Game.Prince3)

end

function PrinceTookDamage(princeNumber)
    if not IsFleeing then
        if princeNumber == 1 then
            StartFleeSequence(2)
            StartFleeSequence(3)
        elseif princeNumber == 2 then
            StartFleeSequence(1)
            StartFleeSequence(3)
        elseif princeNumber == 3 then
            StartFleeSequence(1)
            StartFleeSequence(2)
        end
        Game.IsFleeing = true
    end
end

function StartFleeSequence(princeNumber)
    if princeNumber == 1 then
        UseSpellOnCreature(Game.Prince1, "SPELL_FEAR", 6)
    elseif princeNumber == 2 then
        UseSpellOnCreature(Game.Prince2, "SPELL_FEAR", 6)
    elseif princeNumber == 3 then
        UseSpellOnCreature(Game.Prince3, "SPELL_FEAR", 6)
    end
end







