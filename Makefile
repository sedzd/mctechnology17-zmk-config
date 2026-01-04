# =========================================
# FileName: Makefile
# Editor: SED
# Brief: Makefile for ZMK firmware with Docker
# Targets: nice_nano_v2 Corne
# =========================================
#
#                             ╔═══╗╔═══╗╔══╗
#                             ║╔══╝║╠══╝║║ ╚╗
#                             ╚══╗ ║╠══╝║║ ║║
#                             ╔══╝ ║╠══╝║║ ╔╝
#                             ╚═══╝╚═══╝╚══╝
#

config=${PWD}/config
nice_mount=/Volumes/NICENANO
zmk_image=zmkfirmware/zmk-dev-arm:3.5
board=nice_nano_v2
urob_name=zmk-codebase_urob

docker_opts= \
	--interactive \
	--tty \
	--name ${urob_name} \
	--workdir /zmk \
	--volume "${config}:/zmk-config:Z" \
	--volume "${PWD}/zmk:/zmk:Z" \
	--volume "${PWD}/boards:/boards:Z" \
	${zmk_image}

west_build=west build /zmk/app --pristine --board "${board}"
extra_args=-DCONFIG_ZMK_KEYBOARD_NAME=\"Nice_Corne_View\" -DZMK_EXTRA_MODULES="/boards" -DZMK_CONFIG="/zmk-config"

.PHONY: all left right reset flash_left flash_right clean shell

all: left right reset

left:
	docker run --rm ${docker_opts} ${west_build} -- -DSHIELD="corne_left nice_view_adapter nice_view" ${extra_args}
	docker cp ${urob_name}:/zmk/build/zephyr/zmk.uf2 firmware/nice_corne_left_view.uf2

right:
	docker run --rm ${docker_opts} ${west_build} -- -DSHIELD="corne_right nice_view_adapter nice_view" ${extra_args}
	docker cp ${urob_name}:/zmk/build/zephyr/zmk.uf2 firmware/nice_corne_right_view.uf2

reset:
	docker run --rm ${docker_opts} ${west_build} -- -DSHIELD="settings_reset" -DZMK_CONFIG="/zmk-config"
	docker cp ${urob_name}:/zmk/build/zephyr/zmk.uf2 firmware/nice_settings_reset.uf2

flash_left:
	@ printf "Waiting for ${board} bootloader to appear at ${nice_mount}.."
	@ while [ ! -d ${nice_mount} ]; do sleep 1; printf "."; done; printf "\n"
	cp -av firmware/nice_corne_left_view.uf2 ${nice_mount}

flash_right:
	@ printf "Waiting for ${board} bootloader to appear at ${nice_mount}.."
	@ while [ ! -d ${nice_mount} ]; do sleep 1; printf "."; done; printf "\n"
	cp -av firmware/nice_corne_right_view.uf2 ${nice_mount}

shell:
	docker run --rm ${docker_opts} /bin/bash

clean:
	rm -f firmware/*.uf2
	docker rm -f ${urob_name} || true
