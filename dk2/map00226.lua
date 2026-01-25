function OnGameStart()
    SetPatrolPoints()
    MyHeroParties()
    SpawnPatrols()
    RegisterTimerEvent(StartPatrols, 20, true)
end

function SetPatrolPoints()
    Game.bluepatrol = {}
    Game.bluepatrol[1] =  { stl_x = 178, stl_y = 160 }
    Game.bluepatrol[2] =  { stl_x = 178, stl_y = 190 }
    Game.bluepatrol[3] =  { stl_x = 115, stl_y = 190 }
    Game.bluepatrol[4] =  { stl_x = 115, stl_y = 238 }
    Game.bluepatrol[5] =  { stl_x = 115, stl_y = 190 }
    Game.bluepatrol[6] =  { stl_x = 178, stl_y = 190 }

    Game.redpatrol = {}
    Game.redpatrol[1]  =  { stl_x = 178, stl_y = 190 }
    Game.redpatrol[2] =  { stl_x = 178, stl_y = 190 }
    Game.redpatrol[3] =  { stl_x = 178, stl_y = 190 }
end

function SpawnPatrols()
    Game.partyred =     AddPartyToLevel(PLAYER_GOOD             ,"red"                      ,1)                -- walk to 2
    Game.partygreen =   AddPartyToLevel(PLAYER_GOOD             ,"green"                    ,7)                -- walk to 8
    Game.partyyellow =  AddPartyToLevel(PLAYER_GOOD             ,"yellow"                   ,6)                -- walk to 5
    Game.blue1 =    AddCreatureToLevel(PLAYER_GOOD              ,"BARBARIAN"                ,3,8,200)          -- walk to 4
    Game.blue2 =    AddCreatureToLevel(PLAYER_GOOD              ,"BARBARIAN"                ,3,1,200)          -- walk to 4
    Game.blue3 =    AddCreatureToLevel(PLAYER_GOOD              ,"WIZARD"                   ,3,1,200)          -- walk to 4
    Game.blue1NextPos = 2
    Game.blue2NextPos = 3
    Game.redNextPos = 2
end

function StartPatrols()
    Game.blue1NextPos = ActivatePatrol(Game.blue1, Game.bluepatrol, Game.blue1NextPos)
    Game.blue1NextPos = ActivatePatrol(Game.blue2, Game.bluepatrol, Game.blue2NextPos)
    Game.redNextPos = ActivatePatrol(Game.partyred[1], Game.redpatrol, Game.redNextPos)
end

function  ActivatePatrol(PatrolingCreature,Patrol,NextPost)
    local target = Patrol[NextPost]
    if PatrolingCreature.pos.stl_y < target.stl_y+1 and 
       PatrolingCreature.pos.stl_y > target.stl_y-1 and 
       PatrolingCreature.pos.stl_x < target.stl_x+1 and 
       PatrolingCreature.pos.stl_x > target.stl_x-1  
    then
       print(PatrolingCreature.name .. " reached destination " .. NextPost )
       NextPost=NextPost+1  --todo fix that it goes back to 1 and does not crash at 7
    end
    PatrolingCreature:walk_to(target.stl_x,target.stl_y)
    PatrolingCreature.state = "Patrolling"
    PatrolingCreature.gold_held = 666 --this should be removed, it's just to test we are targetting the correct creature (look with query mode)
    PatrolingCreature.continue_state = "GoodWanderToCreatureCombat"
    print(PatrolingCreature.name .. " walks to " .. target.stl_x .."," .. target.stl_y) -- todo remove, log spam
    return NextPost
end

function MyHeroParties()
    CreateParty("red")
    AddToParty("red", "GIANT", 1, 500, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("red", "BARBARIAN", 1, 500, "ATTACK_DUNGEON_HEART", 0)
    AddToParty("red", "BARBARIAN", 1, 250, "ATTACK_DUNGEON_HEART", 0)
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