# ddusb

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/0b397dc236764aafb557dbd0f0a447f4)](https://www.codacy.com/manual/git_35/ddusb?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=eddinn/ddusb&amp;utm_campaign=Badge_Grade)

Simple script to create a bootable usb from iso with `dd`

If you are like me, can't remember the dd command to create a bootable USB and always have to google it again, then this is handy to have..

## Usage

```shell
sudo ./ddusb.sh /path/to/some.iso
```

### Sample output

```shell
Identify the USB device:
sdf                   8:0    1   7,5G  0 disk
├─sdf1                8:1    1   2,3G  0 part /media/username/Ubuntu 19.10 amd64
├─sdf2                8:2    1   3,9M  0 part
└─sdf3                8:3    1   5,2G  0 part /media/username/casper-rw

Please enter the USB device identifier noted above (e.g sdf)
Identifier: sdf

Please verify that all input is correct:

ISO file: /path/to/some.iso
USB device: /dev/sdf
dd will be: dd bs=4M if=/path/to/some.iso of=/dev/sdf status=progress oflag=sync

Is the input correct? [y/n]: y

Creating bootable USB of ISO /path/to/some.iso to USB device /dev/sdf
2535194624 bytes (2,5 GB, 2,4 GiB) copied, 415 s, 6,1 MB/s
604+1 records in
604+1 records out
2535194624 bytes (2,5 GB, 2,4 GiB) copied, 415,021 s, 6,1 MB/s

Done!
```
