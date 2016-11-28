#include <stdlib.h>
#include <avr/io.h>
//#include <avr/delay.h>
#include <util/delay.h>
#include <avr/interrupt.h>

volatile uint16_t myCount = 0;
volatile uint8_t onFlag;
volatile unsigned char value = 0;

#define SET(x,y) (x) |= (1<<(y))
#define UNSET(x,y) (x) &= ~(1<<(y))
#define GET(x,y) (((x) & (1<<(y))) == (1<<(y)))
#define GIVE(x,y,z) {if (z) SET(x,y); else UNSET(x,y);}

#define ELEM00 PC3
#define ELEM01 PC4
#define ELEM02 PC5
#define ELEM10 PC2
#define ELEM11 PC1
#define ELEM12 PC0
#define ELEM20 PB5
#define ELEM21 PB4
#define ELEM22 PB3
#define ELEM30 PB2
#define ELEM31 PB1
#define ELEM32 PB0
#define ELEM40 PD0
#define ELEM41 PD1
#define ELEM42 PD2
#define ELEM50 PD3
#define ELEM51 PD4
#define ELEM52 PB6
#define ELEM60 PB7
#define ELEM61 PD5
#define ELEM62 PD6
#define BUZZER PD7
#define BUTTON PD7

#define ELEM(x,y) (ELEM[(x)*3+(y)])
#define PORT(x,y) (*PORT[(x)*3+(y)])


const unsigned char ELEM[] = {
	ELEM00, ELEM01, ELEM02,
	ELEM10, ELEM11, ELEM12,
	ELEM20, ELEM21, ELEM22,
	ELEM30, ELEM31, ELEM32,
	ELEM40, ELEM41, ELEM42,
	ELEM50, ELEM51, ELEM52,
	ELEM60, ELEM61, ELEM62 };
volatile uint8_t* const PORT[] = {
	&PORTC, &PORTC, &PORTC,
	&PORTC, &PORTC, &PORTC,
	&PORTB, &PORTB, &PORTB,
	&PORTB, &PORTB, &PORTB,
	&PORTD, &PORTD, &PORTD,
	&PORTD, &PORTD, &PORTB,
	&PORTB, &PORTD, &PORTD };
const unsigned char CHRT[] = {
	0x7, 0x1, 0x2, 0x3, 0x5, 0x6 };
const unsigned char N1[] = {
	0, 5, 0, 3, 4, 3, 5 };
const unsigned char N2[] = {
	2, 1, 4, 3, 3, 0, 2 };

void display(unsigned long bits)
{
	for (int i = 0; i < 21; i++)
		GIVE(*PORT[i],ELEM[i],GET(bits,i));
}

void blink(void)
{
	unsigned long r1, r2, r3;
	r1 = random();
	r2 = random();
	r3 = r1 & r2;
	
	display(r3);
		
	_delay_ms(500);
	
	display(0);
}

unsigned long getBits(unsigned char chars[7])
{
	unsigned long bits = 0;
	
	bits |= CHRT[chars[0]];
	bits <<= 3;
	bits |= CHRT[chars[1]];
	bits <<= 3;
	bits |= CHRT[chars[2]];
	bits <<= 3;
	bits |= CHRT[chars[3]];
	bits <<= 3;
	bits |= CHRT[chars[4]];
	bits <<= 3;
	bits |= CHRT[chars[5]];
	bits <<= 3;
	bits |= CHRT[chars[6]];
	
	return bits;
}

void quickBuzz(void)
{
	unsigned char state = 0;
	for (int i = 0; i < 500; i++)
	{
		GIVE(PORTD,BUZZER,state = !state);
		_delay_us(200);
	}
	UNSET(PORTD,BUZZER);
}

void waitForButton(void)
{
	unsigned char count = 0;
	unsigned char state = GET(DDRD,BUTTON);
	UNSET(DDRD,BUTTON);
	while (1)
	{
		if (GET(PIND,BUTTON))
		{
			if (++count == 4) break;
		} else count = 0;
	}
	SET(DDRD,BUZZER);
}

int main(void)
{
	DDRB = 0xFF;
	DDRC |= 0x3F;
	DDRD = 0xFF;
	while (1)
	{
		PORTD = 1;
		_delay_ms(500);
		PORTD = 0;
		_delay_ms(500);
	}
	
	return 0;
	
	display(0x3F);
	quickBuzz();
	_delay_ms(200);
	display(0);
	
	unsigned long b1 = getBits(N1);
	unsigned long b2 = getBits(N2);

	unsigned long count = 0;
	waitForButton();
	display(b1);
	quickBuzz();
	waitForButton();
	display(b2);
	quickBuzz();
	waitForButton();
	
	count = 0;
	while (count++ < 10440)
	{
		blink();
		_delay_ms(6500);
		_delay_ms(6500);
		_delay_ms(6500);
		_delay_ms(6500);
		_delay_ms(2708);
	}

	unsigned char state = 0;
	unsigned char ticker = 0;
	unsigned char lseg = 2;
	volatile unsigned char period = 2;
	unsigned char nper = 0;
	unsigned char buzz = 1;
	count = 0;
	
	unsigned char seg = (count++ >> 10) & 0xF;
	unsigned char sseg = seg & 0x3;

	while(1)
	{
		SET(DDRD,BUZZER);
		
		if (seg < 8)
			display(b1);
		else
			display(b2);/**/
		
		nper = 0;
		while (sseg == 0)
		{
			if (nper++ == 5)
			{
				nper = 0;
				GIVE(PORTD,BUZZER,state = !state);
			}
			
			_delay_us(100);
			seg = (count++ >> 10) & 0xF;
			sseg = seg & 0x3;
		}
		
		nper = 0;
		while (sseg == 1)
		{
			if (nper++ == 2)
			{
				nper = 0;
				GIVE(PORTD,BUZZER,state = !state);
			}
			
			_delay_us(100);
			seg = (count++ >> 10) & 0xF;
			sseg = seg & 0x3;
		}
		
		GIVE(PORTD,BUZZER,state = 0);
		UNSET(DDRD,BUTTON);
		
		ticker = 0;
		while (sseg > 0)
		{
			unsigned char in = GET(PIND,BUTTON);
			if (in && ++ticker > 2)
				goto after;
			
			_delay_us(100);
			seg = (count++ >> 10) & 0xF;
			sseg = seg & 0x3;
		}
		
	}/**/
	
	after:
	SET(DDRD,BUZZER);
	UNSET(PORTD,BUZZER);
	while (1)
	{
		display(b1);
		_delay_ms(1000);
		display(b2);/**/
		_delay_ms(1000);
	}
	
	
	return 1;
}

/*
ISR (TIMER0_OVF_vect)
{
	myCount++;
	
	if (myCount == (3900/1024))
	{
		if (PINC & (1<<PC0))
			PORTD = 0xAA;
		else
		{	
			if (onFlag == 0)
			{
				onFlag = 1;	
				PORTD = value++;
			}
		
			else 
			{
				onFlag = 0;
				PORTD = 0;
			}
		}
		myCount = 0;
	}
	
}
*/