ARGS =
OUTHEX = $(OUTNAME).hex
OUTELF = $(OUTNAME).elf
OUTOBJ = $(OUTNAME).o
OUTASM = $(OUTNAME).ss
OUTPRP = $(OUTNAME).e
MOREOBJ =

# WinAVR cross-compiler toolchain is used here
CC = avr-gcc
OBJCOPY = avr-objcopy
DUDE = avrdude

# If you are not using ATtiny2313 and the USBtiny programmer, 
# update the lines below to match your configuration
CFLAGS = -Wall -Os -mmcu=atmega48a
OBJFLAGS = -j .text -j .data -O ihex
DUDEFLAGS = -p m48 -c usbtiny -v

# Object files for the firmware (usbdrv/oddebug.o not strictly needed I think)
# OBJECTS = usbdrv/usbdrv.o usbdrv/oddebug.o usbdrv/usbdrvasm.o main.o
OBJECTS = $(OUTOBJ) $(MOREOBJ)

# Command-line client
CMDLINE = usbtest.exe

# By default, build the firmware and command-line client, but do not flash
all: $(OUTHEX) $(CMDLINE)

# With this, you can flash the firmware by just typing "make flash" on command-line
flash: $(OUTHEX)
	$(DUDE) $(DUDEFLAGS) -U flash:w:$<

# One-liner to compile the command-line client from usbtest.c
$(CMDLINE): usbtest.c
	gcc -I ./libusb/include -L ./libusb/lib/gcc -O -Wall usbtest.c -o usbtest.exe -lusb

# Housekeeping if you want it
clean:
	$(RM) *.o *.hex *.elf usbdrv/*.o

# From .elf file to .hex
%.hex: %.elf
	$(OBJCOPY) $(OBJFLAGS) $< $@

# Main.elf requires additional objects to the firmware, not just main.o
$(OUTELF): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@

# Without this dependance, .o files will not be recompiled if you change 
# the config! I spent a few hours debugging because of this...
$(OBJECTS): usbdrv/usbconfig.h

%.e: %.c
	$(CC) $(CFLAGS) $(ARGS) -E -c $< -o $@

%.ss: %.c
	$(CC) $(CFLAGS) $(ARGS) -S -c $< -o $@

# From C source to .o object file
%.o: %.c	
	$(CC) $(CFLAGS) $(ARGS) -c $< -o $@

# From assembler source to .o object file
%.o: %.S
	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@