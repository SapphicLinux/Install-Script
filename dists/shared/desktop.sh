#!/bin/bash

#apt install -y kde-full sddm flatpak plasma-discover-backend-flatpak
#flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#com.brave.Browser

apt install -y kde-standard sddm flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
options=(
#Browsers
         1 "----------BROWSERS----------" off
         BraveBrowser "Privacy-Oriented Chromium Browser" off
         LibreWolf "Privacy-Oriented Firefox Fork" off
         Firefox "Firefox" off
         Edge "Microsoft Edge" off
         Chrome "Google Chrome" off
#Productive
         2 "--------PRODUCTIVITY--------" off
         Zoom "Zoom Video Call Client" off
         Slack "Slack Messenger" off
         Teams "Microsoft Teams Client" off
#Tools
         3 "------------TOOLS-----------" off
         VSCodium "VSCode without Telemetry" off
         qBittorrent "Torrent Client" off
         OBS "Record and Stream your screen" off
#Gaming
         4 "-----------GAMING-----------" off
         Steam "Steam Store & Launcher" off
         SteamLink "Steam Remote Play" off
         XIVLauncher "FFXIV Launcher for Linux" off
         PrismLauncher "Minecraft Launcher" off
         Itch "Itch.io Store & Launcher" off
         Heroic "EA, GOG, Epic Games, etc. Game Launcher" off
#Emulators
         5 "---------EMULATORS----------" off
         RetroArch "Multi-System Emulator" off
         Yuzu "Nintendo Switch Emulator" off
         Dolphin "Nintendo Wii/GameCube Emulator" off
         SteamROMManager "Add Emulated Games to Steam" off
         VirtManager "Virtual Machine Manager" off
         Waydroid "Android Emulator" off
         Cemu "Nintendo WiiU Emulator" off
#Video
         6 "-----------VIDEO------------" off
         Jellyfin "Jellyfin Media Player" off
         Pipeline "YouTube/PeerTube client" off
         Delfin "Jellyfin Client" off
         Parabolic "YouTube Downloader" off
#Music
         7 "-----------MUSIC------------" off
         Spotify "Spotify Desktop Client" off
         Cider "Apple Music Client" off
         Kast "Podcast Client" off
#Art
         8 "------------ART-------------" off
         Krita "Digital Paint" off
         GIMP "Image Editor" off
         Kdenlive "Video Editor" off
         Audacity "Audio Editor" off
         LMMS "Music Creator" off
         Blender "3D Modeling" off
#Social
         9 "-----------SOCIAL-----------" off
         Thunderbird "Email, Calendar, Contacts congregate" off
         Discord "Discord Desktop Client" off
         Tuba "Mastodon Client" off
         Element "Matrix Client" off
#Cloud
         10 "-----------CLOUD-----------" off
         Celeste "Cloud Storage Synchronization" off
         Nextcloud "Self-hosted Cloud Storage" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
#clear
echo $choices
for c in $choices;do
echo $c
done
echo "initializing package arrays"
flatpaks=()
apts=()
#exit
for choice in $choices
do
    case $choice in
        BraveBrowser)
            flatpaks+=('com.brave.Browser')
            ;;
        LibreWolf)
            flatpaks+=('io.gitlab.librewolf-community')
            ;;
        Firefox)
            apts+=('firefox')
            ;;
        Edge)
            flatpaks+=('com.microsoft.Edge')
            ;;
        Chrome)
            flatpaks+=('com.google.Chrome')
            ;;
        Zoom)
            flatpaks+=('us.zoom.Zoom')
            ;;
        Slack)
            flatpaks+=('com.slack.Slack')
            ;;
        Teams)
            flatpaks+=('com.github.IsmaelMartinez.teams_for_linux')
            ;;
        VSCodium)
            flatpaks+=('com.vscodium.codium')
            ;;
        qBittorrent)
            apts+=('qbittorrent')
            ;;
        OBS)
            apts+=('obs-studio')
            ;;
        Steam)
            sudo apt-add-repository contrib -y
            apts+=('steam-installer')
            ;;
        SteamLink)
            flatpaks+=('com.valvesoftware.SteamLink')
            ;;
        XIVLauncher)
            flatpaks+=('dev.goats.xivlauncher')
            ;;
        PrismLauncher)
            flatpaks+=('org.prismlauncher.PrismLauncher')
            ;;
        Itch)
            flatpaks+=('io.itch.itch')
            ;;
        Heroic)
            flatpaks+=('com.heroicgameslauncher.hgl')
            ;;
        Retroarch)
            flatpaks+=('org.libretro.RetroArch')
            ;;
        Yuzu)
            flatpaks+=('org.yuzu_emu.yuzu')
            ;;
        Dolphin)
            flatpaks+=('org.DolphinEmu.dolphin-emu')
            ;;
        SteamROMManager)
            flatpaks+=('com.steamgriddb.steam-rom-manager')
            ;;
        VirtManager)
            apts+=('virt-manager')
            ;;
        Waydroid)
            sudo apt install curl ca-certificates -y
            curl https://repo.waydro.id | sudo bash
            apts+=('waydroid')
            ;;
        Cemu)
            flatpaks+=('info.cemu.Cemu')
            ;;
        Jellyfin)
            flatpaks+=('com.github.iwalton3.jellyfin-media-player')
            ;;
        Pipeline)
            flatpaks+=('de.schmidhuberj.tubefeeder')
            ;;
        Delfin)
            flatpaks+=('cafe.avery.Delfin')
            ;;
        Parabolic)
            flatpaks+=('org.nickvision.tubeconverter')
            ;;
        Spotify)
            flatpaks+=('com.spotify.Client')
            ;;
        Cider)
            flatpaks+=('sh.cider.Cider')
            ;;
        Kast)
            flatpaks+=('org.kde.kasts')
            ;;
        Krita)
            flatpaks+=('org.kde.krita')
            ;;
        GIMP)
            flatpaks+=('org.gimp.GIMP')
            ;;
        Kdenlive)
            flatpaks+=('org.kde.kdenlive')
            ;;
        Audacity)
            flatpaks+=('org.audacityteam.Audacity')
            ;;
        LMMS)
            flatpaks+=('io.lmms.LMMS')
            ;;
        Blender)
            flatpaks+=('org.blender.Blender')
            ;;
        Thunderbird)
            flatpaks+=('org.mozilla.Thunderbird')
            ;;
        Discord)
            flatpaks+=('com.discordapp.Discord')
            ;;
        Tuba)
            flatpaks+=('dev.geopjr.Tuba')
            ;;
        Element)
            flatpaks+=('im.riot.Riot')
            ;;
        Celeste)
            flatpaks+=('com.hunterwittenborn.Celeste')
            ;;
        Nextcloud)
            flatpaks+=('com.nextcloud.desktopclient.nextcloud')
            ;;
        *)
            echo "no match"
            ;;
    esac
done

echo "apt packages to install: ${apts[@]}"
sudo install -y "${apts[@]}"
echo "flatpaks to install: ${flatpaks[@]}"
sudo flatpak install -y --system "${flatpaks[@]}"
