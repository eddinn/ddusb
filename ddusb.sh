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
lsblk | grep -v -E 'loop|nvme|rom|lvm'

# Get the identifier from the user
printf -- '%s\n' ""
printf -- '%s\n' "Please enter the USB device identifier noted above (e.g sdf)"
printf "Identifier: "; read -r usb

# Check if we got any input and continue, exit if none
if [ -z "$usb" ]; then
  printf -- '%s\n' "Missing USB identifier, exiting!"
  exit 1
else
  # Validate the input /dev
  if ! find /dev/disk/by-id/ -lname "*$usb" | grep -c "/dev/disk/by-id/usb" > /dev/null 2>&1; then
    printf -- '%s\n' /dev/"$usb is not a valid USB target, aborting!"
    exit 1
  elif ! file /dev/"$usb" | grep -c "block special" > /dev/null 2>&1; then
    printf -- '%s\n' /dev/"$usb is not a valid target, aborting!"
    exit 1
  else
    # Show the input and ask for conformation
    printf -- '%s\n' ""
    printf -- '%s\n\n' "Please verify that all input is correct:"
    printf -- '%s\n' "ISO file: $1"
    printf -- '%s\n' "USB device: /dev/$usb"
    printf -- '%s\n\n' "dd will be: dd bs=4M if=$1 of=/dev/$usb status=progress oflag=sync"
    read -rp $'Is the input correct? [y/n]: ' -n1 key
    # Force y for yes or n for no
    while [[ $key != @(y|n) ]]; do
      printf -- '%s\n' ""
      printf -- '%s\n' "Please enter 'y' or 'n'"
      read -rp $'Is the input correct? [y/n]: ' -n1 key
    done
    # If y, go ahead, else if n, abort
    case "${key}" in
      (y)
        # All clear, go ahead and continue
        printf -- '%s\n' ""
        printf -- '%s\n' "Creating bootable USB of ISO $1 to USB device /dev/$usb"
        (dd bs=4M if="$1" of=/dev/"$usb" status=progress oflag=sync)
        printf -- '%s\n' ""
        printf -- '%s\n' "Done!"
        ;;
      (n)
        # Abort
        printf -- '%s\n' ""
        printf -- '%s\n' "Aborting!" >&2
        exit 1
        ;;
    esac
  fi
fi
