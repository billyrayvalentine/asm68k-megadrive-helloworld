/*
 * helloworld.asm
 * Written for use with GNU AS

 * Copyright © 2020 Ben Sampson <github.com/billyrayvalentine>
 * This work is free. You can redistribute it and/or modify it under the
 * terms of the Do What The Fuck You Want To Public License, Version 2,
 * as published by Sam Hocevar. See the COPYING file for more details.
*/

* Everything kicks off here.  Must be at 0x200
.include "rom_header.asm"

cpu_entrypoint:
    * Setup the TMSS stuff
    jsr     tmss

    * Initialise joypad 1
    move.b  #0x40, IO_CTRL_PORT1
    move.b  #0x40, IO_DATA_PORT1

    * Setup the VDP registers
    jsr     init_vdp

    * All the commands to send to the control port can be worked out using the
    * example in the README

    * Load the palette into CRAM
    move.l  #0xC0000000, VDP_CTRL_PORT

    lea     CMPalette0, a0
    moveq   #16-1, d0

1:  move.w  (a0)+, VDP_DATA_PORT
    dbra    d0, 1b

    * Load 7 "cells" (tiles) into the  (7*8-1) longwords
    * Skip the first 32 bytes of VRAM so we have a blank tile
    move.l  #0x40200000, VDP_CTRL_PORT

    * Load the bar tiles
    lea     CMImage0, a0
    move.w   #5120-1, d0

1:  move.l  (a0)+, VDP_DATA_PORT
    dbra    d0, 1b


    * Update plane table B @ 0xE000
    move.l  #0x60000003, VDP_CTRL_PORT

    * load 640 tiles
    move.w  #0x0000, d1
1:  move.w  d1, VDP_DATA_PORT
    addq    #1, d1
    cmpi.w  #640, d1
    bne     1b



/*
 * Main loop
 * Wait for the VBLANK to start
 * Get the input for the joy pad
 * Move the sprite and the scroll planes
 * Wait for the VBLANK to end
 *
 * Joypad values and sprite positions are kept in RAM
*/
forever:

    jsr wait_vblank_start
    jsr wait_vblank_end
    jmp forever

update_sprite_table:
    * Update sprite table
    move.l  #0x68000002, VDP_CTRL_PORT
    move.w  RAM_SPRITE_TARGET_Y, VDP_DATA_PORT
    move.w  #0x0C00, VDP_DATA_PORT
    move.w  #0x0008, VDP_DATA_PORT
    move.w  RAM_SPRITE_TARGET_X, VDP_DATA_PORT
    rts

read_controller_1:
    * Read controller 1 input into $FF0000
    move.l  #IO_DATA_PORT1, a0
    move.b  #0x40, (a0)
    nop
    nop
    move.b  (a0), d0

    move.b  #0x00, (a0)
    nop
    nop
    move.b  (a0), d1

    andi.b  #0x3f, d0
    andi.b  #0x30, d1
    lsl.b   #2, d1
    or.b    d1, d0

    * NOT The bits so that that we have SACBRLDU
    * and a 1 rather than 0 when the bit is set
    * Finally write the value to RAM
    not    d0
    move.b d0, RAM_CONTROLLER_1
    rts

wait_vblank_start:
    * Bit 4 of the VDP register is set to 1 when the vblanking is in progress
    * Keep looping until this is set
    * The VDP register can be read simply by reading from the control port
    * address
    move.w  VDP_CTRL_PORT, d0
    btst.b  #4-1, d0
    beq     wait_vblank_start
    rts

wait_vblank_end:
    * Similar to wait_vblank_start but the inverse
    move.w  VDP_CTRL_PORT, d0
    btst.b  #4-1, d0
    bne     wait_vblank_end
    rts

.include "globals.asm"
.include "init_vdp.asm"
.include "tmss.asm"
.include "palletes.asm"
.include "brhead24.asm"
.include "compass.asm"

/*
 * Interrupt handler
*/
cpu_exception:
    rte
int_null:
    rte
int_hinterrupt:
    rte
int_vinterrupt:
    rte
rom_end:
