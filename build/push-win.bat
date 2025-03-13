powershell -Command "Compress-Archive -Force -LiteralPath yokaiparade-win/ -DestinationPath yokaiparade-win.zip"

butler push ./yokaiparade-win.zip s4g/yokai-parade:win