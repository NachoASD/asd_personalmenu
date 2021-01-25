--------------------------
---By NachoASD @2020   ---
---NachoASD#5887       ---
--------------------------

author 'NachoASD'
description 'Un script para tener monedas de donador'
version '1.0.0'

fx_version 'adamant'
game 'gta5'

shared_script 'config.lua'
client_scripts {
    "client.lua",
    "@NativeUI/NativeUI.lua"
}
server_scripts {
    "server.lua",
    "@mysql-async/lib/MySQL.lua"
}
