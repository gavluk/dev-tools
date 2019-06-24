#!/bin/sh

echo "Calling $1 as wss. Use http://echo.websocket.org as working example"

curl -i -N -H "Connection: Upgrade" -H "Upgrade: websocket" -H "Host: echo.websocket.org" -H "Origin: http://www.websocket.org" $1
