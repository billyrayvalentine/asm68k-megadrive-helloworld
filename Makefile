AS	= /usr/bin/m68k-suse-linux-as
LD	= /usr/bin/m68k-suse-linux-ld
ASFLAGS = -m68000 --register-prefix-optional 
LDFLAGS = -O1 -static -nostdlib  
LDFLAGS = -static -nostdlib  

OBJS=helloworld.o 

ROM = helloworld
BIN	= $(ROM).bin

all:	 $(BIN)

clean:
	rm *.{o,bin}

$(BIN): $(OBJS)
	$(LD) $(LDFLAGS) $< --oformat binary -o $@

%.o: %.asm 
	$(AS) $(ASFLAGS) --bitwise-or $< -o $@
