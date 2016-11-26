#ifndef DEFS_H
#define DEFS_H

#include "addresses.h"

#define FALSE ((uint8_t)0)
#define TRUE  ((uint8_t)( ! FALSE))

#define NULL (0)

#define PPCAT_NX(A, B) A ## B
#define PPCAT(A, B) PPCAT_NX(A, B)


#define F_CPU 12000000UL  // 1 MHz

//set desired baud rate

#define BAUDRATE 2400
//366.21

//define receive parameters

#define SYNC 0XCC // synchro signal
#define STAT 0xAA // start signal

#ifdef _RECVR_
#define RADDR RC
#define ROTHR RA
#else
#define RADDR RA
#define ROTHR RB
#endif

#define LEDON 0x11//LED on command
#define LEDOFF 0x22//LED off command
#define LEDFLIP 0x55
#define CMD_PLAY 0x33
#define CMD_TALK 0x44

#define BSET(x, y) x |= (1 << y)
#define BRESET(x, y) x &= (~(1 << y))
#define BPUT(x, y, bit) do { \
    if (bit) { BSET(x, y); } \
    else { BRESET(x, y); } } while (FALSE)
#define BGET(x, y) ((x >> y) & 1)

#define MY_REPLY_BUF_BITS 6
#define MY_REPLY_BUF_SIZE (1 << MY_REPLY_BUF_BITS)

#define MORSE_WBK   0
#define MORSE_CBK   1
#define MORSE_DIT   2
#define MORSE_DAH   3

#ifdef _RECVR_
#define REDUNDANCY  3
#else
#define REDUNDANCY  6
#endif

#endif
