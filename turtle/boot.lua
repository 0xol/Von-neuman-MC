--location of your arrow's central block
local posx = -387
local posy = 63
local posz = -144

local posface = "NORTH"

local response = ""

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

function turnRight()
    
    turtle.turnRight()
    
    if (posface == "NORTH") then
        posface = "EAST"
        return
    elseif (posface == "SOUTH") then
        posface = "WEST"
        return
    elseif (posface == "EAST") then
        posface = "SOUTH"
        return
    elseif (posface == "WEST") then
        posface = "NORTH"
        return
    end 
end

function moveUp()
    turtle.up()
    posy = posy + 1
end

function moveDown()
    turtle.down()
    posy = posy - 1
end

function refuel(amount)
    turtle.refuel(amount)
end

function selectSlot(slotNum)
    turtle.select(slotNum + 1) --plus one because lua indexing starts at and python starts at 0
end

function craftItem(amount)
    turtle.craft(amount)
end

function mine()
    turtle.dig()
end

function mineUp()
    turtle.digUp()
end

function mineDown()
    turtle.digDown()
end

function place()
    turtle.place()
end

function placeUp()
    turtle.placeUp()
end

function placeDown()
    turtle.placeDown()
end

function deposit(amount)
    turtle.drop(amount)
end

function depositUp(amount)
    turtle.dropUp(amount)
end

function depositDown(amount)
    turtle.dropDown()
end

function grab(amount)
   turtle.suck(amount) 
end

function grabUp(amount)
    turtle.suckUp(amount)
end

function grabDown(amount)
    turtle.suckDown(amount)
end

function transfer(slot, amount)
    turtle.transferTo(slot, amount)
end

function sleep(seconds)
    os.sleep(seconds)
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

function serverRequestHandler(request)
    if request[2] == "COM=0" then
        moveForward()
    elseif request[2] == "COM=1" then
        turnLeft()
    elseif request[2] == "COM=2" then
        turnRight()
    elseif request[2] == "COM=3" then
        moveUp()
    elseif request[2] == "COM=4" then
        moveDown()
    elseif request[2] == "COM=5" then
        refuel(tonumber(split(request[3],"=")[2]))
    elseif request[2] == "COM=6" then
        selectSlot(tonumber(split(request[3],"=")[2]))
    elseif request[2] == "COM=7" then
        craftItem(tonumber(split(request[3],"=")[2]))
    elseif request[2] == "COM=8" then
        mine()
    elseif request[2] == "COM=9" then
        mineUp()
    elseif request[2] == "COM=10" then
        mineDown()
    elseif request[2] == "COM=11" then
        place()
    elseif request[2] == "COM=12" then
        placeUp()
    elseif request[2] == "COM=13" then
        placeDown()
    elseif request[2] == "COM=14" then
        deposit(tonumber(split(request[3],"=")[2]))
    elseif request[2] == "COM=15" then
        depositUp(tonumber(split(request[3],"=")[2]))
    elseif request[2] == "COM=16" then
        depositDown(tonumber(split(request[3],"=")[2]))
    elseif request[2] == "COM=17" then
        grab(tonumber(split(request[3],"=")[2]))
    elseif request[2] == "COM=18" then
        grabUp(tonumber(split(request[3],"=")[2]))
    elseif request[2] == "COM=19" then
        grabDown(tonumber(split(request[3],"=")[2]))
    elseif request[2] == "COM=20" then
        transfer((tonumber(split(request[3],"=")[2])), (tonumber(split(request[4],"=")[2])))
    elseif request[2] == "COM=21" then
        os.sleep((tonumber(split(request[3],"=")[2])))
    end
end

function main()

    if response ~= "" then
        ws.send(response)
        response = ""
    end

    ws.send("ID=" .. os.getComputerID() .. "___X=" .. posx .. "___Y=" .. posy .. "___Z=" .. posz .. "___FACE=" .. posface .. "___COM=99")

    local command = ws.receive()

    local command_table = split(command, "___")

    if (command_table[1] == "ID=" .. os.getComputerID()) then
        serverRequestHandler(command_table)
    end
end

main()

--while true do
--    main()
--end