#!/bin/bash

# Usage: ./setup.sh FLAMENCO_URL

set -xe

# Download the Flamenco addon
wget $1/flamenco3-addon.zip -O /tmp/flamenco.zip

# Launch Blender with the install script
blender -b -y --python-exit-code 1 --python-console << EOF
import bpy
bpy.ops.preferences.addon_install(filepath='/tmp/flamenco.zip')
bpy.ops.preferences.addon_enable(module='flamenco')
bpy.context.preferences.addons['flamenco'].preferences['manager_url'] = "$1"
bpy.ops.flamenco.ping_manager()
bpy.ops.wm.save_userpref()

EOF

set -e
echo "Addon installed, enabled and configured!"
