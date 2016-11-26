#include "common.c"

#include <avr/io.h>
#include <avr/interrupt.h>

#include "recvr_defs.h"


static uchar* otherBuf = 0;
volatile uchar bufCur = 0;
volatile uchar bufStart = 0;

static uchar DebouncedKeyPress = 0;
volatile uchar KeyChanged = 0;
volatile uchar KeyPressed = 0;


inline uchar get_key_press()
{
    uchar result;
    cli();
    result = KeyPressed;
    sei();
    return result;
}

inline void EnableTimer0(uint8_t enable)
{
    cli();
    BPUT( TIMSK0, TOIE0, enable );
    TCNT0 = (uchar)(short)-(((F_CPU / 1024) * (CHECK_MS / 1000.0f)) + 0.5);
    sei();
}

volatile uint8_t countDown = 0;
inline void EnableTimer1(uint8_t timeout_s, uint8_t enable)
{
    cli();
    BPUT( TIMSK1, TOIE1, enable );
    TCNT1 = (uint16_t)-((F_CPU / 1024) * 0.05f + 0.5f);
    countDown = timeout_s;
    sei();
}

inline void Timers_Init(void)
{
    BSET( TCCR0B, CS02 );
    BSET( TCCR0B, CS00 );
    BRESET( TIMSK0, TOIE0 );

    BSET( TCCR1B, CS12 );
    BSET( TCCR1B, CS10 );
    BRESET( TIMSK1, TOIE1 );
}

inline void Key_Init(void)
{
    BSET( KEY_PORT, KEY_PIN );
    BRESET( KEY_DD, KEY_PIN );
}

inline void KeyPoll(uint8_t timeout_s)
{
    uint8_t x, i, y;
    uint16_t cc = 4 * timeout_s, dd = 3 * cc;
    uint16_t c = cc, d = dd;

    EnableTimer0( TRUE );
    EnableTimer1( timeout_s, TRUE );

    while(countDown > 0) {
        x = 0;
        for (i = 0; i < 8; i++)
        {
            x >>= 1;

            y = get_key_press();
            BPUT( BUZZPORT, BUZZPIN, y );
            delayms(60);

            if (y == 1)
            {
                x |= 0x80;
                c = cc;
            }
        }
        otherBuf[bufCur] = x;
        bufCur = (bufCur + 1) & (MY_REPLY_BUF_SIZE - 1);/**/
        if (bufCur == bufStart)
            bufStart++;
    }

    EnableTimer0( FALSE );
    EnableTimer1( 0, FALSE );
    BRESET( BUZZPORT, BUZZPIN );

    if (bufCur != bufStart)
    {
        uint8_t len = ((bufCur + MY_REPLY_BUF_SIZE) - bufStart) & (MY_REPLY_BUF_SIZE - 1);
        Reset_TX();
        Send_Warmup(8);
        Send_Buf(ROTHR, otherBuf, MY_REPLY_BUF_SIZE, bufStart, len);
        bufStart = bufCur;
    }
}

static uchar count = (RELEASE_MS / CHECK_MS);
ISR(TIMER0_OVF_vect)
{
    uchar rawState;

    TCNT0 = (uchar)(short)-(((F_CPU / 1024) * (CHECK_MS / 1000.0f)) + 0.5);

    KeyChanged = 0;
    KeyPressed = DebouncedKeyPress;
    rawState = ! BGET( KEY_PORT, KEY_PIN );
    if (rawState == DebouncedKeyPress)
    {
        if (DebouncedKeyPress) count = (RELEASE_MS / CHECK_MS);
        else count = (PRESS_MS / CHECK_MS);
    }
    else
    {
        if (--count == 0)
        {
            DebouncedKeyPress = rawState;
            KeyChanged = 1;
            KeyPressed = DebouncedKeyPress;

            if (DebouncedKeyPress) count = (RELEASE_MS / CHECK_MS);
            else count = (PRESS_MS / CHECK_MS);
        }
    }
}

ISR(TIMER1_OVF_vect)
{
    TCNT1 = 53817;//(uint16_t)-((F_CPU / 1024) * 0.05f + 0.5f);

    EnableTimer0( FALSE );

    BRESET( BUZZPORT, BUZZPIN );
    BSET( PORTD, PD7 );
    
    uint8_t size = ((bufCur + MY_REPLY_BUF_SIZE) - bufStart) & (MY_REPLY_BUF_SIZE - 1);
    if (size > 0)
    {
        Reset_TX();
        Send_Warmup(8);
        Send_Buf(ROTHR, otherBuf, MY_REPLY_BUF_SIZE, bufStart, size);
        bufStart = bufCur;
    }

    --countDown;

    BRESET( PORTD, PD7 );

    EnableTimer0( TRUE );
}
