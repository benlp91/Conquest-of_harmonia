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
    Game.blue3NextPos = 4
    Game.redNextPos = 2
end

function StartPatrols()
    Game.blue1NextPos = ActivatePatrol(Game.blue1, Game.bluepatrol, Game.blue1NextPos)
    Game.blue2NextPos = ActivatePatrol(Game.blue2, Game.bluepatrol, Game.blue2NextPos)
    Game.blue3NextPos = ActivatePatrol(Game.blue3, Game.bluepatrol, Game.blue3NextPos)
    Game.redNextPos = ActivatePatrol(Game.partyred[1], Game.redpatrol, Game.redNextPos)
end

function  ActivatePatrol(PatrolingCreature,Patrol,NextPost)
    local target = Patrol[NextPost]
    if PatrolingCreature.pos.stl_y < target.stl_y+1 and 
       PatrolingCreature.pos.stl_y > target.stl_y-1 and 
       PatrolingCreature.pos.stl_x < target.stl_x+1 and 
       PatrolingCreature.pos.stl_x > target.stl_x-1  
    then
        NextPost = NextPost + 1
        if NextPost > #Patrol then
            NextPost = 1
        end
    end
    PatrolingCreature:walk_to(target.stl_x,target.stl_y)
    PatrolingCreature.state = "GoodWanderToCreatureCombat"
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