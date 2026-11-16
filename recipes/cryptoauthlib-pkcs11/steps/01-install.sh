#!/bin/sh
set -e

# Persist config
install -D -m 644 "${RECIPE_DIR}/files/cryptoauthlib.toml" -t /etc/rugix/state
