--  Interpreter functions for dealing with items

--  Get an item ID from user input
function interpreter.getItemIDByFriendlyName ( sName )
  local itemID = nil
  sName = string.lower(sName)
  for k,v in pairs(game.items) do
    local foundItem = false
    for I,F in pairs(game.items[k].friendlyNames) do
      if string.lower(F) == sName then
        foundItem = true
        break
      end
    end
    if foundItem then
      itemID = k
      break
    end
  end
  return itemID
end

--  Wrapper for getItemIDByFriendlyName().  Gets it from a command.
function interpreter.getItemIDByCommand ( tCommand )
  local itemID = nil
  
  if tCommand[4] then
    itemID = interpreter.getItemIDByFriendlyName(tCommand[2].." "..tCommand[3].." "..tCommand[4])
  elseif tCommand[3] then
    itemID = interpreter.getItemIDByFriendlyName(tCommand[2].." "..tCommand[3])
  else
    itemID = interpreter.getItemIDByFriendlyName(tCommand[2])
  end
  
  return itemID
end