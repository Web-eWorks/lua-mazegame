--  A text based adventure game
--  Explore a procedural maze!

--  Set everything in place
dofile("script/main.lua")

-- Main menu
clear()

print("Welcome to Maze Game v0.1\nby Webster Sheets\n")
print("Press Enter to start.")

io.read()

clear()

print("Try not to die.")
print(" ----- ")

--  Initialize everything
start()

--  Run the game
local returnVal = nil
while true do
  returnVal = main()
  if returnVal == 1 then
    break
  end
end

--  The game has ended.
clear()

print("Thank you for playing!\n")
print("Press Enter to close")

io.read()
clear()