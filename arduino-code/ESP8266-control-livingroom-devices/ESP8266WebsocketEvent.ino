void webSocketEvent(WStype_t type, uint8_t *payload, size_t length)
{
    switch (type)
    {
    case WStype_DISCONNECTED:
        DEBUG_SERIAL.printf("[WSc] Disconnected!\n");
        break;

    case WStype_CONNECTED:
        DEBUG_SERIAL.printf("[WSc] Connected to url: %s\n", payload);
        break;

    case WStype_TEXT:
    {
        String str = (char *)payload;
        Serial.println(str);
        int index = str.indexOf(":");
        String room = str.substring(0, index);
        if (room.equals("livingRoom"))
        {
            String device = str.substring(index + 1, str.length());
            livingRoom(device);
        }


        DEBUG_SERIAL.printf("[WSc] RESPONSE: %s\n", str);
    }
    break;
    }
}
