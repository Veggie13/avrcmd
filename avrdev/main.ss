	.file	"main.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
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
	breq .L2
	lds r24,193
	ori r24,lo8(-112)
	rjmp .L5
.L2:
	lds r24,193
	andi r24,lo8(111)
.L5:
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
.L9:
	lds r24,192
	sbrs r24,7
	rjmp .L9
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
.L13:
	lds r24,192
	sbrs r24,5
	rjmp .L13
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
	rjmp .L17
.L20:
	lds r24,192
	sbrs r24,5
	rjmp .L20
	sts 198,r19
	subi r25,lo8(-(1))
.L17:
	cp r25,r18
	brlo .L20
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
.L39:
	lds r24,192
	sbrs r24,5
	rjmp .L39
	sts 198,r21
.L26:
	lds r24,192
	sbrs r24,5
	rjmp .L26
	sts 198,r21
.L27:
	lds r24,192
	sbrs r24,5
	rjmp .L27
	sts 198,r23
.L28:
	lds r24,192
	sbrs r24,5
	rjmp .L28
	sts 198,r19
.L29:
	lds r24,192
	sbrs r24,5
	rjmp .L29
	sts 198,r22
.L30:
	lds r24,192
	sbrs r24,5
	rjmp .L30
	sts 198,r20
	subi r18,lo8(-(1))
	cpi r18,lo8(6)
	brne .L39
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
	rjmp .L41
.L42:
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
.L41:
	cp r15,r14
	brlo .L42
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
.global	SendPlay
	.type	SendPlay, @function
SendPlay:
	push r16
/* prologue: function */
/* frame size = 0 */
	mov r16,r24
	sts curTag,__zero_reg__
	ldi r24,lo8(8)
	rcall Send_Warmup
	ldi r24,lo8(-48)
	ldi r22,lo8(51)
	rcall Send_Packet
	lds r22,sendBuf
	lds r23,(sendBuf)+1
	ldi r24,lo8(-48)
	ldi r20,lo8(64)
	ldi r18,lo8(0)
	rcall Send_Buf
/* epilogue start */
	pop r16
	ret
	.size	SendPlay, .-SendPlay
.global	LetTalk
	.type	LetTalk, @function
LetTalk:
	push r17
/* prologue: function */
/* frame size = 0 */
	mov r17,r24
	sts curTag,__zero_reg__
	ldi r24,lo8(8)
	rcall Send_Warmup
	ldi r24,lo8(-48)
	ldi r22,lo8(68)
	rcall Send_Packet
	ldi r24,lo8(-48)
	mov r22,r17
	rcall Send_Packet
/* epilogue start */
	pop r17
	ret
	.size	LetTalk, .-LetTalk
.global	handle_GET_BITS
	.type	handle_GET_BITS, @function
handle_GET_BITS:
/* prologue: function */
/* frame size = 0 */
	lds r25,bufCur
	lds r24,bufLast
	mov r20,r25
	sub r20,r24
	andi r20,lo8(63)
	subi r25,lo8(-(1))
	andi r25,lo8(63)
	lds r22,otherBuf
	lds r23,(otherBuf)+1
	ldi r26,lo8(replyBuf)
	ldi r27,hi8(replyBuf)
	mov r18,r20
	ldi r19,lo8(0)
	add r18,r26
	adc r19,r27
	rjmp .L49
.L50:
	movw r30,r22
	add r30,r25
	adc r31,__zero_reg__
	ld r24,Z
	st X+,r24
	subi r25,lo8(-(1))
	andi r25,lo8(63)
.L49:
	cp r26,r18
	cpc r27,r19
	brne .L50
	sts bufCur,r25
	ldi r24,lo8(replyBuf)
	ldi r25,hi8(replyBuf)
	sts (usbMsgPtr)+1,r25
	sts usbMsgPtr,r24
	mov r24,r20
/* epilogue start */
	ret
	.size	handle_GET_BITS, .-handle_GET_BITS
.global	handle_SEND_PLAY
	.type	handle_SEND_PLAY, @function
handle_SEND_PLAY:
/* prologue: function */
/* frame size = 0 */
	lds r24,dataReceived
	rcall SendPlay
	ldi r24,lo8(0)
