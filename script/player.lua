--  The player.  Store all transient game data here.

player = {}

--  Initialize player variables
function player.init ()
  player.itemBag = {}
end

--  Check for an item in the player's inventory.
function player.checkItemInBag(itemID)
  if player.itemBag[itemID] then
    if player.itemBag[itemID].num >= 1 then
      return player.itemBag[itemID]
    end
  end
  
  return nil
end

--  Show what is in our inventory
function player.printInventory ()
  local invS = ""
  
  for i,v in pairs(player.itemBag) do
    invS = invS.."a "..v.name..", "
  end
  
  if invS == "" then
    print("You are carrying nothing in your bag.")
    return
  end
  
  invS = string.sub(invS, 1, string.len(invS)-2) .. "."
  
  print("You are carrying "..invS)
end

function player.printDescription ()
  print("You are an average explorer.  You carry a bag, for holding things.")
end

--  Put an item in the player's inventory
function player.putItemInBag(item)
  if not player.itemBag[item.id] then
    player.itemBag[item.id] = item
    player.itemBag[item.id].num = 1
  end
  
  local num = player.itemBag[item.id].num
  player.itemBag[item.id].num = num + 1
end

--  Take an item from the player's inventory
function player.takeItemFromBag(itemID)
  if not player.itemBag[itemID] or player.itemBag[itemID].num == 0 then
    return nil
  end
  
  player.itemBag[itemID].num = player.itemBag[itemID].num - 1
  return player.itemBag[itemID]
end