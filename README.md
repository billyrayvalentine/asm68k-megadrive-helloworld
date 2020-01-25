# asm68k-megadrive-helloworld
A simple hello world like project to get up and running with megadrive/genesis
development

* Prints "Hello" to plane A
* Prints "World" to plane B
* Creates a sprite which can be moved with the joypad
* Scroll plane A horizontally
* Scroll plane B vertically

I've used GNU AS (GAS) as a matter of preference for open-source tools

# Installing GNU AS m68k assembler 
Luckily, openSUSE has a pre-compiled m68k bintools package which works great
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

Use ```make``` to build the rom

# Calculating the command to access the VDP
It's a shame this is so complicated.  IMHO this is not explained particularly
well anywhere.  Since most people seem to use a macro to calculate the command
which I couldn't get work in GNU AS (gas) I had to calculate the command
manually.  Annoyingly this http://www.hacking-cult.org/?vdp actually yields the
wrong result.

In a nutshell, once you know the address in the VDP you want to write this can
be calculated quite simply.  Knowing what address you want to write to was a bit
lost on me until I read fully the sega2.doc. http://xi6.com/files/sega2f.html
and https://www.emu-docs.org/Genesis/Graphics/genvdp.txt

In a nutshell: 
* the VDP RAM is 65535 bytes in size (64kb)
* "Cells" (tiles) should be written to the beginning of the RAM space 
* Tiles are 32bytes in size
* You should create a blank tile at the beginning of VDP RAM 
* Background layers and sprites are built from these tiles
* Backgrounds and sprites are defined in tables, the addresses of these you must
specify in the VDP registers 
* You then work out the command to write to these tables (or to add tiles in RAM)

## Example
To add an entry to the sprite table which has been has been set as address
0xA800 in VRAM in the "Sprite Attribute Table Base register" the command can be calculated as
follows:

```
python -c "print(hex((0xA800 & 0x3fff) << 16 | (0xA800 & 0xC000) >> 14 |
0x40000000))"
```

which yields ```0x68000002```

So I simple use:
``` 
move.l  #0x68000002, VDP_CTRL_PORT
```

# References and thanks to:
[https://blog.bigevilcorporation.co.uk/2012/03/01/sega-megadrive-2-so-assembly-language-then/]

[https://huguesjohnson.com/programming/]

[https://www.plutiedev.com/]

[https://darkdust.net/writings/megadrive/firststeps]

[https://segaretro.org/Sega_Mega_Drive/Scrolling]

[http://md.railgun.works/index.php?title=VDP]

[https://jakobschmid.tumblr.com/]

[https://cdry.wordpress.com/2017/01/08/a-blast-from-the-past-toc/]

[https://megacatstudios.com/blogs/press/sega-genesis-mega-drive-vdp-graphics-guide-v1-2a-03-14-17]
