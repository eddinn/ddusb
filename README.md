# ddusb

Simple script to create a bootable usb from iso with `dd`

## Usage

```shell
sudo ./ddusb.sh /path/to/some.iso
```

### Sample output

```shell
Identify the USB device
sda                   8:0    1   7,5G  0 disk
├─sda1                8:1    1   2,3G  0 part /media/edvin/Ubuntu 19.10 amd64
├─sda2                8:2    1   3,9M  0 part
└─sda3                8:3    1   5,2G  0 part /media/edvin/casper-rw

Please enter the USB dev identifier noted above (e.g sda)
sda

Creating bootable USB of ISO /home/username/Downloads/pop-os_19.10_amd64_nvidia_9.iso to USB device /dev/sda
```
