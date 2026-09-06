-- ********************************************
--
--        Casino test map
--
-- ********************************************

-- Must stay at the top level. The engine runs this script in main_game.c:179 and
-- parses the map-local cfgs right after, so casino.lua's crstate functions have
-- to be globals by then. A require inside OnGameStart would run far too late and
-- the crstates.cfg entries would quietly resolve to "none".
require("casino")


--will get called when the game starts
function OnGameStart()
	Setup()
	SetupTriggers()
end

--here we setup things
function Setup()
	-- casino.lua deliberately defines no OnGameStart: the engine looks that global
	-- up by name, so only one definition can exist per level and it belongs here.
	CasinoInit()
end

--here we setup the triggers, these can be found in fxdata/lua/triggers/Events.lua
function SetupTriggers()

end
