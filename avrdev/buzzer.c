#ifndef BUZZER_C
#define BUZZER_C

#include "common.c"
#include "recvr_defs.h"

#include <avr/io.h>


inline void EnableBuzzer(uint8_t enable)
{
    BPUT( BUZZ_DD, BUZZPIN, enable );
}

inline void Buzz(uint16_t ms)
{
    BSET( BUZZPORT, BUZZPIN );
    delayms(ms);
    BRESET( BUZZPORT, BUZZPIN );
}

#endif
