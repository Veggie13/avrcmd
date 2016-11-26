	.file	"main2.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	delayms
	.type	delayms, @function
delayms:
/* prologue: function */
/* frame size = 0 */
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	ldi r20,lo8(3000)
	ldi r21,hi8(3000)
	rjmp .L2
.L3:
	movw r30,r20
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	subi r18,lo8(-(1))
	sbci r19,hi8(-(1))
.L2:
	cp r18,r24
	cpc r19,r25
	brlo .L3
/* epilogue start */
	ret
	.size	delayms, .-delayms
.global	delay_s
	.type	delay_s, @function
delay_s:
/* prologue: function */
/* frame size = 0 */
	ldi r25,lo8(0)
	ldi r20,lo8(3000)
	ldi r21,hi8(3000)
	rjmp .L6
.L8:
	ldi r18,lo8(0)
	ldi r19,hi8(0)
.L7:
	movw r30,r20
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	subi r18,lo8(-(1))
	sbci r19,hi8(-(1))
	ldi r22,hi8(1000)
	cpi r18,lo8(1000)
	cpc r19,r22
	brne .L7
	subi r25,lo8(-(1))
.L6:
	cp r25,r24
	brlo .L8
/* epilogue start */
	ret
	.size	delay_s, .-delay_s
.global	EnableBuzzer
	.type	EnableBuzzer, @function
EnableBuzzer:
/* prologue: function */
/* frame size = 0 */
	tst r24
	breq .L12
	sbi 42-32,6
	ret
.L12:
	cbi 42-32,6
	ret
	.size	EnableBuzzer, .-EnableBuzzer
.global	Buzz
	.type	Buzz, @function
Buzz:
/* prologue: function */
/* frame size = 0 */
	sbi 43-32,6
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	ldi r20,lo8(3000)
	ldi r21,hi8(3000)
	rjmp .L16
.L17:
	movw r30,r20
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	subi r18,lo8(-(1))
	sbci r19,hi8(-(1))
.L16:
	cp r18,r24
	cpc r19,r25
	brlo .L17
	cbi 43-32,6
/* epilogue start */
	ret
	.size	Buzz, .-Buzz
.global	Dit
	.type	Dit, @function
Dit:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(120)
	ldi r25,hi8(120)
	rcall Buzz
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	ldi r18,lo8(3000)
	ldi r19,hi8(3000)
.L20:
	movw r30,r18
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	adiw r24,1
	cpi r24,120
	cpc r25,__zero_reg__
	brne .L20
/* epilogue start */
	ret
	.size	Dit, .-Dit
.global	Dah
	.type	Dah, @function
Dah:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(360)
	ldi r25,hi8(360)
	rcall Buzz
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	ldi r18,lo8(3000)
	ldi r19,hi8(3000)
.L24:
	movw r30,r18
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	adiw r24,1
	cpi r24,120
	cpc r25,__zero_reg__
	brne .L24
/* epilogue start */
	ret
	.size	Dah, .-Dah
.global	CharBreak
	.type	CharBreak, @function
CharBreak:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	ldi r18,lo8(3000)
	ldi r19,hi8(3000)
.L28:
	movw r30,r18
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	adiw r24,1
	cpi r24,240
	cpc r25,__zero_reg__
	brne .L28
/* epilogue start */
	ret
	.size	CharBreak, .-CharBreak
.global	WordBreak
	.type	WordBreak, @function
WordBreak:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	ldi r18,lo8(3000)
	ldi r19,hi8(3000)
.L32:
	movw r30,r18
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	adiw r24,1
	ldi r20,hi8(720)
	cpi r24,lo8(720)
	cpc r25,r20
	brne .L32
/* epilogue start */
	ret
	.size	WordBreak, .-WordBreak
.global	SpeakSymbol
	.type	SpeakSymbol, @function
SpeakSymbol:
/* prologue: function */
/* frame size = 0 */
	ldi r25,lo8(0)
	andi r24,lo8(3)
	andi r25,hi8(3)
	cpi r24,2
	cpc r25,__zero_reg__
	breq .L38
	cpi r24,3
	cpc r25,__zero_reg__
	breq .L39
	sbiw r24,1
	breq .L37
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	ldi r18,lo8(3000)
	ldi r19,hi8(3000)
