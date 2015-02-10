--  Main gameplay functions.

--  Load item functions
dofile("script/gamefunctions/itemfunctions.lua")

--  Load room functions
dofile("script/gamefunctions/roomfunctions.lua")

--  Load the help screen
dofile("script/gamefunctions/helpscreen.lua")

--  Initialize all gameplay values
function game.init ()
  game.enteredNewRoom = false
  game.turnCount = 0
  
  game.initItems()
  game.initRooms()
end

--  We want to move to a new room
function game.requestTravel (direction)
  local requiredDirection = ""
  
  if direction == "north" then requiredDirection = "s" end
  if direction == "south" then requiredDirection = "n" end
  if direction == "east" then requiredDirection = "w" end
  if direction == "west" then requiredDirection = "e" end
  
  local roomID = {}
  
  for i,v in pairs(game.rooms) do
    if v.exits[requiredDirection] then table.insert(roomID, v.id) end
  end
  
  local num = math.random(#roomID)
  
  roomID = roomID[num]
  
  local room = deepcopy(game.getRoom(roomID))
  room = game.initRoomItems(room)
  
  game.currentRoom = room
  
  if game.currentRoom.enterfunc then
    game.currentRoom.enterfunc(game.currentRoom)
  end
  
  game.printRoomDescription()
  
end

--  Game over, man.
function game.quit ()
  game.shouldQuit = true
end

--  Resolve actions at the beginning of a new turn
function game.main()
  if game.shouldQuit then return true end
  --  Start of the game
  if game.turnCount == 0 then
    game.printRoomDescription()
  end
  
  if game.currentRoom.updatefunc and game.turnCount >= 1 then
    game.currentRoom.updatefunc(game.currentRoom)
  end
  
  
  game.turnCount = game.turnCount + 1
  return false
end