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