.L40:
	movw r30,r18
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	adiw r24,1
	ldi r20,hi8(720)
	cpi r24,lo8(720)
	cpc r25,r20
	brne .L40
	ret
.L37:
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	ldi r18,lo8(3000)
	ldi r19,hi8(3000)
.L42:
	movw r30,r18
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	adiw r24,1
	cpi r24,240
	cpc r25,__zero_reg__
	brne .L42
	ret
.L38:
	rcall Dit
	ret
.L39:
	rcall Dah
	ret
	.size	SpeakSymbol, .-SpeakSymbol
.global	Speak
	.type	Speak, @function
Speak:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	lds r28,speakBuf
	lds r29,(speakBuf)+1
	ldi r17,lo8(0)
	rjmp .L47
.L49:
	swap r24
	lsr r24
	lsr r24
	andi r24,lo8(3)
	rcall SpeakSymbol
	ld r24,Y
	swap r24
	andi r24,lo8(15)
	rcall SpeakSymbol
	ld r24,Y
	lsr r24
	lsr r24
	rcall SpeakSymbol
	ld r24,Y
	rcall SpeakSymbol
	st Y+,__zero_reg__
	subi r17,lo8(-(1))
	cpi r17,lo8(64)
	breq .L50
.L47:
	ld r24,Y
	tst r24
	brne .L49
.L50:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	ret
	.size	Speak, .-Speak
.global	Enable_RX
	.type	Enable_RX, @function
Enable_RX:
/* prologue: function */
/* frame size = 0 */
/* #APP */
 ;  18 "comms.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	tst r24
	breq .L52
	lds r24,193
	ori r24,lo8(-112)
	rjmp .L55
.L52:
	lds r24,193
	andi r24,lo8(111)
.L55:
	sts 193,r24
/* #APP */
 ;  23 "comms.c" 1
	sei
 ;  0 "" 2
/* epilogue start */
/* #NOAPP */
	ret
	.size	Enable_RX, .-Enable_RX
.global	USART_Init
	.type	USART_Init, @function
USART_Init:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(1)
	sts 197,r24
	ldi r24,lo8(55)
	sts 196,r24
	ldi r24,lo8(6)
	sts 194,r24
	ldi r24,lo8(-104)
	sts 193,r24
/* epilogue start */
	ret
	.size	USART_Init, .-USART_Init
.global	USART_vReceiveByte
	.type	USART_vReceiveByte, @function
USART_vReceiveByte:
/* prologue: function */
/* frame size = 0 */
.L59:
	lds r24,192
	sbrs r24,7
	rjmp .L59
	lds r24,198
/* epilogue start */
	ret
	.size	USART_vReceiveByte, .-USART_vReceiveByte
.global	USART_vSendByte
	.type	USART_vSendByte, @function
USART_vSendByte:
/* prologue: function */
/* frame size = 0 */
	mov r25,r24
.L63:
	lds r24,192
	sbrs r24,5
	rjmp .L63
	sts 198,r25
/* epilogue start */
	ret
	.size	USART_vSendByte, .-USART_vSendByte
.global	Send_Warmup
	.type	Send_Warmup, @function
Send_Warmup:
/* prologue: function */
/* frame size = 0 */
	mov r18,r24
	ldi r25,lo8(0)
	ldi r19,lo8(-52)
	rjmp .L67
.L70:
	lds r24,192
	sbrs r24,5
	rjmp .L70
	sts 198,r19
	subi r25,lo8(-(1))
.L67:
	cp r25,r18
	brlo .L70
/* epilogue start */
	ret
	.size	Send_Warmup, .-Send_Warmup
.global	Reset_TX
	.type	Reset_TX, @function
Reset_TX:
/* prologue: function */
/* frame size = 0 */
	sts curTag,__zero_reg__
/* epilogue start */
	ret
	.size	Reset_TX, .-Reset_TX
.global	Send_Packet
	.type	Send_Packet, @function
