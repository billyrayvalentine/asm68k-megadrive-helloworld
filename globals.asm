/*
 * globals.asm
 * Written for use with GNU AS

 * Copyright © 2020 Ben Sampson <github.com/billyrayvalentine>
 * This work is free. You can redistribute it and/or modify it under the
 * terms of the Do What The Fuck You Want To Public License, Version 2,
 * as published by Sam Hocevar. See the COPYING file for more details.
 *
 * Globals
*/
SEGA_STRING: .ascii "SEGA"

* VDP Registers
VDP_CTRL_PORT = 0xC00004
VDP_DATA_PORT = 0xC00000

VDP_REG_MODE1 = 0x8000
VDP_REG_MODE2 = 0x8100
VDP_REG_MODE3 = 0x8B00
VDP_REG_MODE4 = 0x8C00

VDP_REG_PLANEA = 0x8200
VDP_REG_PLANEB = 0x8400
VDP_REG_SPRITE = 0x8500
VDP_REG_WINDOW  = 0x8300
VDP_REG_HSCROLL = 0x8D00

VDP_REG_SIZE = 0x9000
VDP_REG_WINX = 0x9100
VDP_REG_WINY = 0x9200
VDP_REG_INCR = 0x8F00
VDP_REG_BGCOL = 0x8700
VDP_REG_H_INT = 0x8A00

* IO
IO_CTRL_PORT1 = 0xA10009
IO_DATA_PORT1 = 0xA10003

* RAM
RAM_CONTROLLER_1 = 0xFF0000
RAM_CONTROLLER_2 = 0xFF0001

RAM_SPRITE_TARGET_X = 0xFF0002
RAM_SPRITE_TARGET_Y = 0xFF0004
