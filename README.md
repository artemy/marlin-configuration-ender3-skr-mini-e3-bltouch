# Marlin Configuration for Creality Ender 3 Pro with SKR Mini E3 V2 board & 3D Touch probe

Custom [Marlin](https://github.com/MarlinFirmware/Marlin) configuration for my 3D Printer setup:

- [Creality Ender 3 Pro](https://www.creality.com/goods-detail/ender-3-pro-3d-printer)
- [SKR Mini E3 2.0 motherboard](https://www.biqu.equipment/products/bigtreetech-skr-mini-e3-v2-0-32-bit-control-board-integrated-tmc2209-uart-for-ender-3)
- [Trianglelab 3D Touch leveling sensor](https://www.aliexpress.com/item/32949450525.html)
    - [Adjustable BL-Touch sensor mount for Ender 3](https://www.thingiverse.com/thing:3148733)

Custom part is just a patch over
the [example configuration](https://github.com/MarlinFirmware/Configurations/tree/028f09221a5de4efd87a04d33e89e5c24d53d5bc/config/examples/Creality/Ender-3%20Pro/BigTreeTech%20SKR%20Mini%20E3%202.0)
for Ender 3 Pro/SKR Mini E3 V2 board.

## Change description

Most important changes introduced in this custom configuration:

- Enable 3D Touch probe
- Disable Z-MIN Probe in favor of 3D Touch
- Use 3D Touch probe for Z homing
- Correct probe offsets for the used [mount](https://www.thingiverse.com/thing:3148733)
- Lower probe feedrate for reliability
- Enable M48 probe repeatability command to test probe accuracy
- Disable software endstop for Z probe (otherwise it's impossible to correctly set Probe Z-offset)
- Enable Bilinear Bed Leveling via probing
- Restores leveling after G28 (Auto Home) command
- Smaller leveling grid (4x4 instead of default 5x5)
- Z-safe homing (home Z in the middle of the bed)
- Enable probe offset wizard (makes tuning probe z-offset much easier)
- Display estimated time to completion
    - Enable M73 remaining time command (Use data from M73 command to show remaining time, since I
      use [Octoprint](https://octoprint.org))
    - Enable progress display rotation (rotate between progress, elapsed and remaining time)
- Show heating in a progress bar
- Enable [HOST_ACTION_COMMANDS](https://community.octoprint.org/t/octoprint-tells-me-my-firmware-lacks-support-for-host-action-commands-what-does-this-mean/34588) (inform OctoPrint about start/stop/pause/etc. events)

## How does this work?

1. Patch for the correct version is applied to
   the [example configuration](https://github.com/MarlinFirmware/Configurations/tree/028f09221a5de4efd87a04d33e89e5c24d53d5bc/config/examples/Creality/Ender-3%20Pro/BigTreeTech%20SKR%20Mini%20E3%202.0)
   for Creality Ender 3 Pro + SKR Mini E3 V2 setup in the [marlin-configurations](marlin-configurations) directory.
2. Example configuration is copied to [marlin](marlin) directory
3. Firmware is built via [Platformio](https://platformio.org)

Check [Makefile](Makefile) for more details

### Supported versions of Marlin

Patches are provided for the following [Marlin](https://github.com/MarlinFirmware/Marlin) versions

- [2.0.7.2](config/ender-3-pro-skr-mini-e3-bltouch-2.0.7.2.diff)
- [2.0.9.2](config/ender-3-pro-skr-mini-e3-bltouch-2.0.9.2.diff)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
