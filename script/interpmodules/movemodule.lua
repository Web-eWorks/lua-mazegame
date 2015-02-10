--  Interpreter functions for dealing with movement

function interpreter.resolveMovement( direction ) 
  local cantGo = function () print("There isn't an exit that way.") end
  
  if direction == "north" then
    if game.currentRoom.exits.n then
      game.requestTravel(direction)
    else cantGo() end
  elseif direction == "south" then
    if game.currentRoom.exits.s then
      game.requestTravel(direction)
    else cantGo() end
  elseif direction == "east" then
    if game.currentRoom.exits.e then
      game.requestTravel(direction)
    else cantGo() end
  elseif direction == "west" then
    if game.currentRoom.exits.w then
      game.requestTravel(direction)
    else cantGo() end
  else
    print("That isn't a direction.")
  end
end