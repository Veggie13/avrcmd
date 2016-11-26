#include "vs_avr.h"
#include "defs.h"

#include <avr/io.h>
#include <avr/interrupt.h>

#include <util/delay.h>

#include "comms.c"


void Main_Init(void)

{

	LEDPORT = 0;//LED OFF

	LED_DD= (1<<LEDPIN);//define port C pin 0 as output;

    BSET(LEDPORT,LEDPIN);
    _delay_ms(200);
    BRESET(LEDPORT,LEDPIN);
    _delay_ms(200);
    BSET(LEDPORT,LEDPIN);
    _delay_ms(200);
    BRESET(LEDPORT,LEDPIN);
    _delay_ms(200);
    BSET(LEDPORT,LEDPIN);
    _delay_ms(200);
    BRESET(LEDPORT,LEDPIN);

	//enable global interrupts

	sei();

}

int main(void)

{

	Main_Init();

	USART_Init();

	while(1)

	{

	}

	//nothing here interrupts are working

	return 0;

}