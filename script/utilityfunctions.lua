--  Implement static global utiity functions

function write ( sText )
  io.write(sText)
end

function clear ( )
  if os.getenv("TERM") then os.execute("clear") end
end

--  Load a table from a file
function table.load ( sPath )
  local func,err = loadfile(tostring(sPath))
  if err then return nil end
  return func()
end

--  Copy a table.
function deepcopy (orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end