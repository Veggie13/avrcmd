#ifndef MAIN_HANDLERS_C
#define MAIN_HANDLERS_C

#include "vs_avr.h"
#include "main_defs.h"

#include "usb.c"
#include "comms.c"


static uint8_t recvSize = MY_REPLY_BUF_SIZE + 1;
static uint8_t nextRecv = 0;
static uint8_t datTag = 8;
static uchar BBBUF[MY_REPLY_BUF_SIZE];
uint8_t RecvByte(uint8_t tag, uint8_t data)
{
    if (recvSize > MY_REPLY_BUF_SIZE)
    {
        recvSize = data;
        if (recvSize > MY_REPLY_BUF_SIZE)
            recvSize = MY_REPLY_BUF_SIZE;
        datTag = (tag + 1) & 0x7;
        nextRecv = (bufLast + 1) & (MY_REPLY_BUF_SIZE - 1);
    }
    else
    {
        uint8_t diff = ((tag + 8) - datTag) & 0x7;
        if (nextRecv + diff < recvSize)
        {
            nextRecv = (nextRecv + diff) & (MY_REPLY_BUF_SIZE - 1);
            BBBUF[nextRecv] = data;
            bufLast = nextRecv;
            nextRecv = (nextRecv + 1) & (MY_REPLY_BUF_SIZE - 1);
            datTag = (tag + 1) & 0x7;
        }
        if (nextRecv >= recvSize)
        {
            return FALSE;
        }
    }

    return TRUE;
}

static uint8_t on = FALSE;
void RecvFinish(void)
{
    recvSize = MY_REPLY_BUF_SIZE + 1;
    on = !on;
    BPUT( PORTD, PD7, on );
}

#endif
