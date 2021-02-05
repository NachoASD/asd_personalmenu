--------------------------
---By NachoASD @2020   ---
---NachoASD#5887       ---
--------------------------
fx_version 'cerulean'
game 'gta5'

author 'NachoASD'
description 'Un script para ver un menu personal con tu informacion'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    "client.lua"
}
server_scripts {
    "server.lua",
    "@mysql-async/lib/MySQL.lua"
}
