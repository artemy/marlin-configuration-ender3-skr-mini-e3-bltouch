# Marlin Configuration for Creality Ender 3 Pro with SKR Mini E3 V2 board & 3D Touch probe

Custom [Marlin](https://github.com/MarlinFirmware/Marlin) configuration for my 3D Printer setup:

- [Creality Ender 3 Pro](https://www.creality.com/goods-detail/ender-3-pro-3d-printer)
- [SKR Mini E3 2.0 motherboard](https://www.biqu.equipment/products/bigtreetech-skr-mini-e3-v2-0-32-bit-control-board-integrated-tmc2209-uart-for-ender-3)
- [Trianglelab 3D Touch leveling sensor](https://www.aliexpress.com/item/32949450525.html)
    - [Adjustable BL-Touch sensor mount for Ender 3](https://www.thingiverse.com/thing:3148733)

Custom part is just a patch over
the [example configuration](https://github.com/MarlinFirmware/Configurations/tree/f083973abeb6ece641e3437ddf03dc43a268c6a4/config/examples/Creality/Ender-3%20Pro/BigTreeTech%20SKR%20Mini%20E3%202.0)
for Ender 3 Pro/SKR Mini E3 V2 board.

## Change description

Most important changes introduced in this custom configuration:

- Enable 3D Touch probe
- Disable Z-MIN Probe in favor of 3D Touch
- Use 3D Touch probe for Z homing
- Correct probe offsets (X/Y and Z) for the used [mount](https://www.thingiverse.com/thing:3148733)
- Mark sensorless-homing DIAG jumpers as removed (mechanical endstops are used)
- Lower probe feedrate for reliability
- Enable M48 probe repeatability command to test probe accuracy
- Disable software endstop for Z probe (otherwise it's impossible to correctly set Probe Z-offset)
- Enable Bilinear Bed Leveling via probing
- Restores leveling after G28 (Auto Home) command
- Smaller leveling grid (4x4 instead of default 5x5)
- Z-safe homing (home Z in the middle of the bed)
- Assisted tramming (`G35` and an LCD wizard): probes next to each bed screw and reports how far to turn it
- Enable probe offset wizard (makes tuning probe z-offset much easier)
- Babystepping also adjusts the probe Z offset (tune the first layer live, then `M500`), with a graphical overlay
- Display estimated time to completion
    - Enable `M73 R` (set remaining time) so the host or slicer can supply the remaining time, since I
      use [Octoprint](https://octoprint.org)
    - The display rotates between progress, elapsed and remaining time
- Show heating in a progress bar
- Monitor TMC2209 driver status (reduce current before overheating, stop on driver errors)
- Enable [HOST_ACTION_COMMANDS](https://community.octoprint.org/t/octoprint-tells-me-my-firmware-lacks-support-for-host-action-commands-what-does-this-mean/34588) (inform OctoPrint about start/stop/pause/etc. events)

## How does this work?

1. Patch for the correct version is applied to
   the [example configuration](https://github.com/MarlinFirmware/Configurations/tree/f083973abeb6ece641e3437ddf03dc43a268c6a4/config/examples/Creality/Ender-3%20Pro/BigTreeTech%20SKR%20Mini%20E3%202.0)
   for Creality Ender 3 Pro + SKR Mini E3 V2 setup in the [marlin-configurations](marlin-configurations) directory.
2. Example configuration is copied to [marlin](marlin) directory
3. Firmware is built via [Platformio](https://platformio.org)

Tasks are defined in [mise.toml](mise.toml); [mise](https://mise.jdx.dev) also installs the pinned PlatformIO version:

```shell
git submodule update --init
mise install
mise run build   # clean → patch → build; firmware in marlin/.pio/build/*/firmware.bin
```

### Supported versions of Marlin

Patches are provided for the following [Marlin](https://github.com/MarlinFirmware/Marlin) versions

- [2.0.7.2](config/ender-3-pro-skr-mini-e3-bltouch-2.0.7.2.diff)
- [2.0.9.2](config/ender-3-pro-skr-mini-e3-bltouch-2.0.9.2.diff)
- [2.1.2.8](config/ender-3-pro-skr-mini-e3-bltouch-2.1.2.8.diff) (current)

### Upgrading from 2.0.x to 2.1.x

The EEPROM layout changed, so the stored settings are reset on the first boot. Before flashing:

1. Run `M503` and save the output (probe Z offset `M851`, steps `M92`, PID `M301`/`M304`)
2. Flash the new firmware
3. Run `M502`, re-enter the saved values, then `M500`
4. Re-probe the bed (`G28`, `G29`, `M500`)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
