#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

# Install chromebook-linux-audio
git clone https://github.com/mikaelvz/chromebook-linux-audio.git /tmp/chromebook-linux-audio
cd /tmp/chromebook-linux-audio
./setup-audio --platform cml

