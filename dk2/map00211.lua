-- ********************************************
--
--           Conquest of Harmonia: Rout
--           Map 226 (Also partly done in DKscript, see map00226.txt)
--           Script and Design by Mc. Biggus Dickus 
--
-- ********************************************
function OnGameStart()
    MyHeroParties()
    SpawnGuards()
end

-- Define the hero parties that can be spawned
function MyHeroParties()


-- Parties that will defend rooms

    CreateParty("DEFEND")
        AddToParty("DEFEND", "DWARFA"   , 1, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND", "DWARFA"   , 1, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND", "DWARFA"   , 2, 250, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND", "DWARFA"   , 2, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND", "DWARFA"   , 3, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND", "DWARFA"   , 3, 250, "DEFEND_ROOMS", 0)

    CreateParty("DEFEND2")
        AddToParty("DEFEND2", "DWARFA"   , 1, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND2", "DWARFA"   , 1, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND2", "DWARFA"   , 2, 250, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND2", "DWARFA"   , 2, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND2", "DWARFA"   , 3, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND2", "DWARFA"   , 3, 250, "DEFEND_ROOMS", 0)

    CreateParty("DEFEND3")
        AddToParty("DEFEND3", "BARBARIAN", 3, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND3", "BARBARIAN", 3, 250, "DEFEND_ROOMS", 0)

    CreateParty("DEFEND4")
        AddToParty("DEFEND4", "DWARFA"  , 5, 250, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND4", "DWARFA"  , 4, 500, "DEFEND_ROOMS", 0)
end

-- Spawn some hero parties at the start of the map that will defend rooms near their starting locations
function SpawnGuards()
    AddPartyToLevel(PLAYER_GOOD    ,"DEFEND"            , 8)
    AddPartyToLevel(PLAYER_GOOD    ,"DEFEND2"           , 9)
    AddPartyToLevel(PLAYER_GOOD    ,"DEFEND3"           , 3)
    AddPartyToLevel(PLAYER_GOOD    ,"DEFEND4"           , 4)
end