/*
 * init_vdp.asm
 * Written for use with GNU AS
 *
 * Copyright © 2020 Ben Sampson <github.com/billyrayvalentine>
 * This work is free. You can redistribute it and/or modify it under the
 * terms of the Do What The Fuck You Want To Public License, Version 2,
 * as published by Sam Hocevar. See the COPYING file for more details.
 *
 * Initialise the VDP
 * https://www.plutiedev.com/vdp-setup
 * https://www.plutiedev.com/vdp-registers
 * http://md.railgun.works/index.php/VDP
 * Use the address layout in http://xi6.com/files/sega2f.html section 5
 * for VRAM mapping (H40 mode)
*/
init_vdp:
    * Reset any VDP ops
    tst.w (VDP_CTRL_PORT)

    * Setup all of the VDP registers
    * Skip the unused ones
    move.l  #VDP_CTRL_PORT, a0

    move.w  #VDP_REG_MODE1      | 0b00000100, (a0) /* 0x04 */
    move.w  #VDP_REG_MODE2      | 0b01110100, (a0) /* 0x74 */
    move.w  #VDP_REG_PLANEA     | 0x30, (a0) /* 0xC000 */
    move.w  #VDP_REG_WINDOW     | 0x2c, (a0) /* 0xB000 */
    move.w  #VDP_REG_PLANEB     | 0x07, (a0) /* 0xE000 */
    move.w  #VDP_REG_SPRITE     | 0x54, (a0) /* 0xA800 */
    move.w  #VDP_REG_BGCOL      | 0b00000000, (a0)
    move.w  #VDP_REG_H_INT      | 0b00001000, (a0)
    move.w  #VDP_REG_MODE3      | 0b00000000, (a0)
    move.w  #VDP_REG_MODE4      | 0b00000000, (a0) /* 40 H40 mode */
    move.w  #VDP_REG_HSCROLL    | 0x2b, (a0) /* 0xAC00 */
    move.w  #VDP_REG_INCR       | 0b00000010, (a0) /* 0x02 */
    move.w  #VDP_REG_SIZE       | 0b00000000, (a0) /* 32x64 tiles */
    move.w  #VDP_REG_WINX       | 0b00000000, (a0)
    move.w  #VDP_REG_WINY       | 0b00000000, (a0)

    rts