Send_Packet:
/* prologue: function */
/* frame size = 0 */
	lds r25,curTag
	mov r19,r24
	or r19,r25
	ldi r18,lo8(0)
	ldi r21,lo8(-52)
	ldi r23,lo8(-86)
	mov r20,r22
	add r20,r19
.L89:
	lds r24,192
	sbrs r24,5
	rjmp .L89
	sts 198,r21
.L76:
	lds r24,192
	sbrs r24,5
	rjmp .L76
	sts 198,r21
.L77:
	lds r24,192
	sbrs r24,5
	rjmp .L77
	sts 198,r23
.L78:
	lds r24,192
	sbrs r24,5
	rjmp .L78
	sts 198,r19
.L79:
	lds r24,192
	sbrs r24,5
	rjmp .L79
	sts 198,r22
.L80:
	lds r24,192
	sbrs r24,5
	rjmp .L80
	sts 198,r20
	subi r18,lo8(-(1))
	cpi r18,lo8(6)
	brne .L89
	subi r25,lo8(-(1))
	andi r25,lo8(7)
	sts curTag,r25
/* epilogue start */
	ret
	.size	Send_Packet, .-Send_Packet
.global	Send_Buf
	.type	Send_Buf, @function
Send_Buf:
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	mov r13,r24
	movw r28,r22
	mov r12,r20
	mov r17,r18
	mov r14,r16
	mov r22,r16
	rcall Send_Packet
	clr r15
	rjmp .L91
.L92:
	mov r16,r17
	ldi r17,lo8(0)
	movw r30,r28
	add r30,r16
	adc r31,r17
	mov r24,r13
	ld r22,Z
	rcall Send_Packet
	movw r24,r16
	adiw r24,1
	mov r22,r12
	ldi r23,lo8(0)
	rcall __divmodhi4
	mov r17,r24
	inc r15
.L91:
	cp r15,r14
	brlo .L92
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	Send_Buf, .-Send_Buf
.global	handle_LISTEN
	.type	handle_LISTEN, @function
handle_LISTEN:
/* prologue: function */
/* frame size = 0 */
	mov r25,r24
	cpi r22,lo8(51)
	breq .L96
	cpi r22,lo8(68)
	brne .L95
	rjmp .L100
.L96:
	ldi r24,lo8(1)
	rjmp .L99
.L100:
	ldi r24,lo8(3)
.L99:
	sts state,r24
	subi r25,lo8(-(1))
	andi r25,lo8(7)
	sts getNumTag,r25
.L95:
	ldi r24,lo8(1)
/* epilogue start */
	ret
	.size	handle_LISTEN, .-handle_LISTEN
.global	handle_GETNUM
	.type	handle_GETNUM, @function
handle_GETNUM:
/* prologue: function */
/* frame size = 0 */
	mov r25,r24
	lds r24,getNumTag
	cp r25,r24
	breq .L102
	sts state,__zero_reg__
	ldi r24,lo8(0)
	ret
.L102:
	cpi r22,lo8(65)
	brlo .L104
	ldi r22,lo8(64)
.L104:
	sts getNum,r22
	sts nextRecv,__zero_reg__
	subi r25,lo8(-(1))
	andi r25,lo8(7)
	sts datTag,r25
	ldi r24,lo8(2)
	sts state,r24
	ldi r24,lo8(1)
	ret
	.size	handle_GETNUM, .-handle_GETNUM
.global	handle_GETDAT
	.type	handle_GETDAT, @function
handle_GETDAT:
/* prologue: function */
/* frame size = 0 */
	mov r21,r24
	lds r24,datTag
	mov r20,r21
	sub r20,r24
	andi r20,lo8(7)
	lds r23,nextRecv
	lds r26,getNum
	mov r24,r23
	ldi r25,lo8(0)
	add r24,r20
	adc r25,__zero_reg__
	mov r18,r26
	ldi r19,lo8(0)
	cp r24,r18
	cpc r25,r19
	brge .L107
	mov r24,r20
	add r24,r23
	lds r30,speakBuf
	lds r31,(speakBuf)+1
	add r30,r24
	adc r31,__zero_reg__
	st Z,r22
	subi r24,lo8(-(1))
	sts nextRecv,r24
	subi r21,lo8(-(1))
	andi r21,lo8(7)
	sts datTag,r21
