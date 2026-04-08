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
        AddToParty("DEFEND3", "BARBARIAN", 3, 500, "DEFEND_ROOMS", 0)
        AddToParty("DEFEND3", "BARBARIAN", 3, 250, "DEFEND_ROOMS", 0)       

end

-- Spawn some hero parties at the start of the map that will defend rooms near their starting locations
function SpawnGuards()
    AddPartyToLevel(PLAYER_GOOD    ,"DEFEND"            , 9)
    AddPartyToLevel(PLAYER_GOOD    ,"DEFEND2"           , 11)   
    AddPartyToLevel(PLAYER_GOOD    ,"DEFEND3"           , 10)
end









-- Function to define routes, spawn patrolling heroes and initialize their patrolling
function SpawnPatrols()

    -- Define routes to be patrolled

    local FirstRoom = {}
        FirstRoom[1]  =  { stl_x = 106, stl_y = 121 }


    local Middlecircler = {}
        Middlecircler[1]  =      { stl_x = 100, stl_y = 91 }
        Middlecircler[2]  =      { stl_x = 112, stl_y = 91 }
        Middlecircler[3]  =      { stl_x = 112, stl_y = 109 }
        Middlecircler[4]  =      { stl_x = 100, stl_y = 109 }




    -- Patrolling parties and individual heroes added to level.

    local PatrolFirst  =    AddCreatureToLevel(PLAYER_GOOD    ,"DWARFA"             , 12, 1, 200)
    local PatrolFirst2 =    AddCreatureToLevel(PLAYER_GOOD    ,"DWARFA"             , 12, 1, 200)
    local PatrolFirst3 =    AddCreatureToLevel(PLAYER_GOOD    ,"DWARFA"             , 12, 2, 200)
    local PatrolFirst4 =    AddCreatureToLevel(PLAYER_GOOD    ,"DWARFA"             , 12, 2, 200)
    local PatrolFirst5 =    AddCreatureToLevel(PLAYER_GOOD    ,"DWARFA"             , 12, 3, 200)
    local PatrolFirst6 =    AddCreatureToLevel(PLAYER_GOOD    ,"DWARFA"             , 12, 3, 200)

    local PatrolMiddle  =    AddCreatureToLevel(PLAYER_GOOD    ,"BARBARIAN"             , 13, 1, 200)
    local PatrolMiddle2 =    AddCreatureToLevel(PLAYER_GOOD    ,"BARBARIAN"             , 13, 1, 200)
    local PatrolMiddle3 =    AddCreatureToLevel(PLAYER_GOOD    ,"BARBARIAN"             , 13, 2, 200)
    local PatrolMiddle4 =    AddCreatureToLevel(PLAYER_GOOD    ,"BARBARIAN"             , 13, 2, 200)



    -- local PatrolPartyRed    =  AddPartyToLevel(PLAYER_GOOD       ,"RED"                , 9)




    -- Calling Library function to activate patrols

    -- RegisterPatrol(PatrolPartyRed[1]    , FirstRoom   , 1, "Red Patrol")

    RegisterPatrol(PatrolFirst    , FirstRoom     , 1, "Middle Patrol")
    RegisterPatrol(PatrolFirst2   , FirstRoom     , 1, "Middle Patrol")
    RegisterPatrol(PatrolFirst3   , FirstRoom     , 1, "Middle Patrol")
    RegisterPatrol(PatrolFirst4   , FirstRoom     , 1, "Middle Patrol")
    RegisterPatrol(PatrolFirst5   , FirstRoom     , 1, "Middle Patrol")
    RegisterPatrol(PatrolFirst6   , FirstRoom     , 1, "Middle Patrol")

    RegisterPatrol(PatrolMiddle    , Middlecircler     , 1, "Middle Patrol")
    RegisterPatrol(PatrolMiddle2   , Middlecircler     , 1, "Middle Patrol")
    RegisterPatrol(PatrolMiddle3   , Middlecircler     , 1, "Middle Patrol")
    RegisterPatrol(PatrolMiddle4   , Middlecircler     , 1, "Middle Patrol")


end