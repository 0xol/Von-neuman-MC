local ws, err = http.websocket("ws://192.168.1.177:8863")

while true do
    sleep(1)
    func = assert(loadstring(ws.receive()))
    func()
end