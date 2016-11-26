#include "vs_avr.h"

#include <avr/wdt.h>

#include "main_handlers.c"
#include "common.c"


static uint8_t state;
void Main_Init(void)
{
    cli();

    otherBuf = sendBuf = BBBUF;

    USART_Init();
    Enable_RX( FALSE );

    BSET( DDRD, PD6 );
    BSET( PORTD, PD6 );

    state = 0;

    wdt_enable(WDTO_2S); // enable 1s watchdog timer

    usbInit();

    usbDeviceDisconnect(); // enforce re-enumeration
    uint8_t i;
    for(i = 0; i<250; i++) { // wait 500 ms
        wdt_reset(); // keep the watchdog happy
        delayms(2);
    }
    usbDeviceConnect();

    sei();

    for (i = 0; i < 250; i++) {
        wdt_reset();
        usbPoll();
        delayms(8);
    }
    begin = TRUE;
}

const uint8_t morse[] = {
    2, 0xff, 0xc0,
    2, 0xbf, 0xc0,
    2, 0xaf, 0xc0,
    2, 0xab, 0xc0,
    2, 0xaa, 0xc0,
    2, 0xaa, 0x80,
    2, 0xea, 0x80,
    2, 0xfa, 0x80,
    2, 0xfe, 0x80,
    2, 0xff, 0x80,
    1, 0xb0, 0,
    1, 0xea, 0,
    1, 0xee, 0,
    1, 0xe8, 0,
    1, 0x80, 0,
    1, 0xae, 0,
};

int main(void)
{
	Main_Init();

    BBBUF[0] = 0x6a;
    BBBUF[1] = 0x7f;
    BBBUF[2] = 0x6a;
    BBBUF[3] = 0;
    SendPlay(4);

    while( TRUE )
	{
        usbPoll();
        wdt_reset();
        delayms(32);
	}

	//nothing here interrupts are working

	return 0;

}
