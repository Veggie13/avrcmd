#ifndef MORSE_C
#define MORSE_C

#include "buzzer.c"


inline void Dit()
{
    Buzz(DIT_LEN);
    delayms(DIT_LEN);
}

inline void Dah()
{
    Buzz(3 * DIT_LEN);
    delayms(DIT_LEN);
}

inline void CharBreak()
{
    delayms(2 * DIT_LEN);
}

inline void WordBreak()
{
    delayms(6 * DIT_LEN);
}

void SpeakSymbol(uint8_t sym)
{
    switch (sym & 0x3)
    {
    default:
    case MORSE_WBK: WordBreak(); break;
    case MORSE_CBK: CharBreak(); break;
    case MORSE_DIT: Dit(); break;
    case MORSE_DAH: Dah(); break;
    }
}

static uchar* speakBuf = 0;
void Speak()
{
    //EnableBuzzer( TRUE );

    uint8_t i;
    for (i = 0; i < 64 && speakBuf[i] != 0; i++)
    {
        SpeakSymbol( speakBuf[i] >> 6 );
        SpeakSymbol( speakBuf[i] >> 4 );
        SpeakSymbol( speakBuf[i] >> 2 );
        SpeakSymbol( speakBuf[i] );
        speakBuf[i] = 0;
    }

    //EnableBuzzer( FALSE );
}

#endif
