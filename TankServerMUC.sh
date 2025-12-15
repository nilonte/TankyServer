#!/bin/sh
printf '\033c\033]0;%s\a' TankServerMUC
base_path="$(dirname "$(realpath "$0")")"
"$base_path/TankServerMUC.x86_64" "$@"
