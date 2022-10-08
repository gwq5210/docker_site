# curl请求websocket

```sh
curl --no-buffer -H 'Connection: keep-alive, Upgrade' -H 'Upgrade: websocket' -v -H 'Sec-WebSocket-Version: 13' -H 'Sec-WebSocket-Key: websocket' "http://gwq5210.com/api/mirai_ws/all?verifyKey=a123456789&qq=2423087292" -v --http1.1 -x http://localhost:8888 -L
curl --no-buffer -H 'Connection: keep-alive, Upgrade' -H 'Upgrade: websocket' -v -H 'Sec-WebSocket-Version: 13' -H 'Sec-WebSocket-Key: websocket' "https://gwq5210.com/api/mirai_ws/all?verifyKey=a123456789&qq=2423087292" -v --http1.1
curl --no-buffer -H 'Connection: keep-alive, Upgrade' -H 'Upgrade: websocket' -v -H 'Sec-WebSocket-Version: 13' -H 'Sec-WebSocket-Key: websocket' "https://mirai_ws.gwq5210.com/all?verifyKey=a123456789&qq=2423087292" -v --http1.1
```
