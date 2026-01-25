


-- patrol contains the party
-- patrol points is a list of locations
-- next_post is index of next patrol point

local function is_close_enough(creature, target)
    return creature.pos.stl_y < target.stl_y+1 and 
           creature.pos.stl_y > target.stl_y-1 and 
           creature.pos.stl_x < target.stl_x+1 and 
           creature.pos.stl_x > target.stl_x-1  
end

local function  UpdatePatrol(patrol)
    if patrol.leader == nil then
        print("Patrol "..patrol.name.." has no leader, skipping update.")
        return
    end
    if patrol.leader.state ~= "MoveToPosition" and patrol.leader.state ~= "GoodDoingNothing" and patrol.leader.state ~= "CreatureDoingNothing" then
        return
    end
    
    local target = patrol.positions[patrol.next_post]
    
    if is_close_enough(patrol.leader, target) then
        patrol.next_post = (patrol.next_post % #patrol.positions) + 1
        target = patrol.positions[patrol.next_post]
    end
    if (patrol.leader.moveto_pos.stl_x ~= target.stl_x or patrol.leader.moveto_pos.stl_y ~= target.stl_y) then
        patrol.leader:walk_to(target.stl_x,target.stl_y)
        patrol.leader.state = "MoveToPosition"
        patrol.leader.continue_state = "GoodDoingNothing"
    end
end

function UpdatePatrols()
    for _, patrol in ipairs(Game.patrols) do
        UpdatePatrol(patrol)
    end
end


local function InitializePatrols()
    RegisterTimerEvent(UpdatePatrols, 20, true)
    Game.patrols = {}
end


function LeaderDeath(eventData,triggerData)
    local patrol = Game.patrols[triggerData.patrol_idx]
    if patrol == nil then
        return
    end

    if patrol.partybackup then
        patrol.leader = patrol.partybackup.party[1]
        local trigger = RegisterCreatureDeathEvent(LeaderDeath, patrol.leader)
        trigger.triggerData.patrol_idx = triggerData.patrol_idx
        print(patrol.name .. " leader has died, new leader assigned.")
        
        -- Update backup to the next party member
        if patrol.leader.party[2] then
            patrol.partybackup = patrol.leader.party[2]
            local trigger2 = RegisterCreatureDeathEvent(BackupDeath, patrol.partybackup)
            trigger2.triggerData.patrol_idx = triggerData.patrol_idx
            print(patrol.name .. " new backup assigned.")
        else
            patrol.partybackup = nil
            print(patrol.name .. " no backup available.")
        end
    else
        print(patrol.name .. " leader has died and no replacement is available. Patrol disbanded.")
        RemoveTrigger(triggerData.trigger)
    end
end

function BackupDeath(eventData,triggerData)
    local patrol = Game.patrols[triggerData.patrol_idx]
    if patrol == nil then
        return
    end

    if triggerData.unit == patrol.leader then
        -- Leader died, ignore backup death
        return
    end
    
    print(patrol.name .. " backup has died.")

    if patrol.leader and patrol.leader.party[2] then
        patrol.partybackup = patrol.leader.party[2]
        print(patrol.name .. " new backup assigned.")
        local trigger2 = RegisterCreatureDeathEvent(BackupDeath, patrol.partybackup)
        trigger2.triggerData.patrol_idx = triggerData.patrol_idx
    else
        print(patrol.name .. " no replacement backup is available.")
        patrol.partybackup = nil
    end

end

---makes a party patrol between given points
---@param leader Creature
---@param patrolPoints table list of {stl_x = integer, stl_y = integer}
---@param next_post? integer if the patrol should start at a different point than 1
---@param patrol_name? string optional name for the patrol
function RegisterPatrol(leader, patrolPoints,next_post,patrol_name)
    if Game.patrols == nil then
        InitializePatrols()
    end

    if next_post == nil then
        next_post = 1
    end

    if patrol_name == nil then
        patrol_name = "Patrol "..tostring(#Game.patrols + 1)
    end

    table.insert(Game.patrols, { leader = leader, positions = patrolPoints, next_post = next_post, name = patrol_name } )

    local trigger = RegisterCreatureDeathEvent(LeaderDeath, leader)
    trigger.triggerData.patrol_idx = #Game.patrols

    if leader.party[2] ~= nil then
        local partybackup = leader.party[2]
        local trigger2 = RegisterCreatureDeathEvent(BackupDeath, partybackup)
        Game.patrols[#Game.patrols].partybackup = partybackup
        trigger2.triggerData.patrol_idx = #Game.patrols
    end
end


-- above is the lib stuff
--------------------------------------------------------
-- below is the map script stuff


function OnGameStart()
    MyHeroParties()
    SpawnPatrols()
end


function SpawnPatrols()

    local bluepatrol = {}
    bluepatrol[1] =  { stl_x = 178, stl_y = 160 }
    bluepatrol[2] =  { stl_x = 178, stl_y = 190 }
    bluepatrol[3] =  { stl_x = 115, stl_y = 190 }
    bluepatrol[4] =  { stl_x = 115, stl_y = 238 }
    bluepatrol[5] =  { stl_x = 115, stl_y = 190 }
    bluepatrol[6] =  { stl_x = 178, stl_y = 190 }

    local redpatrol = {}
    redpatrol[1]  =  { stl_x = 116, stl_y =  95 }
    redpatrol[2]  =  { stl_x = 180, stl_y = 153 }

    local partyred    =  AddPartyToLevel(PLAYER_GOOD             ,"red"                      ,1)                -- walk to 2
    local partygreen  =  AddPartyToLevel(PLAYER_GOOD             ,"green"                    ,7)                -- walk to 8
    local partyyellow =  AddPartyToLevel(PLAYER_GOOD             ,"yellow"                   ,6)                -- walk to 5
    local blue1 =    AddCreatureToLevel(PLAYER_GOOD              ,"BARBARIAN"                ,3,3,200)          -- walk to 4
    local blue2 =    AddCreatureToLevel(PLAYER_GOOD              ,"BARBARIAN"                ,3,2,200)          -- walk to 4
    local blue3 =    AddCreatureToLevel(PLAYER_GOOD              ,"WIZARD"                   ,3,1,200)          -- walk to 4

    RegisterPatrol(partyred[1], redpatrol, 1, "Red Patrol")
    RegisterPatrol(blue1, bluepatrol, 1, "Blue Patrol 1")
    RegisterPatrol(blue2, bluepatrol, 2, "Blue Patrol 2")
    RegisterPatrol(blue3, bluepatrol, 4, "Blue Patrol 3")

end
function MyHeroParties()
    CreateParty("red")
    AddToParty("red", "GIANT", 4, 500, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("red", "BARBARIAN", 3, 500, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("red", "MONK", 2, 250, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("red", "WIZARD", 1, 250, "ATTACK_DUNGEON_HEART", 0)

    CreateParty("green")
    AddToParty("green", "THIEF", 1, 500, "ATTACK_DUNGEON_HEART", 0)    
    AddToParty("green", "THIEF", 1, 500, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("green", "BARBARIAN", 1, 500, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("green", "BARBARIAN", 1, 250, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("green", "WIZARD", 1, 250, "ATTACK_DUNGEON_HEART", 0)

    CreateParty("yellow")
    AddToParty("yellow", "THIEF", 1, 500, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("yellow", "BARBARIAN", 1, 500, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("yellow", "BARBARIAN", 1, 250, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("yellow", "WIZARD", 1, 250, "ATTACK_DUNGEON_HEART", 0)
end
