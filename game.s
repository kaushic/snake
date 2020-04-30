	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"game.c"
	.text
	.align	2
	.global	initSnake
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	initSnake, %function
initSnake:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	ip, #0
	push	{r4, r5, lr}
	ldr	r5, .L6
	mov	r2, ip
	mov	r3, r5
	mov	r1, #4
	mov	r4, #118
	add	lr, r5, #880
.L2:
	asr	r0, ip, #1
	add	r0, r0, #80
	str	r1, [r3, #16]
	str	r1, [r3, #20]
	str	r4, [r3, #4]
	str	r1, [r3, #8]
	str	r1, [r3, #12]
	str	r2, [r3, #24]
	str	r2, [r3, #28]
	str	r2, [r3, #32]
	str	r2, [r3, #36]
	str	r2, [r3, #40]
	str	r0, [r3]
	add	r3, r3, #44
	cmp	r3, lr
	add	ip, ip, #4
	bne	.L2
	mov	r1, #1
	ldr	r2, .L6+4
	ldr	r3, [r2]
	add	r3, r3, r1
	str	r1, [r5, #24]
	str	r3, [r2]
	pop	{r4, r5, lr}
	bx	lr
.L7:
	.align	2
.L6:
	.word	snake
	.word	snakeLength
	.size	initSnake, .-initSnake
	.align	2
	.global	initGame
	.syntax unified
	.arm
	.fpu softvfp
	.type	initGame, %function
initGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, #256
	ldr	r4, .L10
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L10+4
	mov	lr, pc
	bx	r4
	mov	r3, #32
	mov	r2, #100663296
	mov	r0, #3
	ldr	r1, .L10+8
	mov	lr, pc
	bx	r4
	mov	r3, #1024
	mov	r0, #3
	ldr	r2, .L10+12
	ldr	r1, .L10+16
	mov	lr, pc
	bx	r4
	mov	r3, #256
	mov	r0, #3
	ldr	r2, .L10+20
	ldr	r1, .L10+24
	mov	lr, pc
	bx	r4
	mov	r0, #3
	ldr	r2, .L10+28
	ldr	r1, .L10+32
	mov	r3, #16384
	mov	lr, pc
	bx	r4
	ldr	r3, .L10+36
	mov	lr, pc
	bx	r3
	bl	initSnake
	mov	r3, #0
	mov	r1, #16
	mvn	lr, #0
	mov	r0, #5
	ldr	ip, .L10+40
	ldr	r2, .L10+44
	str	r3, [ip]
	str	r3, [r2]
	ldr	ip, .L10+48
	ldr	r2, .L10+52
	str	r3, [ip]
	str	r3, [r2]
	ldr	ip, .L10+56
	str	r3, [r2, #4]
	str	r3, [r2, #16]
	ldr	r3, .L10+60
	str	lr, [ip]
	str	r1, [r2, #8]
	str	r1, [r2, #12]
	str	r0, [r3]
	pop	{r4, lr}
	bx	lr
.L11:
	.align	2
.L10:
	.word	DMANow
	.word	bgPal
	.word	bgTiles
	.word	100720640
	.word	bgMap
	.word	83886592
	.word	snakePal
	.word	100728832
	.word	snakeTiles
	.word	hideSprites
	.word	snakeLength
	.word	segments
	.word	frameCounter
	.word	apple
	.word	appleLoc
	.word	applesLeft
	.size	initGame, .-initGame
	.align	2
	.global	drawSnake
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawSnake, %function
drawSnake:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, .L19
	ldr	ip, .L19+4
	push	{r4, r5, r6, r7, lr}
	mov	r3, r2
	mov	r1, ip
	mov	r0, #0
	mov	r4, #37
	mov	r7, #35
	ldrh	r6, [r2]
	ldrh	r5, [r2, #4]
	b	.L17
.L13:
	cmp	r2, #20
	beq	.L12
.L15:
	mov	r0, r2
	add	r3, r3, #44
	add	r1, r1, #8
.L17:
	ldr	r2, [r3, #24]
	cmp	r2, #1
	add	r2, r0, #1
	bne	.L13
	cmp	r0, #0
	strheq	r6, [ip]	@ movhi
	strheq	r5, [ip, #2]	@ movhi
	strheq	r7, [ip, #4]	@ movhi
	beq	.L15
	ldr	lr, [r3]
	ldr	r0, [r3, #4]
	cmp	r2, #20
	strh	r4, [r1, #4]	@ movhi
	strh	lr, [r1]	@ movhi
	strh	r0, [r1, #2]	@ movhi
	bne	.L15
.L12:
	pop	{r4, r5, r6, r7, lr}
	bx	lr
.L20:
	.align	2
.L19:
	.word	snake
	.word	shadowOAM
	.size	drawSnake, .-drawSnake
	.align	2
	.global	drawGame
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawGame, %function
drawGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	bl	drawSnake
	ldr	r3, .L24
	ldr	r2, [r3, #16]
	cmp	r2, #1
	bne	.L22
	mov	r1, #0
	ldm	r3, {r0, r2}
	ldr	r3, .L24+4
	orr	r2, r2, #16384
	strh	r2, [r3, #242]	@ movhi
	strh	r0, [r3, #240]	@ movhi
	strh	r1, [r3, #244]	@ movhi
.L22:
	ldr	r3, .L24+8
	mov	lr, pc
	bx	r3
	ldr	r4, .L24+12
	mov	r3, #512
	mov	r2, #117440512
	mov	r0, #3
	ldr	r1, .L24+4
	mov	lr, pc
	bx	r4
	pop	{r4, lr}
	bx	lr
.L25:
	.align	2
.L24:
	.word	apple
	.word	shadowOAM
	.word	waitForVBlank
	.word	DMANow
	.size	drawGame, .-drawGame
	.align	2
	.global	updateSnake
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateSnake, %function
updateSnake:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, .L84
	ldr	r3, .L84+4
	ldr	r2, [r2]
	smull	r0, r1, r3, r2
	push	{r4, r5, r6, r7, r8, lr}
	asr	r3, r2, #31
	rsb	r3, r3, r1, asr #2
	add	r3, r3, r3, lsl #2
	cmp	r2, r3, lsl #1
	sub	sp, sp, #16
	bne	.L27
	ldr	r1, .L84+8
	mov	r2, #20
	mov	r5, r1
	mov	r3, r1
	ldr	r1, [r1, #40]
	b	.L29
.L82:
	ldr	ip, [r3, #836]
	ldr	r0, [r3, #840]
	cmn	r2, #1
	str	ip, [r3, #880]
	str	r0, [r3, #884]
	sub	r3, r3, #44
	beq	.L80
.L29:
	cmp	r2, #0
	sub	r2, r2, #1
	bne	.L82
	cmp	r1, #3
	ldrls	pc, [pc, r1, asl #2]
	b	.L80
.L48:
	.word	.L31
	.word	.L33
	.word	.L34
	.word	.L35
.L35:
	mov	r2, #3
	ldr	r3, [r5, #4]
	ldr	r1, [r5, #12]
	add	r3, r3, r1
	str	r3, [r5, #4]
	str	r2, [r5, #36]
	ldr	r1, [r5]
.L36:
	ldr	r3, .L84+12
	ldr	r3, [r3]
	cmp	r3, #1
	ble	.L37
	ldr	r4, .L84+8
	mov	r8, #1
	ldr	r7, .L84+16
	add	r6, r4, #836
	b	.L40
.L38:
	add	r4, r4, #44
	cmp	r4, r6
	beq	.L37
.L40:
	ldr	r3, [r4, #68]
	cmp	r3, #0
	beq	.L38
	add	r0, r4, #60
	add	r2, r4, #44
	ldm	r2, {r2, r3}
	ldm	r0, {r0, ip}
	str	r2, [sp, #4]
	str	ip, [sp, #12]
	str	r0, [sp, #8]
	str	r3, [sp]
	add	r2, r5, #16
	ldm	r2, {r2, r3}
	ldr	r0, [r5, #4]
	mov	lr, pc
	bx	r7
	add	r4, r4, #44
	cmp	r0, #0
	strne	r8, [r5, #32]
	cmp	r4, r6
	ldr	r1, [r5]
	bne	.L40
.L37:
	ldr	r3, .L84+20
	ldrh	r3, [r3]
	tst	r3, #32
	beq	.L41
	ldr	r2, .L84+24
	ldrh	r2, [r2]
	tst	r2, #32
	bne	.L41
	ldr	r2, [r5, #36]
	cmp	r2, #3
	beq	.L41
	mov	r3, #2
	str	r3, [r5, #40]
.L42:
	cmn	r1, #1
	blt	.L47
	ldr	r3, [r5, #20]
	add	r1, r1, r3
	cmp	r1, #159
	ble	.L83
.L47:
	mov	r3, #1
	str	r3, [r5, #28]
.L26:
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr
.L34:
	mov	r2, #2
	ldr	r3, [r5, #4]
	ldr	r1, [r5, #12]
	sub	r3, r3, r1
	str	r3, [r5, #4]
	str	r2, [r5, #36]
	ldr	r1, [r5]
	b	.L36
.L33:
	mov	r3, #1
	ldr	r2, [r5]
	ldr	r1, [r5, #8]
	add	r1, r2, r1
	str	r1, [r5]
	str	r3, [r5, #36]
	b	.L36
.L31:
	mov	r3, #0
	ldr	r2, [r5]
	ldr	r1, [r5, #8]
	sub	r1, r2, r1
	str	r1, [r5]
	str	r3, [r5, #36]
	b	.L36
.L41:
	tst	r3, #16
	beq	.L43
	ldr	r2, .L84+24
	ldrh	r2, [r2]
	tst	r2, #16
	bne	.L43
	ldr	r2, [r5, #36]
	cmp	r2, #2
	movne	r3, #3
	strne	r3, [r5, #40]
	bne	.L42
.L43:
	tst	r3, #64
	beq	.L44
	ldr	r2, .L84+24
	ldrh	r2, [r2]
	ands	r2, r2, #64
	bne	.L44
	ldr	r0, [r5, #36]
	cmp	r0, #1
	strne	r2, [r5, #40]
	bne	.L42
.L44:
	tst	r3, #128
	beq	.L42
	ldr	r3, .L84+24
	ldrh	r3, [r3]
	tst	r3, #128
	bne	.L42
	ldr	r3, [r5, #36]
	cmp	r3, #0
	movne	r3, #1
	strne	r3, [r5, #40]
	b	.L42
.L27:
	ldr	r5, .L84+8
.L80:
	ldr	r1, [r5]
	b	.L36
.L83:
	ldr	r3, [r5, #4]
	cmn	r3, #1
	blt	.L47
	ldr	r2, [r5, #16]
	add	r3, r3, r2
	cmp	r3, #239
	bgt	.L47
	b	.L26
.L85:
	.align	2
.L84:
	.word	frameCounter
	.word	1717986919
	.word	snake
	.word	snakeLength
	.word	collision
	.word	oldButtons
	.word	buttons
	.size	updateSnake, .-updateSnake
	.align	2
	.global	initApple
	.syntax unified
	.arm
	.fpu softvfp
	.type	initApple, %function
initApple:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #0
	mov	r1, #16
	ldr	r3, .L87
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #16]
	str	r1, [r3, #8]
	str	r1, [r3, #12]
	bx	lr
.L88:
	.align	2
.L87:
	.word	apple
	.size	initApple, .-initApple
	.align	2
	.global	updateApple
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateApple, %function
updateApple:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	ldr	r5, .L102
	ldr	r6, [r5, #16]
	cmp	r6, #0
	sub	sp, sp, #20
	bne	.L90
	ldr	r4, .L102+4
	ldr	r3, [r4]
	cmn	r3, #1
	beq	.L100
.L90:
	ldr	r4, .L102+8
	ldr	r3, [r4, #24]
	cmp	r3, #1
	beq	.L101
.L89:
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, lr}
	bx	lr
.L100:
	ldr	r7, .L102+12
	mov	lr, pc
	bx	r7
	ldr	r3, .L102+16
	smull	r1, r2, r3, r0
	asr	r3, r0, #31
	rsb	r3, r3, r2, asr #6
	add	r3, r3, r3, lsl #6
	sub	r0, r0, r3, lsl #1
	add	r0, r0, #10
	str	r0, [r5]
	mov	lr, pc
	bx	r7
	mov	r1, #1
	ldr	r2, .L102+20
	smull	r3, r2, r0, r2
	asr	r3, r0, #31
	add	r2, r2, r0
	rsb	r3, r3, r2, asr #7
	str	r6, [r4]
	rsb	r3, r3, r3, lsl #3
	ldr	r4, .L102+8
	rsb	r3, r3, r3, lsl #4
	sub	r0, r0, r3, lsl r1
	ldr	r3, [r4, #24]
	add	r0, r0, #10
	cmp	r3, #1
	str	r0, [r5, #4]
	str	r1, [r5, #16]
	bne	.L89
.L101:
	ldr	r6, .L102+4
	ldr	r3, [r6]
	ldr	r7, [r4, #20]
	ldr	ip, [r4, #16]
	add	r3, r3, r3, lsl #2
	add	r0, r5, r3, lsl #2
	ldr	r1, [r5, r3, lsl #2]
	ldr	lr, [r4]
	ldmib	r0, {r0, r2, r3}
	str	r7, [sp, #12]
	str	ip, [sp, #8]
	ldr	ip, [r4, #4]
	ldr	r7, .L102+24
	stm	sp, {ip, lr}
	mov	lr, pc
	bx	r7
	cmp	r0, #0
	beq	.L89
	mvn	ip, #0
	mov	r0, #0
	ldr	lr, .L102+28
	ldr	r1, [lr]
	add	r1, r1, ip
	str	r1, [lr]
	ldr	lr, .L102+32
	ldr	r1, [lr]
	add	r1, r1, #1
	str	r1, [lr]
	ldr	r1, [r6]
	add	r1, r1, r1, lsl #2
	add	r5, r5, r1, lsl #2
	mov	r3, r0
	mov	r2, r4
	str	r0, [r5, #16]
	str	ip, [r6]
	b	.L94
.L92:
	add	r3, r3, #1
	cmp	r3, #20
	add	r2, r2, #44
	beq	.L89
.L94:
	ldr	r1, [r2, #24]
	cmp	r1, #0
	bne	.L92
	mov	r2, #1
	add	r1, r3, r3, lsl #2
	add	r3, r3, r1, lsl r2
	add	r3, r4, r3, lsl #2
	str	r2, [r3, #24]
	b	.L89
.L103:
	.align	2
.L102:
	.word	apple
	.word	appleLoc
	.word	snake
	.word	rand
	.word	2114445439
	.word	-1677082467
	.word	collision
	.word	applesLeft
	.word	snakeLength
	.size	updateApple, .-updateApple
	.align	2
	.global	updateGame
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateGame, %function
updateGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r0, .L106
	ldr	r1, .L106+4
	ldr	r2, [r0]
	ldr	r3, [r1]
	add	r2, r2, #1
	add	r3, r3, #1
	str	r2, [r0]
	str	r3, [r1]
	bl	updateSnake
	pop	{r4, lr}
	b	updateApple
.L107:
	.align	2
.L106:
	.word	frameCounter
	.word	segments
	.size	updateGame, .-updateGame
	.align	2
	.global	drawApple
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawApple, %function
drawApple:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L110
	ldr	r2, [r3, #16]
	cmp	r2, #1
	bxne	lr
	mov	r1, #0
	ldm	r3, {r0, r2}
	ldr	r3, .L110+4
	orr	r2, r2, #16384
	strh	r2, [r3, #242]	@ movhi
	strh	r0, [r3, #240]	@ movhi
	strh	r1, [r3, #244]	@ movhi
	bx	lr
.L111:
	.align	2
.L110:
	.word	apple
	.word	shadowOAM
	.size	drawApple, .-drawApple
	.comm	frameCounter,4,4
	.comm	appleLoc,4,4
	.comm	applesLeft,4,4
	.comm	apple,20,4
	.comm	segments,4,4
	.comm	snakeLength,4,4
	.comm	snake,880,4
	.comm	shadowOAM,1024,4
	.ident	"GCC: (devkitARM release 53) 9.1.0"
