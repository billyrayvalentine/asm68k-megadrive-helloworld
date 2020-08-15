/*
 * helloworld.asm
 * (c) BillyRayValentine
 * Written for use with GNU AS
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

    lea     Palette0, a0
    moveq   #16-1, d0

1:  move.w  (a0)+, VDP_DATA_PORT
    dbra    d0, 1b

    * Load 7 "cells" (tiles) into the  (7*8-1) longwords
    * Skip the first 32 bytes of VRAM so we have a blank tile
    move.l  #0x40200000, VDP_CTRL_PORT

    lea     TilesLetters, a0
    moveq   #56-1, d0

1:  move.l  (a0)+, VDP_DATA_PORT
    dbra    d0, 1b

    * Load the bar tiles
    lea     TilesBar, a0
    moveq   #32-1, d0

1:  move.l  (a0)+, VDP_DATA_PORT
    dbra    d0, 1b

    * Update plane A table @ 0xC000
    move.l  #0x40000003, VDP_CTRL_PORT

    move.w  #0x001, VDP_DATA_PORT
    move.w  #0x002, VDP_DATA_PORT
    move.w  #0x003, VDP_DATA_PORT
    move.w  #0x003, VDP_DATA_PORT
    move.w  #0x004, VDP_DATA_PORT
    move.w  #0x000, VDP_DATA_PORT

    * Update plane table B @ 0xE000
    move.l  #0x60000003, VDP_CTRL_PORT

    move.w  #0x005, VDP_DATA_PORT
    move.w  #0x004, VDP_DATA_PORT
    move.w  #0x006, VDP_DATA_PORT
    move.w  #0x003, VDP_DATA_PORT
    move.w  #0x007, VDP_DATA_PORT

    * Load initial sprite table to 0xAB00
    move.l  #0x68000002, VDP_CTRL_PORT
    lea     BarSprite, a0
    move.l  (a0)+, VDP_DATA_PORT
    move.l  (a0)+, VDP_DATA_PORT

    * Set the initial X and Y positions
    move.w  #128, RAM_SPRITE_TARGET_X
    move.w  #128, RAM_SPRITE_TARGET_Y

    move.w  #128, d6 /* Counter for x  */
    move.w  #128, d7 /* Counter for y  */

    move.l  #0, d4 /* Counter for x scroll offset */
    move.l  #0, d5 /* Counter for y scroll offset */

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
    jsr read_controller_1

    * If right then move sprite right
    btst.b  #3, RAM_CONTROLLER_1
    beq 1f

    * Check the sprite is at the screen boundry, if so skip
    * Screen h
    cmpi.w  #320 + 128 - 32, RAM_SPRITE_TARGET_X
    beq 4f

    addi.w  #1, RAM_SPRITE_TARGET_X
    addi.w  #1, d6

    * If left then move sprite left
1:  btst.b  #2, RAM_CONTROLLER_1
    beq 2f

    * Check the sprite is at the screen boundry, if so skip
    cmpi.w  #0 + 128, RAM_SPRITE_TARGET_X
    beq 4f

    subi.w  #1, RAM_SPRITE_TARGET_X
    subi.w  #1, d6


    * If up then move the sprite up
2:  btst.b  #0, RAM_CONTROLLER_1
    beq 3f

    * check the sprite is at the screen boundry, if so skip
    cmpi.w  #0 + 128, RAM_SPRITE_TARGET_Y
    beq 4f

    subi.w  #1, RAM_SPRITE_TARGET_Y
    subi.w  #1, d7


    * If down then move the sprite down
3:  btst.b  #1, RAM_CONTROLLER_1
    beq 4f

    * Check the sprite is at the screen boundry, if so skip
    cmpi.w  #224 + 128 - 8, RAM_SPRITE_TARGET_Y
    beq 4f

    addi.w  #1, RAM_SPRITE_TARGET_Y
    addi.w  #1, d7


    * Update horizontal scroll table @ 0xAC00 and scroll plane A
    * If the offset is >320 (size of screen width) then reset to 0
4:  cmp.w   #320, d4
    bls.s   1f
    move.w  #0, d4

1:  move.l  #0x6C000002, VDP_CTRL_PORT
    move.w  d4, VDP_DATA_PORT

    * Update vertical scroll table which is in VSRAM
    * skip the first word as we want to scroll plane B
    cmp.w   #224, d5
    bls.s   1f
    move.w  #0, d5

1:  move.l  #0x40020010, VDP_CTRL_PORT
    move.w  d5, VDP_DATA_PORT

    add.w  #1, d4
    add.b  #1, d5

    jsr update_sprite_table
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

/*
 * Interupt handler
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
