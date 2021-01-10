#!/usr/bin/env sh
cp config/* marlin/Marlin
platformio run --project-dir marlin --environment STM32F103RC_btt_512K -t clean
platformio run --project-dir marlin --environment STM32F103RC_btt_512K