.L107:
	lds r24,nextRecv
	cp r24,r26
	brsh .L108
	ldi r24,lo8(1)
	ret
.L108:
	ldi r24,lo8(5)
	sts state,r24
	ldi r24,lo8(0)
	ret
	.size	handle_GETDAT, .-handle_GETDAT
.global	handle_GETTTO
	.type	handle_GETTTO, @function
handle_GETTTO:
/* prologue: function */
/* frame size = 0 */
	lds r25,getNumTag
	cp r24,r25
	breq .L112
	sts state,__zero_reg__
	rjmp .L113
.L112:
	sts talkTimeout_s,r22
	ldi r24,lo8(6)
	sts state,r24
	ldi r24,lo8(0)
	rcall Enable_RX
.L113:
	ldi r24,lo8(0)
/* epilogue start */
	ret
	.size	handle_GETTTO, .-handle_GETTTO
.global	RecvByte
	.type	RecvByte, @function
RecvByte:
/* prologue: function */
/* frame size = 0 */
	lds r25,state
	cpi r25,lo8(1)
	breq .L118
	cpi r25,lo8(1)
	brlo .L117
	cpi r25,lo8(2)
	breq .L119
	cpi r25,lo8(3)
	breq .L120
	ldi r24,lo8(0)
	ret
.L117:
	rcall handle_LISTEN
	ret
.L118:
	rcall handle_GETNUM
	ret
.L119:
	rcall handle_GETDAT
	ret
.L120:
	rcall handle_GETTTO
	ret
	.size	RecvByte, .-RecvByte
.global	RecvFinish
	.type	RecvFinish, @function
RecvFinish:
/* prologue: function */
/* frame size = 0 */
	lds r24,state
	cpi r24,lo8(5)
	brne .L125
	rcall Speak
	sts state,__zero_reg__
.L125:
	ret
	.size	RecvFinish, .-RecvFinish
.global	__vector_18
	.type	__vector_18, @function
__vector_18:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r17
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
.L127:
	lds r24,192
	sbrs r24,7
	rjmp .L127
	lds r24,198
	cpi r24,lo8(-86)
	brne .L133
.L134:
	lds r24,192
	sbrs r24,7
	rjmp .L134
	lds r18,198
.L130:
	lds r24,192
	sbrs r24,7
	rjmp .L130
	lds r22,198
.L131:
	lds r24,192
	sbrs r24,7
	rjmp .L131
	lds r25,198
	mov r24,r22
	add r24,r18
	cp r25,r24
	brne .L133
	mov r24,r18
	andi r24,lo8(-8)
	cpi r24,lo8(-48)
	brne .L133
	mov r17,r18
	andi r17,lo8(7)
	lds r24,lastTag
	cp r17,r24
	breq .L133
	mov r24,r17
	rcall RecvByte
	tst r24
	breq .L132
	sts lastTag,r17
	rjmp .L133
.L132:
	rcall RecvFinish
	ldi r24,lo8(8)
	sts lastTag,r24
.L133:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r17
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
	.size	__vector_18, .-__vector_18
.global	get_key_press
	.type	get_key_press, @function
get_key_press:
/* prologue: function */
/* frame size = 0 */
/* #APP */
 ;  20 "key.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	lds r24,KeyPressed
/* #APP */
 ;  22 "key.c" 1
	sei
 ;  0 "" 2
/* epilogue start */
/* #NOAPP */
	ret
	.size	get_key_press, .-get_key_press
.global	EnableTimer
	.type	EnableTimer, @function
EnableTimer:
/* prologue: function */
/* frame size = 0 */
/* #APP */
 ;  28 "key.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	tst r24
	breq .L142
	lds r24,110
	ori r24,lo8(1)
	rjmp .L145
.L142:
	lds r24,110
	andi r24,lo8(-2)
