/* 
 * rom_header.asm 
 * (c) BillyRayValentine
 * 
 * Written for use with GNU AS
 * Vector table with interupts - Thanks to Big Evil Corporation for this and
 * most of what is in this file
 * https://github.com/BigEvilCorporation
*/
rom_start:
    dc.l   0x00FFE000           /* Initial stack pointer value */
    dc.l   cpu_entrypoint       /* Start of program */
    dc.l   cpu_exception        /* Bus error */
    dc.l   cpu_exception        /* Address error */
    dc.l   cpu_exception        /* Illegal instruction */
    dc.l   cpu_exception        /* Division by zero */
    dc.l   cpu_exception        /* CHK cpu_exception */
    dc.l   cpu_exception        /* TRAPV cpu_exception */
    dc.l   cpu_exception        /* Privilege violation */
    dc.l   int_null             /* TRACE exception */
    dc.l   int_null             /* Line-A emulator */
    dc.l   int_null             /* Line-F emulator */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Spurious exception */
    dc.l   int_null             /* IRQ level 1 */
    dc.l   int_null             /* IRQ level 2 */
    dc.l   int_null             /* IRQ level 3 */
    dc.l   int_hinterrupt       /* IRQ level 4 (horizontal retrace interrupt) */
    dc.l   int_null             /* IRQ level 5 */
    dc.l   int_vinterrupt       /* IRQ level 6 (vertical retrace interrupt) */
    dc.l   int_null             /* IRQ level 7 */
    dc.l   int_null             /* TRAP #00 exception */
    dc.l   int_null             /* TRAP #01 exception */
    dc.l   int_null             /* TRAP #02 exception */
    dc.l   int_null             /* TRAP #03 exception */
    dc.l   int_null             /* TRAP #04 exception */
    dc.l   int_null             /* TRAP #05 exception */
    dc.l   int_null             /* TRAP #06 exception */
    dc.l   int_null             /* TRAP #07 exception */
    dc.l   int_null             /* TRAP #08 exception */
    dc.l   int_null             /* TRAP #09 exception */
    dc.l   int_null             /* TRAP #10 exception */
    dc.l   int_null             /* TRAP #11 exception */
    dc.l   int_null             /* TRAP #12 exception */
    dc.l   int_null             /* TRAP #13 exception */
    dc.l   int_null             /* TRAP #14 exception */
    dc.l   int_null             /* TRAP #15 exception */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
    dc.l   int_null             /* Unused (reserved) */
/* 
 * ROM Header - Explained really well here https://www.plutiedev.com/rom-header 
 * For some reason GNU AS won't do dc.b 'STRING' so we have to use .ascii "string"
*/
    .ascii  "SEGA MEGA DRIVE "                                 /* Console name */
    .ascii  "BillyRay        "                                 /* Copyright holder and release date */
    .ascii  "HELLO WORLD                                     " /* Domestic name */
    .ascii  "HELLO WORLD                                     " /* International name */
    .ascii  "GM XXXXXXXX-XX"                                   /* Version number */
    dc.w    0x0000                                             /* Checksum */
    .ascii  "J               "                                 /* I/O support */
    dc.l    rom_start                                          /* Start address of ROM */
    dc.l    rom_end-1                                          /* End address of ROM */
    dc.l    0x00FF0000                                         /* Start address of RAM */
    dc.l    0x00FF0000+0x0000FFFF                              /* End address of RAM */
    dc.l    0x00000000                                         /* SRAM enabled */
    dc.l    0x00000000                                         /* Unused */
    dc.l    0x00000000                                         /* Start address of SRAM */
    dc.l    0x00000000                                         /* End address of SRAM */
    dc.l    0x00000000                                         /* Unused */
    dc.l    0x00000000                                         /* Unused */
    .ascii  "                                        "         /* Notes (unused) */
    .ascii  "JUE             "                                 /* Country codes */
