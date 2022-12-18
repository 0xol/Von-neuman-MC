import asyncio
import websockets

def handleTurtleData(data):
    if int(data.message.id) != 1:
        return 'os.setComputerLabel(1)'

async def echo(websocket):
    try:
        async for message in websocket:
            print(message)
            
            await websocket.send(handleTurtleData)

        print("connection made")
    except:
        print("connection closed")

async def main():
        async with websockets.serve(echo, "192.168.1.117", 8863, compression=None) :
            await asyncio.Future()  # run forever

asyncio.run(main())