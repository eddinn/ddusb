# ddusb

Simple script to create a bootable usb from iso with `dd`

## Usage

```shell
# Find your USB
lsblk

# Sample output
NAME                MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
## output omitted ##
sda                   8:0    1   7,5G  0 disk
├─sda1                8:1    1   2,3G  0 part /media/username/Ubuntu 19.10 amd64
├─sda2                8:2    1   3,9M  0 part
└─sda3                8:3    1   5,2G  0 part /media/username/casper-rw
## output omitted ##

# There we see that our USB device is on /dev/sda, so we use that
sudo ./ddusb.sh /home/username/Downloads/some.iso /dev/sda
```
