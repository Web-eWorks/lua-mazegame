--  The help screen.
--  Totally self contained.
function game.showHelpScreen ()
  clear()
  print("Maze Game v0.1\n")
  print("Commands Currently Implemented:")
  print(" examine -- Shows details about an object")
  print(" inventory -- Shows the contents of your bag")
  print(" take -- Puts an item in your bag")
  print(" move -- Go to another room")
  print(" help -- Shows this screen")
  print(" exit -- Quits the game")
  print("\nPress Enter to continue.")
  io.read()
  clear()
end