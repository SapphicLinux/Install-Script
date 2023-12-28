#!/bin/bash

#apt install -y kde-full sddm flatpak plasma-discover-backend-flatpak
#flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#com.brave.Browser

cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
options=(
#Browsers
         BraveBrowser "Privacy-Oriented Chromium Browser" off
         LibreWolf "Privacy-Oriented Firefox Fork" off
         Firefox "Firefox" off
         Chrome "Google Chrome" off
#Productive
         Zoom "Zoom" off
         VSCodium "VSCode without Telemetry" off
#Tools
         qBittorrent "Torrent Client" off
         OBS "Record and Stream your screen" off
#Gaming
         Steam "Steam Store & Launcher" off
         SteamLink "Steam Remote Play" off
         XIVLauncher "FFXIV Launcher for Linux" off
         PrismLauncher "Minecraft Launcher" off
         Itch "Itch.io Store & Launcher" off
         Heroic "EA, GOG, Epic Games, etc. Game Launcher" off
#Emulators
         RetroArch "Multi-System Emulator" off
         Yuzu "Nintendo Switch Emulator" off
         Dolphin "Nintendo Wii/GameCube Emulator" off
         SteamROMManager "Add Emulated Games to Steam" off
         VirtManager "Virtual Machine Manager" off
         Waydroid "Android Emulator" off
         Cemu "Nintendo WiiU Emulator" off
#Video
         Jellyfin "Jellyfin Media Player" off
         Pipeline "YouTube/PeerTube client" off
         Delfin "Jellyfin Client" off
         Parabolic "YouTube Downloader" off
#Music
         Spotify "Spotify Desktop Client" off
         Cider "Apple Music Client" off
         Kast "Podcast Client" off
#Art
         Krita "Digital Paint" off
         GIMP "Image Editor" off
         Kdenlive "Video Editor" off
         Audacity "Audio Editor" off
         LMMS "Music Creator" off
         Blender "3D Modeling" off
#Social
         Thunderbird "Email, Calendar, Contacts congregate" off
         Discord "Discord Desktop Client" off
         Tuba "Mastodon Client" off
         Element "Matrix Client" off
#Cloud
         Celeste "Cloud Storage Synchronization" off
         Nextcloud "Self-hosted Cloud Storage" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
#clear
echo $choices
for c in $choices;do
echo $c
done

exit
for choice in $choices
do
    case $choice in
        BraveBrowser)
            flatpak install -y com.brave.Browser
            ;;
        Steam)
            apt install -y steam-installer
            ;;
        Nextcloud)
            flatpak install -y com.nextcloud.desktopclient.nextcloud
            ;;
        PrismLauncher)
            flatpak install -y org.prismlauncher.PrismLauncher
            ;;
    esac
done
