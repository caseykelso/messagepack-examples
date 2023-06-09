BASE.DIR=$(PWD)
HASH := $(shell git rev-parse --short=10 HEAD)
TAG := $(shell git describe --tags)
APP.SOURCE=$(BASE.DIR)/source
APP.BUILD=$(BASE.DIR)/build
CMAKE.BIN=cmake
APP.BIN=$(APP.BUILD)/example

ifndef J_OVERRIDE
J := $(shell nproc --all)
else
J=$(J_OVERRIDE)
endif
$(info building with $(J) threads)
SHELL := /bin/bash

run: build
	$(APP.BIN)

help: app
	$(APP.BIN) --help 

version: app
	$(APP.BIN) --version

build: .FORCE
	rm -rf $(APP.BUILD)	
	mkdir -p $(APP.BUILD) && cd $(APP.BUILD) && $(CMAKE.BIN) $(APP.SOURCE)  && make -j$(J)

ctags: .FORCE
	cd $(BASE.DIR) && ctags -R --exclude=.git --exclude=build

clean: .FORCE
	rm -rf $(APP.BUILD)

.FORCE:

