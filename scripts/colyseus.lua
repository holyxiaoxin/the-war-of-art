-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local colyseus_client = require "colyseus.client"
local client
local room

local Module = {}

local screen_x = 640
local screen_y = 1136

local updates = 0 -- debugging

local function start (self, go)
  client = colyseus_client.new("ws://128.199.80.90:2657")
  -- client = colyseus_client.new("ws://localhost:2657")
  room = client:join("common")

  -- listen for changes on a path on the state
  room:listen("players/:id/position/:attribute", function(change)
    updates = updates + 1
    if (updates/60 % 1) == 0 then
      print(updates/60) -- track update rate
    end

    -- print(change.operation)
    -- print(change.path.id)
    -- print(change.path.attribute)
    -- print(change.value)
    -- print(change.value)
    -- print(change.value)

    -- self.dir.x
    -- if client.id

    if client.id == change.path.id then
      if change.path.attribute == 'x' then
        self.myNextDir.x = change.value
      elseif change.path.attribute == 'y' then
        self.myNextDir.y = change.value
      end

      -- print(self.myNextDir)
    else

      if change.path.attribute == 'x' then
        self.oppNextDir.x = screen_x - change.value
      elseif change.path.attribute == 'y' then
        self.oppNextDir.y = screen_y - change.value
      end

      -- print(self.oppNextDir)
    end

  end)

  return client, room
end

Module.start = start

return Module
