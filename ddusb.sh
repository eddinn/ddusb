#!/usr/bin/env bash

# Check arguments, exit if none
if [ $# -eq 0 ]; then
  printf -- '%s\n\n' "Missing full path to the ISO" >&2
  printf -- '%s\n\n' "Usage: sudo ./ddusb.sh /path/to/some.iso" >&2
  exit 1
fi

# Run as root with sudo
if (( EUID != 0 )); then
  printf -- '%s\n' "This script must be run with 'root' privileges, e.g 'sudo'" >&2
  exit 1
fi

# Run lsblk and find the USB identifier 
printf -- '%s\n' "Identify the USB device:"
lsblk | grep "sd"

# Get the identifier from the user
printf -- '%s\n' ""
printf -- '%s\n' "Please enter the USB device identifier noted above with full path (e.g /dev/sdf)"
printf "Identifier: "; read -r usb

# Check if we got any input and continue, exit if none
if [ -z "$usb" ]; then
  printf -- '%s\n' "Missing USB identifier, exiting!"
  exit 1
else
  if ! file "$usb" | grep -c "block special" > /dev/null 2>&1; then
    printf -- '%s\n' "$usb is not a valid target, aborting!"
    exit 1
  else
    printf -- '%s\n' ""
    printf -- '%s\n\n' "Please verify that all input is correct:"
    printf -- '%s\n' "ISO file: $1"
    printf -- '%s\n' "USB device: $usb"
    printf -- '%s\n\n' "dd will be: dd bs=4M if=$1 of=$usb status=progress oflag=sync"
    read -rp $'Is the input correct? [y/n]: ' -n1 key
    while [[ $key != @(y|n) ]]; do
      printf -- '%s\n' ""
      printf -- '%s\n' "Please enter 'y' or 'n'"
      read -rp $'Is the input correct? [y/n]: ' -n1 key
    done
    case "${key}" in
      (y)
        printf -- '%s\n' ""
        printf -- '%s\n' "Creating bootable USB of ISO $1 to USB device $usb"
        (dd bs=4M if="$1" of="$usb" status=progress oflag=sync)
        printf -- '%s\n' ""
        printf -- '%s\n' "Done!"
        ;;
      (n)
        printf -- '%s\n' ""
        printf -- '%s\n' "Aborting!" >&2
        exit 1
        ;;
    esac
  fi
fi