/* epilogue start */
	ret
	.size	handle_SEND_PLAY, .-handle_SEND_PLAY
.global	handle_LET_TALK
	.type	handle_LET_TALK, @function
handle_LET_TALK:
/* prologue: function */
/* frame size = 0 */
	movw r30,r24
	ldd r24,Z+2
	rcall LetTalk
	ldi r24,lo8(0)
/* epilogue start */
	ret
	.size	handle_LET_TALK, .-handle_LET_TALK
.global	handle_PLAY_DAT
	.type	handle_PLAY_DAT, @function
handle_PLAY_DAT:
/* prologue: function */
/* frame size = 0 */
	movw r30,r24
	ldd r24,Z+6
	sts dataLength,r24
	sts dataReceived,__zero_reg__
	cpi r24,lo8(65)
	brlo .L57
	ldi r24,lo8(64)
	sts dataLength,r24
.L57:
	ldi r24,lo8(-1)
/* epilogue start */
	ret
	.size	handle_PLAY_DAT, .-handle_PLAY_DAT
.global	usbFunctionWrite
	.type	usbFunctionWrite, @function
usbFunctionWrite:
/* prologue: function */
/* frame size = 0 */
	lds r20,dataLength
	lds r30,dataReceived
	movw r26,r24
	ldi r25,lo8(0)
	rjmp .L60
.L63:
	ldi r31,lo8(0)
	subi r30,lo8(-(replyBuf))
	sbci r31,hi8(-(replyBuf))
	ld r24,X+
	st Z,r24
	subi r25,lo8(-(1))
	mov r30,r18
.L60:
	cp r30,r20
	brsh .L66
.L61:
	mov r18,r30
	subi r18,lo8(-(1))
	cp r25,r22
	brlo .L63
.L66:
	sts dataReceived,r30
	ldi r24,lo8(0)
	cp r30,r20
	brne .L64
	ldi r24,lo8(1)
.L64:
	ret
	.size	usbFunctionWrite, .-usbFunctionWrite
.global	usbFunctionSetup
	.type	usbFunctionSetup, @function
usbFunctionSetup:
/* prologue: function */
/* frame size = 0 */
	mov r18,r24
	lds r24,begin
	tst r24
	breq .L68
	mov r30,r18
	mov r31,r25
	ldd r24,Z+1
	cpi r24,lo8(2)
	breq .L70
	cpi r24,lo8(3)
	brsh .L73
	cpi r24,lo8(1)
	brne .L68
	rjmp .L79
.L73:
	cpi r24,lo8(3)
	breq .L71
	cpi r24,lo8(4)
	brne .L68
	rjmp .L80
.L71:
	movw r24,r30
	rcall handle_GET_BITS
	ret
.L79:
	lds r24,dataReceived
	rcall SendPlay
	rjmp .L77
.L70:
	ldd r24,Z+2
	rcall LetTalk
.L77:
	ldi r24,lo8(0)
	ret
.L80:
	ldd r24,Z+6
	sts dataLength,r24
	sts dataReceived,__zero_reg__
	cpi r24,lo8(65)
	brlo .L78
.L75:
	ldi r24,lo8(64)
	sts dataLength,r24
.L78:
	ldi r24,lo8(-1)
	ret
.L68:
	ldi r24,lo8(0)
	ret
	.size	usbFunctionSetup, .-usbFunctionSetup
.global	RecvByte
	.type	RecvByte, @function
RecvByte:
/* prologue: function */
/* frame size = 0 */
	mov r21,r24
	lds r26,recvSize
	cpi r26,lo8(65)
	brlo .L82
	sts recvSize,r22
	cpi r22,lo8(65)
	brlo .L83
	ldi r24,lo8(64)
	sts recvSize,r24
.L83:
	subi r21,lo8(-(1))
	andi r21,lo8(7)
	sts datTag,r21
	lds r24,bufLast
	subi r24,lo8(-(1))
	andi r24,lo8(63)
	sts nextRecv,r24
	ldi r25,lo8(1)
	rjmp .L84
