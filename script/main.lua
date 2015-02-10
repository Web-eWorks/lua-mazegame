--  Defines the execution of the game.

-- Set up the game environment
game = {}

--  register utility functions
dofile("script/utilityfunctions.lua")

--  Register game functions
dofile("script/gamefunctions/gamefunctions.lua")

--  Register the player
dofile("script/player.lua")

--  Register the interpreter
dofile("script/interpreter.lua")

----

--  One-time initialization at the start of the game.
function start()
  game.init()
  player.init()
  interpreter.loadDefs()
end

--  The main loop - returns 0 to continue, 1 to terminate.
function main ()
  --  Update everything.  If we called game.quit last turn then quit.
  if game.main() then return 1 end
  
  write("> ")
  
  --  Catch commands from the player
  local input = io.read()
  
  --  Handles dispatching gameplay functions and interpreting player commands
  interpreter.run(input)
  
  return 0
end