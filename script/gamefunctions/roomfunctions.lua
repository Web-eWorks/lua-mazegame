--  Room related functions.  Subset of gamefunctions.lua.

--  Load rooms from file
function game.initRooms ()
  game.rooms = {}
  game.startingRoom = game.initRoomItems(table.load("assets/roomdefs/start.room"))
  game.currentRoom = game.startingRoom
  
  local roomsToLoad = table.load("assets/roomdefs/rooms.ldef")
  
  for i,v in ipairs(roomsToLoad) do
    local _ = table.load("assets/roomdefs/"..v)
    game.rooms[_.id] = _
  end
end

--  Replace the item names with the actual items.
function game.initRoomItems ( room )
  local entriesToRemove = {}
  for i,v in ipairs(room.items) do
    room.items[v] = game.getItem(v)
    table.insert(entriesToRemove, i)
  end
  local iter = 0
  for i,v in ipairs(entriesToRemove) do
    v = v - iter
    table.remove(room.items, tonumber(v))
    iter = iter + 1
  end
  return game.initChanceItems(room)
end

--  Load items.  1 in 3 chance to get the item.
function game.initChanceItems ( room )
  local entriesToRemove = {}
  for i,v in ipairs(room.chanceItems) do
    local num = math.random(2,4)
    if num == 3 then
      room.items[v] = game.getItem(v)
    end
    table.insert(entriesToRemove, i)
  end
  
  local iter = 0
  for i,v in ipairs(entriesToRemove) do
    v = v - iter
    table.remove(room.chanceItems, tonumber(v))
    iter = iter + 1
  end
  return room
end

--  Return an entry in the rooms database.
function game.getRoom ( roomID )
  return game.rooms[roomID]
end

--  Check if there is an item of a specific type in this room
function game.checkItemInRoom ( itemID )
  if game.currentRoom.items[itemID] then
    return game.getItem(itemID)
  end
  return nil
end

--  Remove an item from the room's database.  Backend to game.takeItem()
function game.removeItemFromRoom ( itemID )
  local item = game.checkItemInRoom(itemID)
  if not item then
    print("That item is not in the room")
    return nil
  end
  if not item.canTake then
    print("You can't take that item.")
    return nil
  end

  game.currentRoom.items[itemID] = nil
  return item
end

--  Prints the description of the current room.
function game.printRoomDescription ( )  
  local roomDesc = game.currentRoom.description
  local roomName = game.currentRoom.name
  local roomExits = ""
  local roomItems = ""
  
  local numExits = 0
  
  if game.currentRoom.exits.n == true then
    roomExits = roomExits.."North, "
    numExits = numExits + 1
  end
  if game.currentRoom.exits.s == true then
    roomExits = roomExits.."South, "
    numExits = numExits + 1
  end
  if game.currentRoom.exits.e == true then
    roomExits = roomExits.."East, "
    numExits = numExits + 1
  end
  if game.currentRoom.exits.w == true then
    roomExits = roomExits.."West, "
    numExits = numExits + 1
  end
  
  local numItems = 0
  
  for i,v in pairs(game.currentRoom.items) do
    roomItems = roomItems.."a "..v.name..", "
    numItems = numItems + 1
  end
  
  roomExits = string.sub(roomExits, 1, string.len(roomExits)-2).."."
  
  roomItems = string.sub(roomItems, 1, string.len(roomItems)-2).." "
  
  print("You are in "..roomName..".  "..roomDesc)
  
  if numItems == 1 then
    print("There is "..roomItems.."here.")
  elseif numItems > 1 then
    print("There are "..roomItems.."here.")
  else
    print("There is nothing of importance here.")
  end
  
  if numExits == 0 then
    print("There are no exits to this room.")
  elseif numExits == 1 then
    print("The only exit from this room is "..roomExits)
  else
    print("The exits from this room are "..roomExits)
  end
end  --  This was a monster.