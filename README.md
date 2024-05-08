# PowerControl

![download](https://user-images.githubusercontent.com/759062/230850075-2669fada-44e5-4cb1-99cb-57e6c046221a.jpg)

Alternate installer for the decky-loader plugin from https://github.com/mengmeet/PowerControl

This is primarily intended to work with ChimeraOS or other installations that already have a working ryzenadj binary pre-installed or installed separately. Optionally, Python PortIO needs to be installed separately for fan controls if not already installed. If needed, these can be put in the plugin's folder at bin/ryzenadj and backend/portio.so rather than installing system-wide.

Code at this fork may not be kept up-to-date, only updating as I need it.

This installer modification removes the pre-built binaries before installing, but the built-in updater will only install the original version with the pre-built binaries, so you must use this installer when there are updates if you don't want their pre-built binaries installed. If you've already installed it before, you need to manually remove the binaries from your PowerControl installation if you don't want them (if you already have them installed system-wide) or replace them with the versions you want.

## Installation instructions

1. Install decky-loader
2. In a console on your device, run:
```
curl -L https://raw.githubusercontent.com/ShadowFlare/PowerControl/main/install.sh | sh
```
