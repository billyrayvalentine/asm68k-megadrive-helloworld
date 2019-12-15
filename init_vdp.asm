/* 
 * init_vdp.asm
 * (c) BillyRayValentine
 * Written for use with GNU AS
 * 
 * Initialise the VDP
 * https://www.plutiedev.com/vdp-setup 
 * https://www.plutiedev.com/vdp-registers
 * http://md.railgun.works/index.php/VDP
 */
init_vdp:
    /* 
     * Reset any VDP ops 
     */
    tst.w (VDP_CTRL_PORT)

    /* 
     * Setup all of the VDP registers 
     * Skip the unused ones
     */
    move.l  #VDP_CTRL_PORT, a0

    move.w  #VDP_REG_MODE1      | 0b00000100, (a0) /* 0x04 */
    move.w  #VDP_REG_MODE2      | 0b01110100, (a0) /* 0x74 */
    move.w  #VDP_REG_PLANEA     | 0b00110000, (a0) /* 0x30 0xC000*/
    move.w  #VDP_REG_WINDOW     | 0b10000000, (a0) /* 0x40 */
    move.w  #VDP_REG_PLANEB     | 0b00000111, (a0) /* 0x07 0xE000 */
    move.w  #VDP_REG_SPRITE     | 0b01111000, (a0) /* 0x78 0xF000 */
    move.w  #VDP_REG_BGCOL      | 0b00000000, (a0) 
    move.w  #VDP_REG_HRATE      | 0b00001000, (a0)
    move.w  #VDP_REG_MODE3      | 0b00000000, (a0)
    move.w  #VDP_REG_MODE4      | 0b10000001, (a0) /* 40 H40 mode */
    move.w  #VDP_REG_HSCROLL    | 0b00111111, (a0) /* 0x3F 0xFC00 */
    move.w  #VDP_REG_INCR       | 0b00000010, (a0) /* 0x02 */
    move.w  #VDP_REG_SIZE       | 0b00000001, (a0) /* 32x64 tiles */
    move.w  #VDP_REG_WINX       | 0b00000000, (a0) 
    move.w  #VDP_REG_WINY       | 0b00000000, (a0)
   
    rts
