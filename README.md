# buildroot-s6: s6 Supervision for Embedded Devices

## Overview

[s6](http://skarnet.org/software/s6/) is small and secure supervision suite.
Its companion, [s6-rc](http://skarnet.org/software/s6-rc/) is a complete
service manager.

[buildroot](http://buildroot.org/) is a tool to generate embedded Linux systems.

buildroot-s6 allows the user to build a firmware for an embedded Linux device
using s6 and s6-rc as its init system instead of SysV or systemd.

Several predefined configurations to showcase s6 are provided:

- QEMU/x86
- Raspberry Pi

## How to Build a Firmware

### QEMU

In this configuration, all the programs are built using the
[GNU libc](https://www.gnu.org/software/libc/) and dynamically linked. To build
a firmware, execute:

```sh
$ make BR2_EXTERNAL=$PWD/custom O=$HOME/build/demo-s6/qemu/x86 -C buildroot demo_s6_qemu_x86_defconfig
$ make O=$HOME/build/demo-s6/qemu/x86 -C buildroot
```

Once the build is finished, the images for QEMU are available in
``$HOME/build/demo-s6/qemu/x86/images``.

### Raspberry Pi

In this configuration, all the programs are built using
[musl libc](http://www.musl-libc.org/) and statically linked. To build a
firmware, execute:

```sh
$ make BR2_EXTERNAL=$PWD/custom O=$HOME/build/demo-s6/rpi -C buildroot demo_s6_rpi_defconfig
$ make O=$HOME/build/demo-s6/rpi -C buildroot
```

Once the build is finished, the images for the SD card are available in
``$HOME/build/demo-s6/rpi/images``.
