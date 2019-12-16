# asm68k-megadrive-helloworld
A simple hello world like project to get up and running with megadrive/genesis
development

Prints "Hello World" to the screen using tiles

Big thanks to [https://blog.bigevilcorporation.co.uk/] whose excellent blog
opened this rabbit hole for me.

I've used GNU AS (GAS) as a matter of preference for opensource tools

# Installing GNU AS m68k assembler 
Luckily, OpenSuSE has a pre-compiled m68k bintools package which works great
e.g. 

```zypper in cross-m68k-binutils```

This gives you

```
/usr/bin/m68k-suse-linux-addr2line
/usr/bin/m68k-suse-linux-ar
/usr/bin/m68k-suse-linux-as
/usr/bin/m68k-suse-linux-elfedit
/usr/bin/m68k-suse-linux-gprof
/usr/bin/m68k-suse-linux-ld
/usr/bin/m68k-suse-linux-ld.bfd
/usr/bin/m68k-suse-linux-nm
/usr/bin/m68k-suse-linux-objcopy
/usr/bin/m68k-suse-linux-objdump
/usr/bin/m68k-suse-linux-ranlib
/usr/bin/m68k-suse-linux-readelf
/usr/bin/m68k-suse-linux-size
/usr/bin/m68k-suse-linux-strings
/usr/bin/m68k-suse-linux-strip
```
Nice.

Use make to build the rom
