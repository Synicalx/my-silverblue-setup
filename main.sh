#!/bin/bash

echo "Adding Flathub..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing Firefox and Steam from Flathub..."
flatpak install -y flathub org.mozilla.firefox com.valvesoftware.Steam

MOUNT_POINT="/mnt/<something>"

if [ -d "$MOUNT_POINT" ]; then
    echo "Granting Steam Flatpak access to ${MOUNT_POINT}..."
    flatpak override --user --filesystem=${MOUNT_POINT} ${STEAM_APP}
else
    echo "Warning: Mount point ${MOUNT_POINT} does not exist. Skipping Steam Flatpak configuration."
fi

COMMON_TOOLS=(htop curl git)

echo "Installing common tools using rpm-ostree: ${COMMON_TOOLS[*]}..."
sudo rpm-ostree install "${COMMON_TOOLS[@]}"

echo "Done, reboot time!"
