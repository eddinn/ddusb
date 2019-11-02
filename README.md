# ddusb

Simple script to create a bootable usb from iso with `dd`

If you are like me, can't remember the dd command to create a bootable USB and always have to google it again, then this is handy to have..

## Usage

```shell
sudo ./ddusb.sh /path/to/some.iso
```

### Sample output

```shell
Identify the USB disk device
sdf                   8:0    1   7,5G  0 disk
├─sdf1                8:1    1   2,3G  0 part /media/username/Ubuntu 19.10 amd64
├─sdf2                8:2    1   3,9M  0 part
└─sdf3                8:3    1   5,2G  0 part /media/username/casper-rw

Please enter the USB disk identifier noted above (e.g sdf)
Identifier: sdf

Creating bootable USB of ISO /home/username/Downloads/pop-os_19.10_amd64_nvidia_9.iso to USB device /dev/sdf
```
