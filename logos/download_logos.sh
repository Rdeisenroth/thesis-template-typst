#!/usr/bin/env sh
set -eu

SCRIPT_DIR=`dirname "$(realpath "$0")"`
docker build -f "$SCRIPT_DIR/../.github/Dockerfile.logo" -o "$SCRIPT_DIR" "$SCRIPT_DIR"
