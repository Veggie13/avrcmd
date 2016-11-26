#include "vs_avr.h"

#include <avr/io.h>

#define F_CPU 12000000UL  // 1 MHz
#include <util/delay.h>

//set desired baud rate

#define BAUDRATE 1200

//calculate UBRR value

#define UBRRVAL ((F_CPU/(BAUDRATE*16UL))-1)

//define receive parameters

#define SYNC 0XAA// synchro signal

#define RADDR 0x44

#define LEDON 0x11//switch led on command

#define LEDOFF 0x22//switch led off command


int main(void)

{

USART_Init();

while(1)

	{//endless transmission

	//send command to switch led ON

	Send_Packet(RADDR, LEDON);

	delayms(100);

	//send command to switch led ON

	Send_Packet(RADDR, LEDOFF);

	delayms(100);

	}

	return 0;

}