.L82:
	lds r24,datTag
	mov r20,r21
	sub r20,r24
	andi r20,lo8(7)
	lds r23,nextRecv
	mov r24,r23
	ldi r25,lo8(0)
	add r24,r20
	adc r25,__zero_reg__
	mov r18,r26
	ldi r19,lo8(0)
	cp r24,r18
	cpc r25,r19
	brge .L85
	mov r24,r20
	add r24,r23
	andi r24,lo8(63)
	mov r30,r24
	ldi r31,lo8(0)
	subi r30,lo8(-(BBBUF))
	sbci r31,hi8(-(BBBUF))
	st Z,r22
	sts bufLast,r24
	subi r24,lo8(-(1))
	andi r24,lo8(63)
	sts nextRecv,r24
	subi r21,lo8(-(1))
	andi r21,lo8(7)
	sts datTag,r21
.L85:
	ldi r25,lo8(0)
	lds r24,nextRecv
	cp r24,r26
	brlo .L86
	ldi r25,lo8(1)
.L86:
	ldi r24,lo8(1)
	eor r25,r24
.L84:
	mov r24,r25
/* epilogue start */
	ret
	.size	RecvByte, .-RecvByte
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
.L89:
	lds r24,192
	sbrs r24,7
	rjmp .L89
	lds r24,198
	cpi r24,lo8(-86)
	brne .L95
.L96:
	lds r24,192
	sbrs r24,7
	rjmp .L96
	lds r18,198
.L92:
	lds r24,192
	sbrs r24,7
	rjmp .L92
	lds r22,198
.L93:
	lds r24,192
	sbrs r24,7
	rjmp .L93
	lds r25,198
	mov r24,r22
	add r24,r18
	cp r25,r24
	brne .L95
	mov r24,r18
	andi r24,lo8(-8)
	cpi r24,lo8(104)
	brne .L95
	mov r17,r18
	andi r17,lo8(7)
	lds r24,lastTag
	cp r17,r24
	breq .L95
	mov r24,r17
	rcall RecvByte
	tst r24
	breq .L94
	sts lastTag,r17
	rjmp .L95
.L94:
	ldi r24,lo8(65)
	sts recvSize,r24
	ldi r24,lo8(8)
	sts lastTag,r24
.L95:
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
.global	RecvFinish
	.type	RecvFinish, @function
RecvFinish:
/* prologue: function */
/* frame size = 0 */
	ldi r24,lo8(65)
	sts recvSize,r24
/* epilogue start */
	ret
	.size	RecvFinish, .-RecvFinish
.global	delayms
	.type	delayms, @function
delayms:
/* prologue: function */
/* frame size = 0 */
	ldi r18,lo8(0)
	ldi r19,hi8(0)
	ldi r20,lo8(3000)
	ldi r21,hi8(3000)
	rjmp .L104
.L105:
	movw r30,r20
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	subi r18,lo8(-(1))
	sbci r19,hi8(-(1))
.L104:
	cp r18,r24
	cpc r19,r25
	brlo .L105
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
	rjmp .L108
.L110:
	ldi r18,lo8(0)
	ldi r19,hi8(0)
.L109:
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
	brne .L109
	subi r25,lo8(-(1))
.L108:
	cp r25,r24
	brlo .L110
/* epilogue start */
	ret
	.size	delay_s, .-delay_s
.global	Main_Init
	.type	Main_Init, @function
Main_Init:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* #APP */
 ;  12 "main.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(BBBUF)
	ldi r25,hi8(BBBUF)
	sts (sendBuf)+1,r25
	sts sendBuf,r24
	sts (otherBuf)+1,r25
	sts otherBuf,r24
	ldi r24,lo8(1)
	sts 197,r24
	ldi r24,lo8(55)
	sts 196,r24
	ldi r24,lo8(6)
	sts 194,r24
	ldi r24,lo8(-104)
	sts 193,r24
	ldi r24,lo8(0)
	rcall Enable_RX
	sbi 42-32,6
	sbi 43-32,6
	sts state,__zero_reg__
	ldi r18,lo8(15)
	ldi r24,lo8(24)
	ldi r25,hi8(24)
