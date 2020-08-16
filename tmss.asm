/*
 * tmss.asm
 * Written for use with GNU AS

 * Copyright © 2020 Ben Sampson <github.com/billyrayvalentine>
 * This work is free. You can redistribute it and/or modify it under the
 * terms of the Do What The Fuck You Want To Public License, Version 2,
 * as published by Sam Hocevar. See the COPYING file for more details.
*/
tmss:
    move.b  0xA10001, d0
    andi.b  #0x0F, d0               /* AND the last 4 bits, skip if 0 (Model 1) */
    beq     1f
    move.l  #SEGA_STRING, a1
    move.l  (a1), 0xA14000          /* Write 'SEGA' to 0xA14000 */
1:  rts
