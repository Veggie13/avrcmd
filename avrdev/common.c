#ifndef COMMON_C
#define COMMON_C

#include "vs_avr.h"
#include "defs.h"
#include <util/delay.h>

inline void delayms(uint16_t t)//delay in ms
{
    uint16_t i;
    for(i=0;i<t;i++)
	    _delay_ms(1);
}

inline void delay_s(uint8_t t)
{
    uint8_t i;
    for(i=0;i<t;i++)
    {
        delayms(1000);
    }
}

#endif
