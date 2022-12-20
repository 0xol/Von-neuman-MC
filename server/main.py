import asyncio
import websockets
import json

def handleTurtleData(data):
    print(data)
    return "SUS"
        

async def echo(websocket):
    print("connection made")
    try:
        async for message in websocket:
            await websocket.send(handleTurtleData(message))
    except:
        print("connection closed")

async def main():
        async with websockets.serve(echo, "192.168.1.117", 8863, compression=None) :
            await asyncio.Future()  # run forever

asyncio.run(main())