/* 
 * helloworld.asm
 * (c) BillyRayValentine
 * Written for use with GNU AS
 */

/*
 * Everything kicks off here.  Must be at 0x200 
 */
.include "rom_header.asm"

cpu_entrypoint:
    jsr     tmss
    jsr     init_vdp

    * load the palette    
    move.l  #0xC0000000, VDP_CTRL_PORT
        
    lea     Palette0, a0
    moveq   #16-1, d0

1:  move.w  (a0)+, VDP_DATA_PORT
    dbra    d0, 1b

    * load 7 tiles (7*8-1)bytes
    * skip the first 32 bytes of VRAM so we have a blank tile
    move.l  #0x40200000, VDP_CTRL_PORT
    
    lea     Tiles, a0
    moveq   #56-1, d0

1:  move.l  (a0)+, VDP_DATA_PORT
    dbra    d0, 1b

    * Draw the tiles on plane A @0xC000
    move.l  #0x40000003, VDP_CTRL_PORT

    move.w  #0x001, VDP_DATA_PORT 
    move.w  #0x002, VDP_DATA_PORT 
    move.w  #0x003, VDP_DATA_PORT 
    move.w  #0x003, VDP_DATA_PORT 
    move.w  #0x004, VDP_DATA_PORT 
    move.w  #0x000, VDP_DATA_PORT 
    move.w  #0x005, VDP_DATA_PORT 
    move.w  #0x004, VDP_DATA_PORT 
    move.w  #0x006, VDP_DATA_PORT 
    move.w  #0x003, VDP_DATA_PORT 
    move.w  #0x007, VDP_DATA_PORT 

/*
 * Should never get past here
 */
forever:
    nop
    jmp     forever

.include "globals.asm"
.include "init_vdp.asm"
.include "tmss.asm"
.include "palletes.asm"

/* 
 * Interupt handlers 
 */
cpu_exception:
    rte
int_null:
    rte
int_hinterrupt:
    rte:
int_vinterrupt:
    rte:
rom_end:
