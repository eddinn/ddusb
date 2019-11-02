#!/usr/bin/env bash

# Check arguments, exit if none
if [ $# -eq 0 ]; then
  printf -- '%s\n' "Missing full path to the ISO" >&2
  printf -- '%s\n' "Usage: sudo ./ddusb.sh /path/to/some.iso" >&2
  exit 1
fi

# Run as root with sudo
if (( EUID != 0 )); then
  printf -- '%s\n' "This script must be run with 'root' privileges, e.g 'sudo'" >&2
  exit 1
fi

# Run lsblk and find the USB identifier 
printf -- '%s\n' "Identify the USB device"
lsblk | grep "sd"

# Get the identifier from the user
printf -- '%s\n' ""
printf -- '%s\n' "Please enter the USB dev identifier noted above (e.g sda)"
printf "Identifier: "; read -r usb

# Check if we got any input and continue, exit if none
if [ -z "$usb" ]; then
  printf -- '%s\n' ""
  printf -- '%s\n' "Missing USB identifier, exiting!"
  exit 1
else
  printf -- '%s\n' ""
  printf -- '%s\n' "Creating bootable USB of ISO $1 to USB device /dev/$usb"
  (dd bs=4M if="$1" of=/dev/"$usb" status=progress oflag=sync)
fi
