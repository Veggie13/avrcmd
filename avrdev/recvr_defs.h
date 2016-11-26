#ifndef RECVR_DEFS_H
#define RECVR_DEFS_H

#include "defs.h"

#define BUZZPLTR B
#define BUZZPNUM 1
#define BUZZPIN  PPCAT(P, PPCAT(BUZZPLTR,BUZZPNUM))
#define BUZZPORT PPCAT(PORT, BUZZPLTR)
#define BUZZ_DD  PPCAT(DDR, BUZZPLTR)

#define KEY_PLTR B
#define KEY_PNUM 2
#define KEY_PIN  PPCAT(P, PPCAT(KEY_PLTR,KEY_PNUM))
#define KEY_PORT PPCAT(PIN, KEY_PLTR)
#define KEY_DD  PPCAT(DDR, KEY_PLTR)

#define DIT_LEN 120

#define CHECK_MS    10
#define PRESS_MS    40
#define RELEASE_MS  20

#define STATE_LISTEN    0
#define STATE_GETNUM    1
#define STATE_GETDAT    2
#define STATE_GETTTO    3
#define STATE_GOTALK    6
#define STATE_PLAYIT    5

typedef uint8_t uchar;

#endif
