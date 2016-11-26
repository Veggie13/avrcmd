#ifndef HANDLERS_C
#define HANDLERS_C

#include "morse.c"
#include "comms.c"


volatile uint8_t state = STATE_LISTEN;
static uint8_t nextRecv = 0;
static uint8_t getNum = 0;
static uint8_t getNumTag = 8;
static uint8_t datTag = 8; 

inline uint8_t handle_LISTEN(uint8_t tag, uint8_t data)
{
    switch (data)
    {
    default:        break;
    case CMD_PLAY:
        state = STATE_GETNUM;
        getNumTag = (tag + 1) & 0x7;
        break;
    case CMD_TALK:
        state = STATE_GETTTO;
        getNumTag = (tag + 1) & 0x7;
        break;
    }

    return TRUE;
}

inline uint8_t handle_GETNUM(uint8_t tag, uint8_t data)
{
    if (tag != getNumTag)
    {
        state = STATE_LISTEN;
        return FALSE;
    }
    getNum = (data > 64) ? 64 : data;
    nextRecv = 0;
    datTag = (tag + 1) & 0x7;
    state = STATE_GETDAT;

    return TRUE;
}

inline uint8_t handle_GETDAT(uint8_t tag, uint8_t data)
{
    uint8_t diff = ((tag + 8) - datTag) & 0x7;
    if (nextRecv + diff < getNum)
    {
        nextRecv += diff;
        speakBuf[nextRecv++] = data;
        datTag = (tag + 1) & 0x7;
    }
    if (nextRecv >= getNum)
    {
        state = STATE_PLAYIT;
        return FALSE;
    }

    return TRUE;
}

volatile uint8_t talkTimeout_s = 0;
inline uint8_t handle_GETTTO(uint8_t tag, uint8_t data)
{
    if (tag != getNumTag)
    {
        state = STATE_LISTEN;
        return FALSE;
    }
    talkTimeout_s = data;
    state = STATE_GOTALK;
    Enable_RX( FALSE );

    return FALSE;
}

uint8_t RecvByte(uint8_t tag, uint8_t data)
{
    switch (state)
    {
    default:    return FALSE;
    case STATE_LISTEN:  return handle_LISTEN(tag, data);
    case STATE_GETNUM:  return handle_GETNUM(tag, data);
    case STATE_GETDAT:  return handle_GETDAT(tag, data);
    case STATE_GETTTO:  return handle_GETTTO(tag, data);
    }
}

void RecvFinish(void)
{
    if (state == STATE_PLAYIT)
    {
        Speak();
        state = STATE_LISTEN;
    }
}

#endif