/* #APP */
 ;  24 "main.c" 1
	in __tmp_reg__,__SREG__
	cli
	wdr
	sts 96,r24
	out __SREG__,__tmp_reg__
	sts 96,r18
	
 ;  0 "" 2
/* #NOAPP */
	rcall usbInit
	sbi 42-32,3
	ldi r18,lo8(0)
	ldi r20,lo8(3000)
	ldi r21,hi8(3000)
.L114:
/* #APP */
 ;  31 "main.c" 1
	wdr
 ;  0 "" 2
/* #NOAPP */
	movw r24,r20
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	movw r24,r20
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	subi r18,lo8(-(1))
	cpi r18,lo8(-6)
	brne .L114
	cbi 42-32,3
/* #APP */
 ;  36 "main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ldi r17,lo8(0)
	ldi r28,lo8(3000)
	ldi r29,hi8(3000)
.L116:
/* #APP */
 ;  39 "main.c" 1
	wdr
 ;  0 "" 2
/* #NOAPP */
	rcall usbPoll
	ldi r24,lo8(0)
	ldi r25,hi8(0)
.L115:
	movw r30,r28
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	adiw r24,1
	cpi r24,8
	cpc r25,__zero_reg__
	brne .L115
	subi r17,lo8(-(1))
	cpi r17,lo8(-6)
	brne .L116
	ldi r24,lo8(1)
	sts begin,r24
/* epilogue start */
	pop r29
	pop r28
	pop r17
	ret
	.size	Main_Init, .-Main_Init
.global	main
	.type	main, @function
main:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	rcall Main_Init
	ldi r25,lo8(106)
	sts BBBUF,r25
	ldi r24,lo8(127)
	sts BBBUF+1,r24
	sts BBBUF+2,r25
	sts BBBUF+3,__zero_reg__
	ldi r24,lo8(4)
	rcall SendPlay
	ldi r28,lo8(3000)
	ldi r29,hi8(3000)
.L123:
	rcall usbPoll
/* #APP */
 ;  78 "main.c" 1
	wdr
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(0)
	ldi r25,hi8(0)
.L122:
	movw r30,r28
/* #APP */
 ;  105 "c:/winavr-20100110/lib/gcc/../../avr/include/util/delay_basic.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	adiw r24,1
	cpi r24,32
	cpc r25,__zero_reg__
	brne .L122
	rjmp .L123
	.size	main, .-main
.global	bufLast
.global	bufLast
	.section .bss
	.type	bufLast, @object
	.size	bufLast, 1
bufLast:
	.skip 1,0
.global	morse
	.data
	.type	morse, @object
	.size	morse, 48
morse:
	.byte	2
	.byte	-1
	.byte	-64
	.byte	2
	.byte	-65
	.byte	-64
	.byte	2
	.byte	-81
	.byte	-64
	.byte	2
	.byte	-85
	.byte	-64
	.byte	2
	.byte	-86
	.byte	-64
	.byte	2
	.byte	-86
	.byte	-128
	.byte	2
	.byte	-22
	.byte	-128
	.byte	2
	.byte	-6
	.byte	-128
	.byte	2
	.byte	-2
	.byte	-128
	.byte	2
	.byte	-1
	.byte	-128
	.byte	1
	.byte	-80
	.byte	0
	.byte	1
	.byte	-22
	.byte	0
	.byte	1
	.byte	-18
	.byte	0
	.byte	1
	.byte	-24
	.byte	0
	.byte	1
	.byte	-128
	.byte	0
	.byte	1
	.byte	-82
	.byte	0
	.lcomm sendBuf,2
	.lcomm otherBuf,2
	.lcomm begin,1
	.type	recvSize, @object
	.size	recvSize, 1
recvSize:
	.byte	65
	.type	datTag, @object
	.size	datTag, 1
datTag:
	.byte	8
	.lcomm nextRecv,1
	.lcomm dataReceived,1
	.lcomm dataLength,1
	.lcomm bufCur,1
	.type	lastTag, @object
	.size	lastTag, 1
lastTag:
	.byte	8
	.lcomm curTag,1
	.lcomm replyBuf,64
	.lcomm BBBUF,64
	.lcomm state,1
.global __do_copy_data
.global __do_clear_bss
