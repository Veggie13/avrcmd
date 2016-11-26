#ifndef COMMS_C
#define COMMS_C

#include "vs_avr.h"

#include <avr/io.h>
#include <avr/interrupt.h>

#include "defs.h"


//calculate UBRR value

#define UBRRVAL ((uint16_t)(F_CPU/(BAUDRATE*16UL))-1)

inline void Enable_RX(uint8_t enable)
{
    cli();
    if (enable)
        UCSR0B |= (1<<RXEN0) | (1<<RXCIE0);
    else
        UCSR0B &= ~(1<<RXEN0) & ~(1<<RXCIE0);
    sei();
}

inline void USART_Init(void)
{
	//Set baud rate
	UBRR0H=(UBRRVAL>>8);	//high byte
	UBRR0L=(uint8_t)UBRRVAL;		//low byte

	//Set data frame format: asynchronous mode,no parity, 1 stop bit, 8 bit size
	UCSR0C=//(1<<URSEL)|
        (0<<UMSEL00)|(0<<UPM00)|
		(0<<USBS0)|(0x3<<UCSZ00);	
	
	//Enable Transmitter and Receiver and Interrupt on receive complete
	UCSR0B=(1<<RXEN0) | (1<<RXCIE0) |
        (0x0<<UCSZ02) | (1<<TXEN0);
}

inline uint8_t USART_vReceiveByte(void)

{

    // Wait until a byte has been received

    while((UCSR0A&(1<<RXC0)) == 0);

    // Return received data

    return UDR0;

}

inline void USART_vSendByte(uint8_t u8Data)

{

    // Wait if a byte is being transmitted

    while((UCSR0A&(1<<UDRE0)) == 0);

    // Transmit data

    UDR0 = u8Data;  

}

void Send_Warmup(uint8_t len)
{
    uint8_t i;
    for (i = 0; i < len; i++)
        USART_vSendByte(SYNC);
}

static uint8_t curTag = 0;
inline void Reset_TX(void)
{
    curTag = 0;
}

void Send_Packet(uint8_t addr, uint8_t cmd)
{
    uint8_t hdr = addr | curTag;
    uint8_t i;
    for (i = 0; i < REDUNDANCY; i++)
    {
#ifndef _RECVR_
        wdt_reset();
#endif
        USART_vSendByte(SYNC);//send synchro byte	
        USART_vSendByte(SYNC);//send synchro byte	
	    USART_vSendByte(STAT);
        USART_vSendByte(hdr);//send receiver address
	    USART_vSendByte(cmd);//send increment command
	    USART_vSendByte((hdr+cmd));//send checksum
    }
    curTag = (curTag + 1) & 0x7;
}

void Send_Buf(uint8_t addr, uchar* buf, uint8_t buflen, uint8_t first, uint8_t msglen)
{
    Send_Packet(addr, msglen);
    uint8_t i, n;
    for (i = first, n = 0; n < msglen; i = (i + 1) % buflen, n++)
    {
        Send_Packet(addr, buf[i]);
    }
}


static uint8_t lastTag = 8;
uint8_t RecvByte(uint8_t tag, uint8_t data);
void RecvFinish(void);
ISR(USART_RX_vect)
{
    uint8_t raddress, data, chk, hdr, tag, sync;//transmitter address

    sync = USART_vReceiveByte();
    if (sync == STAT)
    {
	    hdr=USART_vReceiveByte();
	    data=USART_vReceiveByte();
	    chk=USART_vReceiveByte();

        uint8_t sum = hdr+data;
	    if(chk==sum)//if match perform operations
	    {
            tag = hdr & 0x07;
            raddress = hdr & 0xf8;
		    if((raddress==RADDR) && (tag != lastTag))
		    {
                if (RecvByte(tag, data))
                    lastTag = tag;
                else
                {
                    RecvFinish();
                    lastTag = 8;
                }
		    }
	    }
    }
}

#endif
