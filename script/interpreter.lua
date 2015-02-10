--  The text interpreter.  Loaded after everything.

interpreter = {}

--  Load modules
dofile("script/interpmodules/itemmodule.lua")
dofile("script/interpmodules/movemodule.lua")

--  Load command definitions
function interpreter.loadDefs ()
  interpreter.def = {}
  
  local defsToLoad = table.load("assets/interpdefs/commands.ldef")
  
  for i,v in pairs(defsToLoad) do
    if string.sub(v, -5) == ".idef" then 
      interpreter.def[i] = table.load("assets/interpdefs/"..v)
    else -- Assume we are defining a command in-line.
      interpreter.def[i] = { v }
    end
  end
end

--  Compare a text string with a defined command.
function interpreter.resolveCommand ( sText, command )
  if type(command) ~= "table" then
    if command == sText then
      return true
    else
      return false
    end
  end
  for i,v in pairs(command) do
    if v == sText then
      return true
    end
  end
  return false
end

--  Check if the user wants to quit
function interpreter.checkExit ( sText )
  sText = string.lower(sText)
  return interpreter.resolveCommand(sText, interpreter.def.exit)
end

--  Remove articles from input.
function interpreter.catchArticles ( tCommand )
  for i,v in pairs(tCommand) do
    if v == "the" then
      table.remove(tCommand, i)
    elseif v == "a" then
      table.remove(tCommand, i)
    elseif v == "an" then
      table.remove(tCommand, i)
    end
  end
  return tCommand
end

--  Figure out what command the user inputted
function interpreter.resolveInput ( sInput )
  local words = {}
  
  sInput = string.lower(sInput)
  
  for word in string.gmatch(sInput, "%g+") do
    table.insert(words, word)
  end
  
  --  Remove "the", "a", and "an"
  words = interpreter.catchArticles(words)
  
  --  Show help
  if interpreter.resolveCommand(words[1], interpreter.def.help) then
    game.showHelpScreen()
    return
  end
  
  --  Examine something
  if interpreter.resolveCommand(words[1], interpreter.def.examine) then
    if not words[2] then -- Examine the room
      game.printRoomDescription()
      return
    elseif words[2] == "me" then -- You talkin' about ME?
      player.printDescription()
      return
    else -- Examine an item
      local itemID = interpreter.getItemIDByCommand(words)
      game.examineItem(itemID)
      return
    end
  end
  
  --  Take an item from the room
  if interpreter.resolveCommand(words[1], interpreter.def.take) then
    if not words[2] then print("Take what?") return end
    local itemID = interpreter.getItemIDByCommand(words)
    game.takeItem(itemID)
    return
  end
  
  --  Take inventory
  if interpreter.resolveCommand(words[1], interpreter.def.inventory) then
    player.printInventory()
    return
  end
  
  --  Move to another room
  if interpreter.resolveCommand(words[1], interpreter.def.move) then
    if not words[2] then print("Move where?") return end
    interpreter.resolveMovement(words[2])
    return
  end
  
  --  Also move to another room.
  if interpreter.resolveCommand(words[1], interpreter.def.directions) then
    if not words[2] then
      interpreter.resolveMovement(words[1])
      return
    end
  end
  
  --  Doesn't match up to anything.
  print("I did not understand that command.")
end

--  Interpret user-input
function interpreter.run ( input )
  if input == "" then return end  --  No command.  Equivalent to typing wait.
  if interpreter.checkExit(input) then game.quit() return end  --  Quit.
  
  interpreter.resolveInput(input)
  return 0
end