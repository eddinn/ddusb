#!/usr/bin/env bash

# Check arguments, exit if none
if [ $# -eq 0 ]; then
  printf -- '%s\n' "Usage: sudo ./ddusb.sh /path/to/iso /dev/usbhdd #(e.g /dev/sda)" >&2
fi

# Run as root with sudo
if (( EUID != 0 )); then
  printf -- '%s\n' "This script must be run with 'root' privileges, e.g 'sudo'" >&2
  exit 1
fi

printf -- '%s\n' "Creating bootable USB of ISO $1 to USB device $2"
dd bs=4M if="$1" of="$2" status=progress oflag=sync