.L145:
	sts 110,r24
	ldi r24,lo8(-117)
	out 70-32,r24
/* #APP */
 ;  31 "key.c" 1
	sei
 ;  0 "" 2
/* epilogue start */
/* #NOAPP */
	ret
	.size	EnableTimer, .-EnableTimer
.global	Timers_Init
	.type	Timers_Init, @function
Timers_Init:
/* prologue: function */
/* frame size = 0 */
	in r24,69-32
	ori r24,lo8(4)
	out 69-32,r24
	in r24,69-32
	ori r24,lo8(1)
	out 69-32,r24
	ldi r30,lo8(110)
	ldi r31,hi8(110)
	ld r24,Z
	andi r24,lo8(-2)
	st Z,r24
/* epilogue start */
	ret
	.size	Timers_Init, .-Timers_Init
.global	Key_Init
	.type	Key_Init, @function
Key_Init:
/* prologue: function */
/* frame size = 0 */
	sbi 41-32,2
	cbi 42-32,2
/* epilogue start */
	ret
	.size	Key_Init, .-Key_Init
.global	KeyPoll
	.type	KeyPoll, @function
KeyPoll:
	push r6
	push r7
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	lds r9,bufCur
	mov r28,r24
	ldi r29,lo8(0)
	lsl r28
	rol r29
	lsl r28
	rol r29
	movw r16,r28
	lsl r16
	rol r17
	add r16,r28
	adc r17,r29
	ldi r24,lo8(1)
	rcall EnableTimer
	lds r10,otherBuf
	lds r11,(otherBuf)+1
	movw r14,r28
	movw r12,r16
	mov r17,r9
	ldi r24,lo8(3000)
	mov r6,r24
	ldi r24,hi8(3000)
	mov r7,r24
	rjmp .L166
.L157:
	ldi r18,lo8(0)
	ldi r19,lo8(0)
.L155:
	lsr r18
/* #APP */
 ;  20 "key.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	lds r20,KeyPressed
/* #APP */
 ;  22 "key.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	tst r20
	breq .L152
	sbi 43-32,6
	rjmp .L167
.L152:
	cbi 43-32,6
.L167:
	ldi r24,lo8(0)
	ldi r25,hi8(0)
.L162:
	movw r30,r6
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	adiw r24,1
	cpi r24,30
	cpc r25,__zero_reg__
	brne .L162
	cpi r20,lo8(1)
	brne .L154
	ori r18,lo8(-128)
	movw r14,r28
.L154:
	subi r19,lo8(-(1))
	cpi r19,lo8(8)
	brne .L155
	movw r30,r10
	add r30,r17
	adc r31,__zero_reg__
	st Z,r18
	subi r17,lo8(-(1))
	andi r17,lo8(63)
	cp r17,r9
	brne .L166
	ldi r24,lo8(0)
	rcall EnableTimer
	sts curTag,__zero_reg__
	ldi r24,lo8(8)
	rcall Send_Warmup
	ldi r24,lo8(104)
	movw r22,r10
	ldi r20,lo8(64)
	mov r18,r17
	ldi r16,lo8(64)
	rcall Send_Buf
	ldi r24,lo8(1)
	rcall EnableTimer
.L166:
	sec
	sbc r14,__zero_reg__
	sbc r15,__zero_reg__
	cp r14,__zero_reg__
	cpc r15,__zero_reg__
	breq .L156
	sec
	sbc r12,__zero_reg__
	sbc r13,__zero_reg__
	cp r12,__zero_reg__
	cpc r13,__zero_reg__
	breq .+2
	rjmp .L157
.L156:
	sts bufCur,r17
	lds r16,bufCur
	cp r16,r9
	breq .L159
	ldi r24,lo8(0)
	rcall EnableTimer
	sts curTag,__zero_reg__
	ldi r24,lo8(8)
	rcall Send_Warmup
	sub r16,r9
	andi r16,lo8(63)
	ldi r24,lo8(104)
	movw r22,r10
	ldi r20,lo8(64)
	mov r18,r9
	rcall Send_Buf
	ldi r24,lo8(1)
	rcall EnableTimer
