#ifndef TELE_C
#define TELE_C

#include "vs_avr.h"
#include "main_defs.h"

#include "comms.c"


static uint8_t rothr = ROTHR;
static uchar* sendBuf = NULL;
void SendPlay(uint8_t len)
{
    Reset_TX();
    Send_Warmup(8);
    Send_Packet(rothr, CMD_PLAY);
    Send_Buf(rothr, sendBuf, MY_REPLY_BUF_SIZE, 0, len);
}

void LetTalk(uint8_t timeout_s)
{
    Reset_TX();
    Send_Warmup(8);
    Send_Packet(rothr, CMD_TALK);
    Send_Packet(rothr, timeout_s);
}

#endif
