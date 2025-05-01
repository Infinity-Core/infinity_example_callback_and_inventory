--[[---------------------------------------------------------------------------------------------------------
    # INFINITY TEST CALLBACK
    # Description: Resource de test pour le système de callback d'Infinity Core
]]------------------------------------------------------------------------------------------------------------

fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Votre Nom'
description 'Test du système de callback pour Infinity Core'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

-- Dépendances
dependencies {
    'infinity_core'
}