.L159:
	ldi r24,lo8(0)
	rcall EnableTimer
	cbi 43-32,6
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r7
	pop r6
	ret
	.size	KeyPoll, .-KeyPoll
.global	__vector_16
	.type	__vector_16, @function
__vector_16:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r24
	push r25
/* prologue: Signal */
/* frame size = 0 */
	ldi r24,lo8(-117)
	out 70-32,r24
	sts KeyChanged,__zero_reg__
	lds r24,DebouncedKeyPress
	sts KeyPressed,r24
	in r25,41-32
	lsr r25
	lsr r25
	com r25
	andi r25,lo8(1)
	cp r25,r24
	brne .L169
	tst r25
	breq .L172
	ldi r24,lo8(1)
	rjmp .L174
.L169:
	lds r24,count
	subi r24,lo8(-(-1))
	sts count,r24
	tst r24
	brne .L173
	sts DebouncedKeyPress,r25
	ldi r24,lo8(1)
	sts KeyChanged,r24
	sts KeyPressed,r25
	tst r25
	brne .L174
.L172:
	ldi r24,lo8(2)
.L174:
	sts count,r24
.L173:
/* epilogue start */
	pop r25
	pop r24
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
	.size	__vector_16, .-__vector_16
.global	Main_Init
	.type	Main_Init, @function
Main_Init:
/* prologue: function */
/* frame size = 0 */
/* #APP */
 ;  12 "main2.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(BBBUF)
	ldi r25,hi8(BBBUF)
	sts (speakBuf)+1,r25
	sts speakBuf,r24
	sts (otherBuf)+1,r25
	sts otherBuf,r24
	rcall Timers_Init
	ldi r24,lo8(1)
	sts 197,r24
	ldi r24,lo8(55)
	sts 196,r24
	ldi r24,lo8(6)
	sts 194,r24
	ldi r24,lo8(-104)
	sts 193,r24
	sbi 41-32,2
	cbi 42-32,2
	sbi 42-32,6
	cbi 43-32,6
	sbi 42-32,7
	cbi 43-32,7
	sbi 36-32,0
	cbi 37-32,0
	sts state,__zero_reg__
/* #APP */
 ;  31 "main2.c" 1
	sei
 ;  0 "" 2
/* epilogue start */
/* #NOAPP */
	ret
	.size	Main_Init, .-Main_Init
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
	rcall Main_Init
.L181:
	lds r24,state
	cpi r24,lo8(6)
	brne .L178
	lds r24,talkTimeout_s
	rcall KeyPoll
	sts state,__zero_reg__
	ldi r24,lo8(1)
	rcall Enable_RX
	rjmp .L181
.L178:
	ldi r24,lo8(1)
	rcall delay_s
	rjmp .L181
	.size	main, .-main
.global	state
.global	state
	.section .bss
	.type	state, @object
	.size	state, 1
state:
	.skip 1,0
.global	talkTimeout_s
.global	talkTimeout_s
	.type	talkTimeout_s, @object
	.size	talkTimeout_s, 1
talkTimeout_s:
	.skip 1,0
.global	KeyChanged
.global	KeyChanged
	.type	KeyChanged, @object
	.size	KeyChanged, 1
KeyChanged:
	.skip 1,0
.global	KeyPressed
.global	KeyPressed
	.type	KeyPressed, @object
	.size	KeyPressed, 1
KeyPressed:
	.skip 1,0
	.lcomm speakBuf,2
	.lcomm otherBuf,2
	.lcomm DebouncedKeyPress,1
	.data
	.type	count, @object
	.size	count, 1
count:
	.byte	1
	.lcomm bufCur,1
	.type	getNumTag, @object
	.size	getNumTag, 1
getNumTag:
	.byte	8
	.type	datTag, @object
	.size	datTag, 1
datTag:
	.byte	8
	.lcomm nextRecv,1
	.lcomm getNum,1
	.type	lastTag, @object
	.size	lastTag, 1
lastTag:
	.byte	8
	.lcomm curTag,1
	.lcomm BBBUF,64
.global __do_copy_data
.global __do_clear_bss
