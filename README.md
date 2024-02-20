# PowerControl

![download](https://user-images.githubusercontent.com/759062/230850075-2669fada-44e5-4cb1-99cb-57e6c046221a.jpg)

Fork of the decky-loader plugin from https://github.com/mengmeet/PowerControl

This is primarily intended to work with ChimeraOS or other installations that already have a working ryzenadj binary pre-installed or installed separately. Optionally, Python PortIO needs to be installed separately for fan controls if not already installed. If needed, these can be put in the plugin's folder at bin/ryzenadj and backend/portio.so rather than installing system-wide.

I may not necessarily keep this fork up-to-date, only updating as I need it.

The main changes from the original project are:
- Remove pre-built binaries.
- Add placeholders and instructions for where to put a local copy of ryzenadj and portio.so if not installing system-wide.

## Installation instructions

1. Install decky-loader
2. In a console on your device, run:
```
$ cd
$ curl -OL https://github.com/ShadowFlare/PowerControl/releases/latest/download/PowerControl.tar.gz
$ sudo rm -rf homebrew/plugins/PowerControl
$ sudo tar -xvzf PowerControl.tar.gz -C homebrew/plugins/
```
3. Reboot

To install the original version of the plugin from their repository but with the binaries removed, you can also use these instructions in place of step 2 above:

```
$ cd
$ curl -OL https://github.com/mengmeet/PowerControl/releases/latest/download/PowerControl.tar.gz
$ sudo rm -rf homebrew/plugins/PowerControl
$ sudo tar -xvzf PowerControl.tar.gz -C homebrew/plugins/
$ sudo rm -f homebrew/plugins/PowerControl/bin/ryzenadj
$ sudo rm -f homebrew/plugins/PowerControl/backend/portio.so
```

mengmeet's version may require portio.so to be available for the plugin the function properly, at least until there's a new release past v2.2.3.
