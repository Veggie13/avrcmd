#ifdef __AVR_VISUAL_STUDIO

#define __AVR_ATmega48P__

#define __asm__ __asm

#undef PROGMEM
#define PROGMEM

#undef pgm_read_word(x)
#define pgm_read_word(x) 0

#define __attribute__(...)

#endif
