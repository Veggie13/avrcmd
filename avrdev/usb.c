#ifndef USB_C
#define USB_C

#include "vs_avr.h"
#include "usbdrv/usbdrv.h"

#include "tele.c"


static uchar replyBuf[MY_REPLY_BUF_SIZE];
static uchar* otherBuf = NULL;
static uint8_t bufCur = 0;
volatile uint8_t bufLast = 0;
uchar handle_GET_BITS(usbRequest_t* rq)
{
    uint8_t len, i, j;
    len = ((bufCur + MY_REPLY_BUF_SIZE) - bufLast) & (MY_REPLY_BUF_SIZE - 1);
    for (i = 0, j = (bufCur + 1) & (MY_REPLY_BUF_SIZE - 1);
        i < len;
        i++, j = (j + 1) & (MY_REPLY_BUF_SIZE - 1))
    {
        replyBuf[i] = otherBuf[j];
    }
    bufCur = j;
    usbMsgPtr = replyBuf;

    return (uchar)len;
}

static uchar dataReceived = 0, dataLength = 0;
uchar handle_SEND_PLAY(usbRequest_t* rq)
{
    SendPlay(dataReceived);
    return 0;
}

uchar handle_LET_TALK(usbRequest_t* rq)
{
    uint8_t timeout_s = rq->wValue.bytes[0];
    LetTalk(timeout_s);
    return 0;
}

uchar handle_PLAY_DAT(usbRequest_t* rq)
{
    dataLength = (uchar)rq->wLength.word;
    dataReceived = 0;

    if (dataLength > MY_REPLY_BUF_SIZE)
        dataLength = MY_REPLY_BUF_SIZE;

    return USB_NO_MSG;
}

uchar handle_SET_ADDR(usbRequest_t* rq)
{
    rothr = rq->wValue.bytes[0];
    return 0;
}

USB_PUBLIC uchar usbFunctionWrite(uchar* data, uchar len)
{
    uint8_t i;
    for (i = 0; dataReceived < dataLength && i < len; i++, dataReceived++)
        sendBuf[dataReceived] = data[i];

    return (dataReceived == dataLength);
}
    
static uint8_t begin = FALSE;
USB_PUBLIC uchar usbFunctionSetup(uchar data[8]) {
    usbRequest_t *rq = (usbRequest_t*)(void *)data; // cast data to correct type
    if (!begin)
        return 0;
        
    switch(rq->bRequest) {
    default:    return 0;
    case USB_GET_BITS:  return handle_GET_BITS(rq);
    case USB_SEND_PLAY: return handle_SEND_PLAY(rq);
    case USB_LET_TALK:  return handle_LET_TALK(rq);
    case USB_PLAY_DAT:  return handle_PLAY_DAT(rq);
    case USB_SET_ADDR:  return handle_SET_ADDR(rq);
    }/**/

    return 0;
}

#endif
