#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

# Install chromebook-linux-audio
git clone https://github.com/mikaelvz/chromebook-linux-audio.git /tmp/chromebook-linux-audio
cd /tmp/chromebook-linux-audio
./setup-audio --platform cml

### Install keyd

# Install package
dnf5 --assumeyes copr enable alternateved/keyd
dnf5 --assumeyes install keyd
dnf5 --assumeyes copr disable alternateved/keyd

# Enable keyd service
systemctl enable keyd.service

# Install cros-keyboard-map quirks
git clone https://github.com/WeirdTreeThing/cros-keyboard-map /tmp/cros-keyboard-map
mkdir -p /etc/libinput
cp /tmp/cros-keyboard-map/local-overrides.quirks /etc/libinput/local-overrides.quirks

### Install ectool fanspeed

# Install ectool
dnf5 --assumeyes copr enable ublue-os/staging
dnf5 --assumeyes install fw-ectool
dnf5 --assumeyes copr disable ublue-os/staging

# Enable ectool-fanspeed service
systemctl enable ectool-fanspeed.service

### Install packages

# Install official Discord package
curl --fail --location 'https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=linux&arch=x64&format=rpm' --output /tmp/discord.rpm
dnf5 --assumeyes install --setopt=install_weak_deps=True /tmp/discord.rpm
rm /tmp/discord.rpm

# Install official VS Code package
curl --fail --location 'https://code.visualstudio.com/sha/download?build=stable&os=linux-rpm-x64' --output /tmp/vscode.rpm
dnf5 --assumeyes install --setopt=install_weak_deps=True /tmp/vscode.rpm
rm /tmp/vscode.rpm