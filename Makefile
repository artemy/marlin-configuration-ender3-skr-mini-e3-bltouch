MARLIN_DIR=marlin
MARLIN_CONFIG_DIR=marlin-configurations
PLATFORMIO_ENV=STM32F103RC_btt
# Release tag of the commit checked out in the marlin submodule (e.g. 2.1.2.8)
MARLIN_TAG=$$(git -C $(MARLIN_DIR) describe --tags --exact-match --match '[0-9]*')
PATCH_FILE=ender-3-pro-skr-mini-e3-bltouch-$(MARLIN_TAG).diff

.PHONY: clean build all
.SILENT: clean patch build

all: clean patch build

patch:
	echo "Found Marlin tag" $(MARLIN_TAG)
	echo "Applying" $(PATCH_FILE)
	git -C $(MARLIN_CONFIG_DIR) apply --reject $(CURDIR)/config/$(PATCH_FILE)
	echo "Replacing default configuration in Marlin directory"
	cp $(MARLIN_CONFIG_DIR)/config/examples/Creality/Ender-3\ Pro/BigTreeTech\ SKR\ Mini\ E3\ 2.0/* $(MARLIN_DIR)/Marlin

build:
	echo "Starting build"
	platformio run --project-dir $(MARLIN_DIR) --environment $(PLATFORMIO_ENV)

clean:
	echo "Cleaning submodules"
	git -C $(MARLIN_DIR) reset --hard
	git -C $(MARLIN_DIR) clean -dfx
	git -C $(MARLIN_CONFIG_DIR) reset --hard
	git -C $(MARLIN_CONFIG_DIR) clean -df
	echo "Cleaning build folder"
	platformio run --project-dir $(MARLIN_DIR) --environment $(PLATFORMIO_ENV) --target clean
