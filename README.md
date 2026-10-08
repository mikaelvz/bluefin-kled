# Custom Universal Blue Bluefin image — Acer Chromebook Spin 713 (CP713-2W) (KLED)

- Audio support enabled with [chromebook-linux-audio](https://github.com/WeirdTreeThing/chromebook-linux-audio).
- Added support for Chromebook keyboard special keys with [keyd](https://copr.fedorainfracloud.org/coprs/alternateved/keyd/).
- Added fan speed control with **`ectool`**.
- Added official [Visual Studio Code](https://code.visualstudio.com/) package.

## Installation

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/mikaelvz/bluefin-kled:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/mikaelvz/bluefin-kled:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```
