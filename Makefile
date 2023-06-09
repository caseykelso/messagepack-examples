BASE.DIR=$(PWD)
HASH := $(shell git rev-parse --short=10 HEAD)
TAG := $(shell git describe --tags)
DOWNLOADS.DIR=$(BASE.DIR)/downloads
INSTALLED.HOST.DIR=$(BASE.DIR)/installed.host
APP.SOURCE=$(BASE.DIR)/source

ifndef J_OVERRIDE
J := $(shell nproc --all)
else
J=$(J_OVERRIDE)
endif
$(info building with $(J) threads)
SHELL := /bin/bash

ci: .FORCE
	cd $(BASE.DIR) && $(MAKE) ci.build
run.app: app.build
	export LD_LIBRARY_PATH=$(INSTALLED.HOST.DIR)/lib && $(APP.BIN) --config=$(CONFIGS.DIR)/empty.json --hwtype=oa1b --calibratephase='0.18973 0.64227 0.26816 -0.83603 -0.27191 -0.80695 -0.3743 0.61343 0.25952 0.64597 0.30566 -0.8006 -0.26086 -0.78204 -0.35056 0.57953 0.25836 0.68851 -0.39871 -0.79858 0.6019 -0.84232 0.49216 0.64111 -0.37228' --calibrateversion=1 --datatotcp

help: app
	export LD_LIBRARY_PATH=$(INSTALLED.HOST.DIR)/lib && $(APP.BIN) --help 

version: app
	export LD_LIBRARY_PATH=$(INSTALLED.HOST.DIR)/lib && $(APP.BIN) --version

app: app.clean app.build

app.build: .FORCE
		mkdir -p $(APP.BUILD) && cd $(APP.BUILD) && $(CMAKE.BIN) $(APP.SOURCE) -DCMAKE_INSTALL_PREFIX=$(INSTALLED.HOST.DIR) -DCMAKE_PREFIX_PATH=$(INSTALLED.HOST.DIR) -DCMAKE_BUILD_TYPE=Debug -DBUILD_DESKTOP=ON && VERBOSE=1 $(MAKE) -j$(J) install

app.clean: .FORCE
	rm -rf $(APP.BUILD)

ctags: .FORCE
	cd $(BASE.DIR) && ctags -R --exclude=.git --exclude=downloads --exclude=installed.host --exclude=installed.target --exclude=documents  --exclude=build.*  .

clean: .FORCE
	rm -rf $(DOWNLOADS.DIR)
	rm -rf $(INSTALLED.HOST.DIR)
	rm -rf $(APP.BUILD)


.FORCE:

