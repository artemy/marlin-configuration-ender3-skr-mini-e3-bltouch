#!/usr/bin/env sh
LATEST_TAG=$(git -C marlin describe --tags `git rev-list --tags --max-count=1`)
echo "---------------"
echo "Found latest tag: $LATEST_TAG"
echo "---------------"

PATCH_FILE="ender-3-pro-skr-mini-e3-bltouch-$LATEST_TAG.diff"
echo "---------------"
echo "Applying $PATCH_FILE"
echo "---------------"
git -C marlin-configurations apply --reject ../config/$PATCH_FILE

echo "---------------"
echo "Replacing default configuration in Marlin directory"
echo "---------------"
cp marlin-configurations/config/examples/Creality/Ender-3\ Pro/BigTreeTech\ SKR\ Mini\ E3\ 2.0/* marlin/Marlin

echo "---------------"
echo "Cleaning build folder"
echo "---------------"
platformio run --project-dir marlin --environment STM32F103RC_btt_512K -t clean
echo "---------------"
echo "Starting build"
echo "---------------"
platformio run --project-dir marlin --environment STM32F103RC_btt_512K