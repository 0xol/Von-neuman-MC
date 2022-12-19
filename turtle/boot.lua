print("enter x")
local posx = tonumber(io.read())
print("enter y")
local posy = tonumber(io.read())
print("enter z")
local posz = tonumber(io.read())

local ws, err = http.websocket("ws://192.168.1.117:8863")

ws.send("ID=" .. os.getComputerID() .. "___X=" .. posx .. "___Y=" .. posy .. "___Z=" .. posz)

ws.close()
--func = assert(loadstring(ws.receive(5)))
--func()
