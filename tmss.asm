/*
 * tmss.asm
 * (c) BillyRayValentine
 * Written for use with GNU AS
*/
tmss:
    move.b  0xA10001, d0
    andi.b  #0x0F, d0               /* AND the last 4 bits, skip if 0 (Model 1) */
    beq     1f
    move.l  #SEGA_STRING, a1
    move.l  (a1), 0xA14000          /* Write 'SEGA' to 0xA14000 */
1:  rts
