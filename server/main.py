import asyncio
import websockets
import json

def handleTurtleData(data):
    print(data)
    return "ID=0"
        

async def handler(websocket):
    try:
        async for message in websocket:
            await websocket.send(handleTurtleData(message))
    except:
        return

async def main():
        async with websockets.serve(handler, "192.168.1.15", 8863, compression=None) :
            await asyncio.Future()  # run forever

asyncio.run(main())