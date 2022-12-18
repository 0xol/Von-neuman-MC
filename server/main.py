import asyncio
import websockets

async def echo(websocket):
    try:
        #async for message in websocket:
        await websocket.send('print("Hello Boss")')
        print("connection made")
    except:
        print("connection closed")

async def main():
        async with websockets.serve(echo, "192.168.1.117", 8863, compression=None) :
            await asyncio.Future()  # run forever

asyncio.run(main())