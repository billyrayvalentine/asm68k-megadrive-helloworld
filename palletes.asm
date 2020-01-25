BarSprite:
    .word 0x00ad
    .byte 0b1100 /* 1x4 */
    .byte 0x00  
    .byte 0x00 
    .byte 0x08
    .word 0x0080

Palette0:
   .word 0x0000
   .word 0x0481 
   .word 0x00E0 
   .word 0x0E00 
   .word 0x0000 
   .word 0x0EEE
   .word 0x00EE
   .word 0x008E
   .word 0x0E0E
   .word 0x0808
   .word 0x0444
   .word 0x0888
   .word 0x0EE0
   .word 0x000A
   .word 0x0600
   .word 0x0060

TilesLetters:
    .long 0x11000110
    .long 0x11000110
    .long 0x11000110
    .long 0x11111110
    .long 0x11111110
    .long 0x11000110
    .long 0x11000110
    .long 0x11000110

    .long 0x11111110
    .long 0x11111110
    .long 0x10000000
    .long 0x11111110
    .long 0x11111100
    .long 0x10000000
    .long 0x11111110
    .long 0x11111110

    .long 0x11000000
    .long 0x11000000
    .long 0x11000000
    .long 0x11000000
    .long 0x11000000
    .long 0x11000000
    .long 0x11111110
    .long 0x11111110
    
    .long 0x01111100
    .long 0x11111110
    .long 0x11000110
    .long 0x11000110
    .long 0x11000110
    .long 0x11000110
    .long 0x11111110
    .long 0x01111100

    .long 0x11000110 
    .long 0x11000110
    .long 0x11000110
    .long 0x11000110
    .long 0x11010110
    .long 0x11101110
    .long 0x11101110
    .long 0x11000110

    .long 0x11111100
    .long 0x11000110
    .long 0x11001100
    .long 0x11111100
    .long 0x11001110
    .long 0x11000110
    .long 0x11000110
    .long 0x11000110

    .long 0x11111100
    .long 0x11000110
    .long 0x11000110
    .long 0x11000110
    .long 0x11000110
    .long 0x11000110
    .long 0x11111110
    .long 0x11111100

TilesBar:
    .long 0x11111111
    .long 0x11111111
    .long 0x11222222
    .long 0x11222222
    .long 0x11222222
    .long 0x11222222
    .long 0x11111111
    .long 0x11111111

    .long 0x11111111
    .long 0x11111111
    .long 0x22222222
    .long 0x22222222
    .long 0x22222222
    .long 0x22222222
    .long 0x11111111
    .long 0x11111111

    .long 0x11111111
    .long 0x11111111
    .long 0x22222222
    .long 0x22222222
    .long 0x22222222
    .long 0x22222222
    .long 0x11111111
    .long 0x11111111
    
    .long 0x11111111
    .long 0x11111111
    .long 0x22222211
    .long 0x22222211
    .long 0x22222211
    .long 0x22222211
    .long 0x11111111
    .long 0x11111111
