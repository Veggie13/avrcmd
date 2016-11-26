#define _RECVR_

#include "vs_avr.h"

#include "handlers.c"
#include "key.c"


static uchar BBBUF[MY_REPLY_BUF_SIZE];
inline void Main_Init(void)
{
    cli();

    otherBuf = speakBuf = BBBUF;

    Timers_Init();
    USART_Init();
    Key_Init();

    EnableBuzzer( TRUE );
    BRESET( BUZZPORT, BUZZPIN );

    BSET( DDRD, PD7 );
    BRESET( PORTD, PD7 );

    BSET( DDRB, PB0 );
    BRESET( PORTB, PB0 );

    state = STATE_LISTEN;

    sei();
}

int main(void)
{
    Main_Init();

    while (TRUE)
    {
        if (state == STATE_GOTALK)
        {
            KeyPoll(talkTimeout_s);
            state = STATE_LISTEN;
            Enable_RX( TRUE );
        }
        else
        {
            delay_s(1);
        }
    }

    return 0;
}
