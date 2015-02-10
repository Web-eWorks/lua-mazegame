--  Item related functions.  Subset of gamefunctions.lua.

--  Load items from file
function game.initItems ()
  game.items = {}
  
  local itemsToLoad = table.load("assets/itemdefs/items.ldef")
  
  for i,v in pairs(itemsToLoad) do
    local _ = table.load("assets/itemdefs/"..v)
    game.items[_.id] = _
  end
end

--  Get an item from the database.  Return nil if the item doesn't exist.
function game.getItem ( itemID )
  if game.items[itemID] then
    return game.items[itemID]
  else
    return nil
  end
end

--  Print an item's description, or let the item print it.
function game.printItemDescription ( item )
  if item.descFunc then
    item.descFunc(item)
    return
  end
  
  print(item.description)
end

--  Check if we have an item to show it's description.
function game.getItemToExamine (itemID)
  local item = game.checkItemInRoom(itemID)
  
  if not item then
    item = player.checkItemInBag(itemID)
  end
  
  return item
end

--  Examine an item.
function game.examineItem (itemID)
  local item = game.getItemToExamine(itemID)
  if not item then
    print("I cannot find that item.")
    return
  end
  
  game.printItemDescription(item)
end

--  Take an item from the room
function game.takeItem (itemID)
  local item = game.removeItemFromRoom(itemID)
  if not item then
    return
  end
  
  player.putItemInBag(item)
  
  print("Took the "..item.name)
end