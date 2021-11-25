#!/bin/bash

# symlink this to any electron 12 and up app that should be using electron

exec "/usr/bin/$(basename "${0}")" --enable-features=UseOzonePlatform --ozone-platform=wayland $@
