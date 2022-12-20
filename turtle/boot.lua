--location of your arrow's central block
local posx = -387
local posy = 63
local posz = -144

local posface = "NORTH"

--ip & port of the python server
local ws, err = http.websocket("ws://192.168.1.117:8863")

function moveForward()
    
    turtle.forward()
    
    if (posface == "NORTH") then
        posx = posx + 1
        return
    elseif (posface == "SOUTH") then
        posx = posx - 1
        return
    elseif (posface == "EAST") then
        posz = posz + 1
        return
    elseif (posface == "WEST") then
        posz = posz + 1
        return
    end
end

function turnLeft()
    
    turtle.turnLeft()

    if (posface == "NORTH") then
        posface = "WEST"
        return
    elseif (posface == "SOUTH") then
        posface = "EAST"
        return
    elseif (posface == "EAST") then
        posface = "NORTH"
        return
    elseif (posface == "WEST") then
        posface = "SOUTH"
        return
    end

end

function split(input, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(input, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

--ws.send("ID=" .. os.getComputerID() .. "___X=" .. posx .. "___Y=" .. posy .. "___Z=" .. posz)

local block, data = turtle.inspect()

turtle.select(2 )
turtle.place()

data_p = data["name"]

ws.send(data_p)

print(split(ws.receive(), " ")[1]) 

ws.close()

--func = assert(loadstring(ws.receive(5)))
--func()
