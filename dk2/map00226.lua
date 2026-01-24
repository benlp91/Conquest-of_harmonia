function OnGameStart()
    RegisterTimerEvent(MoveBlue, 20, true)
    SetPatrolPoints()
    MyHeroParties()
    SpawnPatrols()
end

function SpawnPatrols()
    Game.partyred =     AddPartyToLevel(PLAYER_GOOD             ,"red"                      ,1)                -- walk to 2
    Game.partygreen =   AddPartyToLevel(PLAYER_GOOD             ,"green"                    ,7)                -- walk to 8
    Game.partyyellow =  AddPartyToLevel(PLAYER_GOOD             ,"yellow"                   ,6)                -- walk to 5
    Game.blue1 =    AddCreatureToLevel(PLAYER_GOOD              ,"BARBARIAN"                ,3,1,200)          -- walk to 4
    Game.blue2 =    AddCreatureToLevel(PLAYER_GOOD              ,"BARBARIAN"                ,3,1,200)          -- walk to 4
    Game.blue3 =    AddCreatureToLevel(PLAYER_GOOD              ,"WIZARD"                   ,3,1,200)          -- walk to 4
    Game.blue1NextPos = 2
    Game.redNextPos = 2



end


function  MoveBlue()

    if Game.blue1NextPos== 1 and Game.blue1.pos.stl_y<161 then
            Game.blue1NextPos=2
    elseif Game.blue1NextPos== 2 and Game.blue1.pos.stl_y>189 then
        Game.blue1NextPos=3 
    elseif Game.blue1NextPos== 3 and Game.blue1.pos.stl_x<116 then
            Game.blue1NextPos=4
    elseif Game.blue1NextPos== 4 and Game.blue1.pos.stl_y>237 then
            Game.blue1NextPos=5
    elseif Game.blue1NextPos== 5 and Game.blue1.pos.stl_y<191 then
            Game.blue1NextPos=6
    elseif Game.blue1NextPos== 6 and Game.blue1.pos.stl_x>177 then
            Game.blue1NextPos=1
    end

    Game.blue1:walk_to(Game.bluepos[Game.blue1NextPos].x,Game.bluepos[Game.blue1NextPos].y)
end

function  SetPatrolPoints()
    Game.bluepos={}
    Game.bluepos[1]={x=178, y=160}
    Game.bluepos[2]={x=178, y=190}
    Game.bluepos[3]={x=115, y=190}
    Game.bluepos[4]={x=115, y=238}
    Game.bluepos[5]={x=115, y=190}
    Game.bluepos[6]={x=178, y=190}

    Game.redpos={}
    Game.redpos[1]={x=178, y=190}










    
end

function MoveRed()
        if Game.redNextPos== 1 and Game.partyred[1].pos.stl_y<161 then
            Game.redNextPos=2
    elseif Game.redNextPos== 2 and Game.partyred[1].pos.stl_y>189 then
        Game.redNextPos=3 
    elseif Game.redNextPos== 3 and Game.partyred[1].pos.stl_x<116 then
            Game.redNextPos=4
    elseif Game.redNextPos== 4 and Game.partyred[1].pos.stl_y>237 then
            Game.redNextPos=5
    elseif Game.redNextPos== 5 and Game.partyred[1].pos.stl_y<191 then
            Game.redNextPos=6
    elseif Game.redNextPos== 6 and Game.partyred[1].pos.stl_x>177 then
            Game.redNextPos=1
    end

    Game.partyred[1]:walk_to(Game.bluepos[Game.blue1NextPos].x,Game.bluepos[Game.blue1NextPos].y)
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