local ws, err = http.websocket("ws://192.168.1.177:8863")

while true do
    sleep(5)
    ws.send(json.encode({id=os.getComputerLabel()}))
    func = assert(loadstring(ws.receive(5)))
    func()
end