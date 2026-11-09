#!/bin/bash
set -euxo pipefail

BOOT_DIR="${RUGIX_LAYER_DIR}/roots/boot"
mkdir -p "${BOOT_DIR}"
cat <<EOT >> "${BOOT_DIR}/config.txt"
dtparam=i2c_arm=on
EOT

# udev rule to restrict access to i2c bus
install -D -m 644 "${RECIPE_DIR}/files/99-i2c-restrict.rules" -t /usr/lib/udev/rules.d/

# Allow tedge user to access the tpm
groupadd -f i2c
usermod -a -G i2c tedge

# Used fixed uid/gid to avoid permission issues across A/B updates
groupmod -g "$RECIPE_PARAM_I2C_GROUP_ID" i2c
