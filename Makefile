
NAME=blink
PICO_SDK_PATH=~/pico/pico-sdk
PICO=pci-0000:00:14.0-usb-0:6.2:1.0-scsi-0:0:0:0-part1

all:
	-mkdir build
	cd build; NAME=$(NAME) PICO_SDK_PATH=$(PICO_SDK_PATH) cmake ..; make

pico2:
	-mkdir build
	cd build; NAME=$(NAME) PICO_SDK_PATH=$(PICO_SDK_PATH) cmake .. -DPICO_PLATFORM=rp2350 -DPICO_BOARD=pico2 ; make

run:
	sudo cp build/$(NAME).uf2 /mnt/pico
	sudo sync

clean:
	rm -fr build

mnt:
	-mkdir -p /mnt/pico
	-sudo ln -s /dev/disk/by-path/$(PICO) /dev/pico
	sudo mount /dev/pico /mnt/pico
	ls /mnt/pico

usb:
	ls -l /dev/disk/by-path/ | grep -e "pci-.*-usb-.*-scsi-.*-part1"
