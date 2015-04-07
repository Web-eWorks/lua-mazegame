--  Interpreter functions for dealing with movement

--  Figure out which way we're going
function interpreter.resolveMovement( direction ) 
  local cantGo = function () print("There isn't an exit that way.") end
  
  if direction == "north" or direction == "n" then
    if game.currentRoom.exits.n then
      game.requestTravel(direction)
    else cantGo() end
  elseif direction == "south" or direction == "s" then
    if game.currentRoom.exits.s then
      game.requestTravel(direction)
    else cantGo() end
  elseif direction == "east" or direction == "e" then
    if game.currentRoom.exits.e then
      game.requestTravel(direction)
    else cantGo() end
  elseif direction == "west" or direction == "w" then
    if game.currentRoom.exits.w then
      game.requestTravel(direction)
    else cantGo() end
  else
    print("That isn't a direction.")
  end
end
