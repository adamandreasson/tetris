   1              		.syntax unified
   2              		.arch armv6-m
   3              		.fpu softvfp
   4              		.eabi_attribute 20, 1
   5              		.eabi_attribute 21, 1
   6              		.eabi_attribute 23, 3
   7              		.eabi_attribute 24, 1
   8              		.eabi_attribute 25, 1
   9              		.eabi_attribute 26, 1
  10              		.eabi_attribute 30, 6
  11              		.eabi_attribute 34, 0
  12              		.eabi_attribute 18, 4
  13              		.thumb
  14              		.syntax unified
  15              		.file	"startup.c"
  16              		.text
  17              	.Ltext0:
  18              		.cfi_sections	.debug_frame
  19              		.section	.start_section,"ax",%progbits
  20              		.align	2
  21              		.global	startup
  22              		.code	16
  23              		.thumb_func
  25              	startup:
  26              	.LFB0:
  27              		.file 1 "Z:/Media/Documents/DAT017/game/startup.c"
   1:Z:/Media/Documents/DAT017/game\startup.c **** /*
   2:Z:/Media/Documents/DAT017/game\startup.c ****  * 	startup.c
   3:Z:/Media/Documents/DAT017/game\startup.c ****  *
   4:Z:/Media/Documents/DAT017/game\startup.c ****  */
   5:Z:/Media/Documents/DAT017/game\startup.c ****  
   6:Z:/Media/Documents/DAT017/game\startup.c ****  
   7:Z:/Media/Documents/DAT017/game\startup.c ****  #define SIMULATOR 1
   8:Z:/Media/Documents/DAT017/game\startup.c ****  
   9:Z:/Media/Documents/DAT017/game\startup.c **** void startup(void) __attribute__((naked)) __attribute__((section (".start_section")) );
  10:Z:/Media/Documents/DAT017/game\startup.c **** 
  11:Z:/Media/Documents/DAT017/game\startup.c **** void startup ( void )
  12:Z:/Media/Documents/DAT017/game\startup.c **** {
  28              		.loc 1 12 0
  29              		.cfi_startproc
  13:Z:/Media/Documents/DAT017/game\startup.c **** asm volatile(
  30              		.loc 1 13 0
  31              		.syntax divided
  32              	@ 13 "Z:/Media/Documents/DAT017/game/startup.c" 1
  33 0000 0248     		 LDR R0,=0x2001C000
  34 0002 8546     	 MOV SP,R0
  35 0004 FFF7FEFF 	 BL main
  36 0008 FEE7     	.L1: B .L1
  37              	
  38              	@ 0 "" 2
  14:Z:/Media/Documents/DAT017/game\startup.c **** 	" LDR R0,=0x2001C000\n"		/* set stack */
  15:Z:/Media/Documents/DAT017/game\startup.c **** 	" MOV SP,R0\n"
  16:Z:/Media/Documents/DAT017/game\startup.c **** 	" BL main\n"				/* call main */
  17:Z:/Media/Documents/DAT017/game\startup.c **** 	".L1: B .L1\n"				/* never return */
  18:Z:/Media/Documents/DAT017/game\startup.c **** 	) ;
  19:Z:/Media/Documents/DAT017/game\startup.c **** }
  39              		.loc 1 19 0
  40              		.thumb
  41              		.syntax unified
  42 000a C046     		nop
  43              		.cfi_endproc
  44              	.LFE0:
  46              		.text
  47              		.align	2
  48              		.global	delay_250ns
  49              		.code	16
  50              		.thumb_func
  52              	delay_250ns:
  53              	.LFB1:
  20:Z:/Media/Documents/DAT017/game\startup.c **** 
  21:Z:/Media/Documents/DAT017/game\startup.c **** #define STK_CTRL ((volatile unsigned int *) (0xE000E010))
  22:Z:/Media/Documents/DAT017/game\startup.c **** #define STK_LOAD ((volatile unsigned int *) (0xE000E014))
  23:Z:/Media/Documents/DAT017/game\startup.c **** #define STK_VAL ((volatile unsigned int *) (0xE000E018))
  24:Z:/Media/Documents/DAT017/game\startup.c **** 
  25:Z:/Media/Documents/DAT017/game\startup.c **** 
  26:Z:/Media/Documents/DAT017/game\startup.c **** #define B_E 0x40 /* Enable */
  27:Z:/Media/Documents/DAT017/game\startup.c **** #define B_RST 0x20 /* Reset */
  28:Z:/Media/Documents/DAT017/game\startup.c **** #define B_CS2 0x10 /* Controller Select 2 */
  29:Z:/Media/Documents/DAT017/game\startup.c **** #define B_CS1 8 /* Controller Select 1 */
  30:Z:/Media/Documents/DAT017/game\startup.c **** #define B_SELECT 4 /* ASCII or Graphics select */
  31:Z:/Media/Documents/DAT017/game\startup.c **** #define B_RW 2 /* Read/Write */
  32:Z:/Media/Documents/DAT017/game\startup.c **** #define B_DI 1 /* Data or Instruction : 1 data, 0 Instr */
  33:Z:/Media/Documents/DAT017/game\startup.c **** 
  34:Z:/Media/Documents/DAT017/game\startup.c **** #define LCD_ON 0x3F /* Display på */
  35:Z:/Media/Documents/DAT017/game\startup.c **** #define LCD_OFF 0x3E /* Av */
  36:Z:/Media/Documents/DAT017/game\startup.c **** #define LCD_SET_ADD 0x40 /* Set X adress (0 – 63) */
  37:Z:/Media/Documents/DAT017/game\startup.c **** #define LCD_SET_PAGE 0xB8 /* Set Y adress (0 – 7) */
  38:Z:/Media/Documents/DAT017/game\startup.c **** #define LCD_DISP_START 0xC0 /* Start adress i display minne */
  39:Z:/Media/Documents/DAT017/game\startup.c **** #define LCD_BUSY 0x80 /* läsa ut busy status. R/W skall vara hög */
  40:Z:/Media/Documents/DAT017/game\startup.c **** 
  41:Z:/Media/Documents/DAT017/game\startup.c **** #define PORT_DISPLAY_BASE 0x40021000 /* MD407 port E */
  42:Z:/Media/Documents/DAT017/game\startup.c **** #define portModer ((volatile unsigned int *) (PORT_DISPLAY_BASE))
  43:Z:/Media/Documents/DAT017/game\startup.c **** #define portOtyper ((volatile unsigned short *) (PORT_DISPLAY_BASE+0x4))
  44:Z:/Media/Documents/DAT017/game\startup.c **** #define portOspeedr ((volatile unsigned int *) (PORT_DISPLAY_BASE+0x8))
  45:Z:/Media/Documents/DAT017/game\startup.c **** #define portPupdr ((volatile unsigned int *) (PORT_DISPLAY_BASE+0xC))
  46:Z:/Media/Documents/DAT017/game\startup.c **** #define portIdr ((volatile unsigned short *) (PORT_DISPLAY_BASE+0x10))
  47:Z:/Media/Documents/DAT017/game\startup.c **** #define portIdrHigh ((volatile unsigned char *) (PORT_DISPLAY_BASE+0x11))
  48:Z:/Media/Documents/DAT017/game\startup.c **** #define portOdrLow ((volatile unsigned char *) (PORT_DISPLAY_BASE+0x14))
  49:Z:/Media/Documents/DAT017/game\startup.c **** #define portOdrHigh ((volatile unsigned char *) (PORT_DISPLAY_BASE+0x14+1))
  50:Z:/Media/Documents/DAT017/game\startup.c **** 
  51:Z:/Media/Documents/DAT017/game\startup.c **** typedef unsigned char uint8;	
  52:Z:/Media/Documents/DAT017/game\startup.c **** typedef enum { false, true } bool;
  53:Z:/Media/Documents/DAT017/game\startup.c **** 
  54:Z:/Media/Documents/DAT017/game\startup.c **** void delay_250ns(void) {
  54              		.loc 1 54 0
  55              		.cfi_startproc
  56 0000 80B5     		push	{r7, lr}
  57              		.cfi_def_cfa_offset 8
  58              		.cfi_offset 7, -8
  59              		.cfi_offset 14, -4
  60 0002 00AF     		add	r7, sp, #0
  61              		.cfi_def_cfa_register 7
  55:Z:/Media/Documents/DAT017/game\startup.c **** 	*STK_CTRL = 0;
  62              		.loc 1 55 0
  63 0004 0C4B     		ldr	r3, .L4
  64 0006 0022     		movs	r2, #0
  65 0008 1A60     		str	r2, [r3]
  56:Z:/Media/Documents/DAT017/game\startup.c **** 	*STK_LOAD = ( (168/4) -1 );
  66              		.loc 1 56 0
  67 000a 0C4B     		ldr	r3, .L4+4
  68 000c 2922     		movs	r2, #41
  69 000e 1A60     		str	r2, [r3]
  57:Z:/Media/Documents/DAT017/game\startup.c **** 	*STK_VAL = 0;
  70              		.loc 1 57 0
  71 0010 0B4B     		ldr	r3, .L4+8
  72 0012 0022     		movs	r2, #0
  73 0014 1A60     		str	r2, [r3]
  58:Z:/Media/Documents/DAT017/game\startup.c **** 	*STK_CTRL = 5;
  74              		.loc 1 58 0
  75 0016 084B     		ldr	r3, .L4
  76 0018 0522     		movs	r2, #5
  77 001a 1A60     		str	r2, [r3]
  59:Z:/Media/Documents/DAT017/game\startup.c **** 	while( (*STK_CTRL & 0x10000) == 0 ) {
  78              		.loc 1 59 0
  79 001c C046     		nop
  80              	.L3:
  81              		.loc 1 59 0 is_stmt 0 discriminator 1
  82 001e 064B     		ldr	r3, .L4
  83 0020 1A68     		ldr	r2, [r3]
  84 0022 8023     		movs	r3, #128
  85 0024 5B02     		lsls	r3, r3, #9
  86 0026 1340     		ands	r3, r2
  87 0028 F9D0     		beq	.L3
  60:Z:/Media/Documents/DAT017/game\startup.c **** 	}
  61:Z:/Media/Documents/DAT017/game\startup.c **** 	*STK_CTRL = 0;
  88              		.loc 1 61 0 is_stmt 1
  89 002a 034B     		ldr	r3, .L4
  90 002c 0022     		movs	r2, #0
  91 002e 1A60     		str	r2, [r3]
  62:Z:/Media/Documents/DAT017/game\startup.c **** }
  92              		.loc 1 62 0
  93 0030 C046     		nop
  94 0032 BD46     		mov	sp, r7
  95              		@ sp needed
  96 0034 80BD     		pop	{r7, pc}
  97              	.L5:
  98 0036 C046     		.align	2
  99              	.L4:
 100 0038 10E000E0 		.word	-536813552
 101 003c 14E000E0 		.word	-536813548
 102 0040 18E000E0 		.word	-536813544
 103              		.cfi_endproc
 104              	.LFE1:
 106              		.align	2
 107              		.global	delay_500ns
 108              		.code	16
 109              		.thumb_func
 111              	delay_500ns:
 112              	.LFB2:
  63:Z:/Media/Documents/DAT017/game\startup.c **** 
  64:Z:/Media/Documents/DAT017/game\startup.c **** //maybe not so ghetto idk
  65:Z:/Media/Documents/DAT017/game\startup.c **** void delay_500ns(void) {
 113              		.loc 1 65 0
 114              		.cfi_startproc
 115 0044 80B5     		push	{r7, lr}
 116              		.cfi_def_cfa_offset 8
 117              		.cfi_offset 7, -8
 118              		.cfi_offset 14, -4
 119 0046 00AF     		add	r7, sp, #0
 120              		.cfi_def_cfa_register 7
  66:Z:/Media/Documents/DAT017/game\startup.c **** 
  67:Z:/Media/Documents/DAT017/game\startup.c **** 	delay_250ns();
 121              		.loc 1 67 0
 122 0048 FFF7FEFF 		bl	delay_250ns
  68:Z:/Media/Documents/DAT017/game\startup.c **** 	delay_250ns();
 123              		.loc 1 68 0
 124 004c FFF7FEFF 		bl	delay_250ns
  69:Z:/Media/Documents/DAT017/game\startup.c **** }
 125              		.loc 1 69 0
 126 0050 C046     		nop
 127 0052 BD46     		mov	sp, r7
 128              		@ sp needed
 129 0054 80BD     		pop	{r7, pc}
 130              		.cfi_endproc
 131              	.LFE2:
 133 0056 C046     		.align	2
 134              		.global	delay_micro
 135              		.code	16
 136              		.thumb_func
 138              	delay_micro:
 139              	.LFB3:
  70:Z:/Media/Documents/DAT017/game\startup.c **** 
  71:Z:/Media/Documents/DAT017/game\startup.c **** void delay_micro(unsigned int us) {
 140              		.loc 1 71 0
 141              		.cfi_startproc
 142 0058 80B5     		push	{r7, lr}
 143              		.cfi_def_cfa_offset 8
 144              		.cfi_offset 7, -8
 145              		.cfi_offset 14, -4
 146 005a 82B0     		sub	sp, sp, #8
 147              		.cfi_def_cfa_offset 16
 148 005c 00AF     		add	r7, sp, #0
 149              		.cfi_def_cfa_register 7
 150 005e 7860     		str	r0, [r7, #4]
  72:Z:/Media/Documents/DAT017/game\startup.c **** 	while(us--) {
 151              		.loc 1 72 0
 152 0060 07E0     		b	.L8
 153              	.L9:
  73:Z:/Media/Documents/DAT017/game\startup.c **** 		delay_250ns();
 154              		.loc 1 73 0
 155 0062 FFF7FEFF 		bl	delay_250ns
  74:Z:/Media/Documents/DAT017/game\startup.c **** 		delay_250ns();
 156              		.loc 1 74 0
 157 0066 FFF7FEFF 		bl	delay_250ns
  75:Z:/Media/Documents/DAT017/game\startup.c **** 		delay_250ns();
 158              		.loc 1 75 0
 159 006a FFF7FEFF 		bl	delay_250ns
  76:Z:/Media/Documents/DAT017/game\startup.c **** 		delay_250ns();
 160              		.loc 1 76 0
 161 006e FFF7FEFF 		bl	delay_250ns
 162              	.L8:
  72:Z:/Media/Documents/DAT017/game\startup.c **** 		delay_250ns();
 163              		.loc 1 72 0
 164 0072 7B68     		ldr	r3, [r7, #4]
 165 0074 5A1E     		subs	r2, r3, #1
 166 0076 7A60     		str	r2, [r7, #4]
 167 0078 002B     		cmp	r3, #0
 168 007a F2D1     		bne	.L9
  77:Z:/Media/Documents/DAT017/game\startup.c **** 	}
  78:Z:/Media/Documents/DAT017/game\startup.c **** }
 169              		.loc 1 78 0
 170 007c C046     		nop
 171 007e BD46     		mov	sp, r7
 172 0080 02B0     		add	sp, sp, #8
 173              		@ sp needed
 174 0082 80BD     		pop	{r7, pc}
 175              		.cfi_endproc
 176              	.LFE3:
 178              		.align	2
 179              		.global	delay_milli
 180              		.code	16
 181              		.thumb_func
 183              	delay_milli:
 184              	.LFB4:
  79:Z:/Media/Documents/DAT017/game\startup.c **** 
  80:Z:/Media/Documents/DAT017/game\startup.c **** void delay_milli(unsigned int ms) {
 185              		.loc 1 80 0
 186              		.cfi_startproc
 187 0084 80B5     		push	{r7, lr}
 188              		.cfi_def_cfa_offset 8
 189              		.cfi_offset 7, -8
 190              		.cfi_offset 14, -4
 191 0086 82B0     		sub	sp, sp, #8
 192              		.cfi_def_cfa_offset 16
 193 0088 00AF     		add	r7, sp, #0
 194              		.cfi_def_cfa_register 7
 195 008a 7860     		str	r0, [r7, #4]
  81:Z:/Media/Documents/DAT017/game\startup.c **** #ifdef SIMULATOR
  82:Z:/Media/Documents/DAT017/game\startup.c **** 	//delay_micro(1);
  83:Z:/Media/Documents/DAT017/game\startup.c **** 	return 0;
 196              		.loc 1 83 0
 197 008c C046     		nop
  84:Z:/Media/Documents/DAT017/game\startup.c **** #endif
  85:Z:/Media/Documents/DAT017/game\startup.c **** 	
  86:Z:/Media/Documents/DAT017/game\startup.c **** 	while(ms--) {
  87:Z:/Media/Documents/DAT017/game\startup.c **** 		delay_micro(1000);
  88:Z:/Media/Documents/DAT017/game\startup.c **** 	}
  89:Z:/Media/Documents/DAT017/game\startup.c **** }
 198              		.loc 1 89 0
 199 008e BD46     		mov	sp, r7
 200 0090 02B0     		add	sp, sp, #8
 201              		@ sp needed
 202 0092 80BD     		pop	{r7, pc}
 203              		.cfi_endproc
 204              	.LFE4:
 206              		.align	2
 207              		.code	16
 208              		.thumb_func
 210              	graphic_ctrl_bit_set:
 211              	.LFB5:
  90:Z:/Media/Documents/DAT017/game\startup.c **** 
  91:Z:/Media/Documents/DAT017/game\startup.c **** 
  92:Z:/Media/Documents/DAT017/game\startup.c **** static void graphic_ctrl_bit_set( unsigned char x ){
 212              		.loc 1 92 0
 213              		.cfi_startproc
 214 0094 80B5     		push	{r7, lr}
 215              		.cfi_def_cfa_offset 8
 216              		.cfi_offset 7, -8
 217              		.cfi_offset 14, -4
 218 0096 82B0     		sub	sp, sp, #8
 219              		.cfi_def_cfa_offset 16
 220 0098 00AF     		add	r7, sp, #0
 221              		.cfi_def_cfa_register 7
 222 009a 0200     		movs	r2, r0
 223 009c FB1D     		adds	r3, r7, #7
 224 009e 1A70     		strb	r2, [r3]
  93:Z:/Media/Documents/DAT017/game\startup.c **** 	*portOdrLow |= ( ~B_SELECT & x );
 225              		.loc 1 93 0
 226 00a0 094A     		ldr	r2, .L13
 227 00a2 094B     		ldr	r3, .L13
 228 00a4 1B78     		ldrb	r3, [r3]
 229 00a6 DBB2     		uxtb	r3, r3
 230 00a8 D9B2     		uxtb	r1, r3
 231 00aa FB1D     		adds	r3, r7, #7
 232 00ac 1B78     		ldrb	r3, [r3]
 233 00ae 181C     		adds	r0, r3, #0
 234 00b0 0423     		movs	r3, #4
 235 00b2 9843     		bics	r0, r3
 236 00b4 0300     		movs	r3, r0
 237 00b6 DBB2     		uxtb	r3, r3
 238 00b8 0B43     		orrs	r3, r1
 239 00ba DBB2     		uxtb	r3, r3
 240 00bc DBB2     		uxtb	r3, r3
 241 00be 1370     		strb	r3, [r2]
  94:Z:/Media/Documents/DAT017/game\startup.c **** }
 242              		.loc 1 94 0
 243 00c0 C046     		nop
 244 00c2 BD46     		mov	sp, r7
 245 00c4 02B0     		add	sp, sp, #8
 246              		@ sp needed
 247 00c6 80BD     		pop	{r7, pc}
 248              	.L14:
 249              		.align	2
 250              	.L13:
 251 00c8 14100240 		.word	1073877012
 252              		.cfi_endproc
 253              	.LFE5:
 255              		.align	2
 256              		.code	16
 257              		.thumb_func
 259              	graphic_ctrl_bit_clear:
 260              	.LFB6:
  95:Z:/Media/Documents/DAT017/game\startup.c **** static void graphic_ctrl_bit_clear( unsigned char x ){
 261              		.loc 1 95 0
 262              		.cfi_startproc
 263 00cc 80B5     		push	{r7, lr}
 264              		.cfi_def_cfa_offset 8
 265              		.cfi_offset 7, -8
 266              		.cfi_offset 14, -4
 267 00ce 82B0     		sub	sp, sp, #8
 268              		.cfi_def_cfa_offset 16
 269 00d0 00AF     		add	r7, sp, #0
 270              		.cfi_def_cfa_register 7
 271 00d2 0200     		movs	r2, r0
 272 00d4 FB1D     		adds	r3, r7, #7
 273 00d6 1A70     		strb	r2, [r3]
  96:Z:/Media/Documents/DAT017/game\startup.c **** 	*portOdrLow &= ( ~B_SELECT & ~x );
 274              		.loc 1 96 0
 275 00d8 0849     		ldr	r1, .L16
 276 00da 084B     		ldr	r3, .L16
 277 00dc 1B78     		ldrb	r3, [r3]
 278 00de DBB2     		uxtb	r3, r3
 279 00e0 FA1D     		adds	r2, r7, #7
 280 00e2 1278     		ldrb	r2, [r2]
 281 00e4 D243     		mvns	r2, r2
 282 00e6 D2B2     		uxtb	r2, r2
 283 00e8 1340     		ands	r3, r2
 284 00ea DBB2     		uxtb	r3, r3
 285 00ec 0422     		movs	r2, #4
 286 00ee 9343     		bics	r3, r2
 287 00f0 DBB2     		uxtb	r3, r3
 288 00f2 0B70     		strb	r3, [r1]
  97:Z:/Media/Documents/DAT017/game\startup.c **** }
 289              		.loc 1 97 0
 290 00f4 C046     		nop
 291 00f6 BD46     		mov	sp, r7
 292 00f8 02B0     		add	sp, sp, #8
 293              		@ sp needed
 294 00fa 80BD     		pop	{r7, pc}
 295              	.L17:
 296              		.align	2
 297              	.L16:
 298 00fc 14100240 		.word	1073877012
 299              		.cfi_endproc
 300              	.LFE6:
 302              		.align	2
 303              		.code	16
 304              		.thumb_func
 306              	select_controller:
 307              	.LFB7:
  98:Z:/Media/Documents/DAT017/game\startup.c **** static void select_controller(unsigned char controller){
 308              		.loc 1 98 0
 309              		.cfi_startproc
 310 0100 80B5     		push	{r7, lr}
 311              		.cfi_def_cfa_offset 8
 312              		.cfi_offset 7, -8
 313              		.cfi_offset 14, -4
 314 0102 82B0     		sub	sp, sp, #8
 315              		.cfi_def_cfa_offset 16
 316 0104 00AF     		add	r7, sp, #0
 317              		.cfi_def_cfa_register 7
 318 0106 0200     		movs	r2, r0
 319 0108 FB1D     		adds	r3, r7, #7
 320 010a 1A70     		strb	r2, [r3]
  99:Z:/Media/Documents/DAT017/game\startup.c **** 	
 100:Z:/Media/Documents/DAT017/game\startup.c **** 	switch(controller){
 321              		.loc 1 100 0
 322 010c FB1D     		adds	r3, r7, #7
 323 010e 1B78     		ldrb	r3, [r3]
 324 0110 082B     		cmp	r3, #8
 325 0112 0CD0     		beq	.L20
 326 0114 02DC     		bgt	.L21
 327 0116 002B     		cmp	r3, #0
 328 0118 05D0     		beq	.L22
 101:Z:/Media/Documents/DAT017/game\startup.c **** 		case 0:
 102:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_ctrl_bit_clear(B_CS1|B_CS2);
 103:Z:/Media/Documents/DAT017/game\startup.c **** 		break;
 104:Z:/Media/Documents/DAT017/game\startup.c **** 		case B_CS1 :
 105:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_ctrl_bit_set(B_CS1); graphic_ctrl_bit_clear(B_CS2);
 106:Z:/Media/Documents/DAT017/game\startup.c **** 		break;
 107:Z:/Media/Documents/DAT017/game\startup.c **** 		case B_CS2 :
 108:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_ctrl_bit_set(B_CS2); graphic_ctrl_bit_clear(B_CS1);
 109:Z:/Media/Documents/DAT017/game\startup.c **** 		break;
 110:Z:/Media/Documents/DAT017/game\startup.c **** 		case B_CS1|B_CS2 :
 111:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_ctrl_bit_set(B_CS1|B_CS2);
 112:Z:/Media/Documents/DAT017/game\startup.c **** 		break;
 113:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 114:Z:/Media/Documents/DAT017/game\startup.c **** }
 329              		.loc 1 114 0
 330 011a 1AE0     		b	.L25
 331              	.L21:
 100:Z:/Media/Documents/DAT017/game\startup.c **** 		case 0:
 332              		.loc 1 100 0
 333 011c 102B     		cmp	r3, #16
 334 011e 0DD0     		beq	.L23
 335 0120 182B     		cmp	r3, #24
 336 0122 12D0     		beq	.L24
 337              		.loc 1 114 0
 338 0124 15E0     		b	.L25
 339              	.L22:
 102:Z:/Media/Documents/DAT017/game\startup.c **** 		break;
 340              		.loc 1 102 0
 341 0126 1820     		movs	r0, #24
 342 0128 FFF7D0FF 		bl	graphic_ctrl_bit_clear
 103:Z:/Media/Documents/DAT017/game\startup.c **** 		case B_CS1 :
 343              		.loc 1 103 0
 344 012c 11E0     		b	.L19
 345              	.L20:
 105:Z:/Media/Documents/DAT017/game\startup.c **** 		break;
 346              		.loc 1 105 0
 347 012e 0820     		movs	r0, #8
 348 0130 FFF7B0FF 		bl	graphic_ctrl_bit_set
 349 0134 1020     		movs	r0, #16
 350 0136 FFF7C9FF 		bl	graphic_ctrl_bit_clear
 106:Z:/Media/Documents/DAT017/game\startup.c **** 		case B_CS2 :
 351              		.loc 1 106 0
 352 013a 0AE0     		b	.L19
 353              	.L23:
 108:Z:/Media/Documents/DAT017/game\startup.c **** 		break;
 354              		.loc 1 108 0
 355 013c 1020     		movs	r0, #16
 356 013e FFF7A9FF 		bl	graphic_ctrl_bit_set
 357 0142 0820     		movs	r0, #8
 358 0144 FFF7C2FF 		bl	graphic_ctrl_bit_clear
 109:Z:/Media/Documents/DAT017/game\startup.c **** 		case B_CS1|B_CS2 :
 359              		.loc 1 109 0
 360 0148 03E0     		b	.L19
 361              	.L24:
 111:Z:/Media/Documents/DAT017/game\startup.c **** 		break;
 362              		.loc 1 111 0
 363 014a 1820     		movs	r0, #24
 364 014c FFF7A2FF 		bl	graphic_ctrl_bit_set
 112:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 365              		.loc 1 112 0
 366 0150 C046     		nop
 367              	.L19:
 368              	.L25:
 369              		.loc 1 114 0
 370 0152 C046     		nop
 371 0154 BD46     		mov	sp, r7
 372 0156 02B0     		add	sp, sp, #8
 373              		@ sp needed
 374 0158 80BD     		pop	{r7, pc}
 375              		.cfi_endproc
 376              	.LFE7:
 378 015a C046     		.align	2
 379              		.code	16
 380              		.thumb_func
 382              	graphic_wait_ready:
 383              	.LFB8:
 115:Z:/Media/Documents/DAT017/game\startup.c **** 
 116:Z:/Media/Documents/DAT017/game\startup.c **** static void graphic_wait_ready(void){
 384              		.loc 1 116 0
 385              		.cfi_startproc
 386 015c 80B5     		push	{r7, lr}
 387              		.cfi_def_cfa_offset 8
 388              		.cfi_offset 7, -8
 389              		.cfi_offset 14, -4
 390 015e 82B0     		sub	sp, sp, #8
 391              		.cfi_def_cfa_offset 16
 392 0160 00AF     		add	r7, sp, #0
 393              		.cfi_def_cfa_register 7
 117:Z:/Media/Documents/DAT017/game\startup.c **** 	unsigned char c;
 118:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear( B_E );
 394              		.loc 1 118 0
 395 0162 4020     		movs	r0, #64
 396 0164 FFF7B2FF 		bl	graphic_ctrl_bit_clear
 119:Z:/Media/Documents/DAT017/game\startup.c **** 	*portModer = 0x00005555;
 397              		.loc 1 119 0
 398 0168 154B     		ldr	r3, .L32
 399 016a 164A     		ldr	r2, .L32+4
 400 016c 1A60     		str	r2, [r3]
 120:Z:/Media/Documents/DAT017/game\startup.c **** 	/* b15-8 are inputs,
 121:Z:/Media/Documents/DAT017/game\startup.c **** 	b7-0 are outputs */
 122:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear( B_DI );
 401              		.loc 1 122 0
 402 016e 0120     		movs	r0, #1
 403 0170 FFF7ACFF 		bl	graphic_ctrl_bit_clear
 123:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_set( B_RW );
 404              		.loc 1 123 0
 405 0174 0220     		movs	r0, #2
 406 0176 FFF78DFF 		bl	graphic_ctrl_bit_set
 124:Z:/Media/Documents/DAT017/game\startup.c **** 	delay_500ns();
 407              		.loc 1 124 0
 408 017a FFF7FEFF 		bl	delay_500ns
 409              	.L29:
 125:Z:/Media/Documents/DAT017/game\startup.c **** 	while(1){
 126:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_ctrl_bit_set( B_E );
 410              		.loc 1 126 0
 411 017e 4020     		movs	r0, #64
 412 0180 FFF788FF 		bl	graphic_ctrl_bit_set
 127:Z:/Media/Documents/DAT017/game\startup.c **** 		delay_500ns();
 413              		.loc 1 127 0
 414 0184 FFF7FEFF 		bl	delay_500ns
 128:Z:/Media/Documents/DAT017/game\startup.c **** 		c = *portIdrHigh & 0x80;
 415              		.loc 1 128 0
 416 0188 0F4B     		ldr	r3, .L32+8
 417 018a 1B78     		ldrb	r3, [r3]
 418 018c DAB2     		uxtb	r2, r3
 419 018e FB1D     		adds	r3, r7, #7
 420 0190 7F21     		movs	r1, #127
 421 0192 8A43     		bics	r2, r1
 422 0194 1A70     		strb	r2, [r3]
 129:Z:/Media/Documents/DAT017/game\startup.c **** 		if( c == 0 )break;
 423              		.loc 1 129 0
 424 0196 FB1D     		adds	r3, r7, #7
 425 0198 1B78     		ldrb	r3, [r3]
 426 019a 002B     		cmp	r3, #0
 427 019c 05D0     		beq	.L31
 130:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_ctrl_bit_clear( B_E );
 428              		.loc 1 130 0
 429 019e 4020     		movs	r0, #64
 430 01a0 FFF794FF 		bl	graphic_ctrl_bit_clear
 131:Z:/Media/Documents/DAT017/game\startup.c **** 		delay_500ns();
 431              		.loc 1 131 0
 432 01a4 FFF7FEFF 		bl	delay_500ns
 132:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 433              		.loc 1 132 0
 434 01a8 E9E7     		b	.L29
 435              	.L31:
 129:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_ctrl_bit_clear( B_E );
 436              		.loc 1 129 0
 437 01aa C046     		nop
 133:Z:/Media/Documents/DAT017/game\startup.c **** 	*portModer = 0x55555555;
 438              		.loc 1 133 0
 439 01ac 044B     		ldr	r3, .L32
 440 01ae 074A     		ldr	r2, .L32+12
 441 01b0 1A60     		str	r2, [r3]
 134:Z:/Media/Documents/DAT017/game\startup.c **** 	/* all bits outputs */
 135:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_set( B_E );
 442              		.loc 1 135 0
 443 01b2 4020     		movs	r0, #64
 444 01b4 FFF76EFF 		bl	graphic_ctrl_bit_set
 136:Z:/Media/Documents/DAT017/game\startup.c **** }
 445              		.loc 1 136 0
 446 01b8 C046     		nop
 447 01ba BD46     		mov	sp, r7
 448 01bc 02B0     		add	sp, sp, #8
 449              		@ sp needed
 450 01be 80BD     		pop	{r7, pc}
 451              	.L33:
 452              		.align	2
 453              	.L32:
 454 01c0 00100240 		.word	1073876992
 455 01c4 55550000 		.word	21845
 456 01c8 11100240 		.word	1073877009
 457 01cc 55555555 		.word	1431655765
 458              		.cfi_endproc
 459              	.LFE8:
 461              		.align	2
 462              		.code	16
 463              		.thumb_func
 465              	display_read:
 466              	.LFB9:
 137:Z:/Media/Documents/DAT017/game\startup.c **** 
 138:Z:/Media/Documents/DAT017/game\startup.c **** static unsigned char display_read(unsigned char controller){
 467              		.loc 1 138 0
 468              		.cfi_startproc
 469 01d0 80B5     		push	{r7, lr}
 470              		.cfi_def_cfa_offset 8
 471              		.cfi_offset 7, -8
 472              		.cfi_offset 14, -4
 473 01d2 84B0     		sub	sp, sp, #16
 474              		.cfi_def_cfa_offset 24
 475 01d4 00AF     		add	r7, sp, #0
 476              		.cfi_def_cfa_register 7
 477 01d6 0200     		movs	r2, r0
 478 01d8 FB1D     		adds	r3, r7, #7
 479 01da 1A70     		strb	r2, [r3]
 139:Z:/Media/Documents/DAT017/game\startup.c **** 	unsigned char c;
 140:Z:/Media/Documents/DAT017/game\startup.c **** 	*portModer = 0x00005555;
 480              		.loc 1 140 0
 481 01dc 1D4B     		ldr	r3, .L38
 482 01de 1E4A     		ldr	r2, .L38+4
 483 01e0 1A60     		str	r2, [r3]
 141:Z:/Media/Documents/DAT017/game\startup.c **** 	/* b15-8 are inputs, 7-0 are outputs */
 142:Z:/Media/Documents/DAT017/game\startup.c **** 	select_controller( controller );
 484              		.loc 1 142 0
 485 01e2 FB1D     		adds	r3, r7, #7
 486 01e4 1B78     		ldrb	r3, [r3]
 487 01e6 1800     		movs	r0, r3
 488 01e8 FFF78AFF 		bl	select_controller
 143:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear( B_E );
 489              		.loc 1 143 0
 490 01ec 4020     		movs	r0, #64
 491 01ee FFF76DFF 		bl	graphic_ctrl_bit_clear
 144:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_set( B_DI | B_RW );
 492              		.loc 1 144 0
 493 01f2 0320     		movs	r0, #3
 494 01f4 FFF74EFF 		bl	graphic_ctrl_bit_set
 145:Z:/Media/Documents/DAT017/game\startup.c **** 	delay_500ns();
 495              		.loc 1 145 0
 496 01f8 FFF7FEFF 		bl	delay_500ns
 146:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_set( B_E );
 497              		.loc 1 146 0
 498 01fc 4020     		movs	r0, #64
 499 01fe FFF749FF 		bl	graphic_ctrl_bit_set
 147:Z:/Media/Documents/DAT017/game\startup.c **** 	delay_500ns();
 500              		.loc 1 147 0
 501 0202 FFF7FEFF 		bl	delay_500ns
 148:Z:/Media/Documents/DAT017/game\startup.c **** 	c = *portIdrHigh;
 502              		.loc 1 148 0
 503 0206 154A     		ldr	r2, .L38+8
 504 0208 0F23     		movs	r3, #15
 505 020a FB18     		adds	r3, r7, r3
 506 020c 1278     		ldrb	r2, [r2]
 507 020e 1A70     		strb	r2, [r3]
 149:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear( B_E );
 508              		.loc 1 149 0
 509 0210 4020     		movs	r0, #64
 510 0212 FFF75BFF 		bl	graphic_ctrl_bit_clear
 150:Z:/Media/Documents/DAT017/game\startup.c **** 	*portModer = 0x55555555;
 511              		.loc 1 150 0
 512 0216 0F4B     		ldr	r3, .L38
 513 0218 114A     		ldr	r2, .L38+12
 514 021a 1A60     		str	r2, [r3]
 151:Z:/Media/Documents/DAT017/game\startup.c **** 	/* all bits outputs */
 152:Z:/Media/Documents/DAT017/game\startup.c **** 	
 153:Z:/Media/Documents/DAT017/game\startup.c **** 	if( controller & B_CS1 ){
 515              		.loc 1 153 0
 516 021c FB1D     		adds	r3, r7, #7
 517 021e 1B78     		ldrb	r3, [r3]
 518 0220 0822     		movs	r2, #8
 519 0222 1340     		ands	r3, r2
 520 0224 04D0     		beq	.L35
 154:Z:/Media/Documents/DAT017/game\startup.c **** 		select_controller( B_CS1);
 521              		.loc 1 154 0
 522 0226 0820     		movs	r0, #8
 523 0228 FFF76AFF 		bl	select_controller
 155:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_wait_ready();
 524              		.loc 1 155 0
 525 022c FFF796FF 		bl	graphic_wait_ready
 526              	.L35:
 156:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 157:Z:/Media/Documents/DAT017/game\startup.c **** 	if( controller & B_CS2 ){
 527              		.loc 1 157 0
 528 0230 FB1D     		adds	r3, r7, #7
 529 0232 1B78     		ldrb	r3, [r3]
 530 0234 1022     		movs	r2, #16
 531 0236 1340     		ands	r3, r2
 532 0238 04D0     		beq	.L36
 158:Z:/Media/Documents/DAT017/game\startup.c **** 		select_controller( B_CS2);
 533              		.loc 1 158 0
 534 023a 1020     		movs	r0, #16
 535 023c FFF760FF 		bl	select_controller
 159:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_wait_ready();
 536              		.loc 1 159 0
 537 0240 FFF78CFF 		bl	graphic_wait_ready
 538              	.L36:
 160:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 161:Z:/Media/Documents/DAT017/game\startup.c **** 	
 162:Z:/Media/Documents/DAT017/game\startup.c **** 	return c;
 539              		.loc 1 162 0
 540 0244 0F23     		movs	r3, #15
 541 0246 FB18     		adds	r3, r7, r3
 542 0248 1B78     		ldrb	r3, [r3]
 163:Z:/Media/Documents/DAT017/game\startup.c **** }
 543              		.loc 1 163 0
 544 024a 1800     		movs	r0, r3
 545 024c BD46     		mov	sp, r7
 546 024e 04B0     		add	sp, sp, #16
 547              		@ sp needed
 548 0250 80BD     		pop	{r7, pc}
 549              	.L39:
 550 0252 C046     		.align	2
 551              	.L38:
 552 0254 00100240 		.word	1073876992
 553 0258 55550000 		.word	21845
 554 025c 11100240 		.word	1073877009
 555 0260 55555555 		.word	1431655765
 556              		.cfi_endproc
 557              	.LFE9:
 559              		.align	2
 560              		.code	16
 561              		.thumb_func
 563              	graphic_read:
 564              	.LFB10:
 164:Z:/Media/Documents/DAT017/game\startup.c **** 
 165:Z:/Media/Documents/DAT017/game\startup.c **** //read display twice because hardware is stupid
 166:Z:/Media/Documents/DAT017/game\startup.c **** static unsigned char graphic_read(unsigned char controller){
 565              		.loc 1 166 0
 566              		.cfi_startproc
 567 0264 80B5     		push	{r7, lr}
 568              		.cfi_def_cfa_offset 8
 569              		.cfi_offset 7, -8
 570              		.cfi_offset 14, -4
 571 0266 82B0     		sub	sp, sp, #8
 572              		.cfi_def_cfa_offset 16
 573 0268 00AF     		add	r7, sp, #0
 574              		.cfi_def_cfa_register 7
 575 026a 0200     		movs	r2, r0
 576 026c FB1D     		adds	r3, r7, #7
 577 026e 1A70     		strb	r2, [r3]
 167:Z:/Media/Documents/DAT017/game\startup.c **** 	display_read(controller);
 578              		.loc 1 167 0
 579 0270 FB1D     		adds	r3, r7, #7
 580 0272 1B78     		ldrb	r3, [r3]
 581 0274 1800     		movs	r0, r3
 582 0276 FFF7ABFF 		bl	display_read
 168:Z:/Media/Documents/DAT017/game\startup.c **** 	return display_read(controller);
 583              		.loc 1 168 0
 584 027a FB1D     		adds	r3, r7, #7
 585 027c 1B78     		ldrb	r3, [r3]
 586 027e 1800     		movs	r0, r3
 587 0280 FFF7A6FF 		bl	display_read
 588 0284 0300     		movs	r3, r0
 169:Z:/Media/Documents/DAT017/game\startup.c **** }
 589              		.loc 1 169 0
 590 0286 1800     		movs	r0, r3
 591 0288 BD46     		mov	sp, r7
 592 028a 02B0     		add	sp, sp, #8
 593              		@ sp needed
 594 028c 80BD     		pop	{r7, pc}
 595              		.cfi_endproc
 596              	.LFE10:
 598 028e C046     		.align	2
 599              		.code	16
 600              		.thumb_func
 602              	graphic_write:
 603              	.LFB11:
 170:Z:/Media/Documents/DAT017/game\startup.c **** 
 171:Z:/Media/Documents/DAT017/game\startup.c **** static void graphic_write(unsigned char val, unsigned char controller){
 604              		.loc 1 171 0
 605              		.cfi_startproc
 606 0290 80B5     		push	{r7, lr}
 607              		.cfi_def_cfa_offset 8
 608              		.cfi_offset 7, -8
 609              		.cfi_offset 14, -4
 610 0292 82B0     		sub	sp, sp, #8
 611              		.cfi_def_cfa_offset 16
 612 0294 00AF     		add	r7, sp, #0
 613              		.cfi_def_cfa_register 7
 614 0296 0200     		movs	r2, r0
 615 0298 FB1D     		adds	r3, r7, #7
 616 029a 1A70     		strb	r2, [r3]
 617 029c BB1D     		adds	r3, r7, #6
 618 029e 0A1C     		adds	r2, r1, #0
 619 02a0 1A70     		strb	r2, [r3]
 172:Z:/Media/Documents/DAT017/game\startup.c **** 	*portOdrHigh = val;
 620              		.loc 1 172 0
 621 02a2 1A4A     		ldr	r2, .L45
 622 02a4 FB1D     		adds	r3, r7, #7
 623 02a6 1B78     		ldrb	r3, [r3]
 624 02a8 1370     		strb	r3, [r2]
 173:Z:/Media/Documents/DAT017/game\startup.c **** 	select_controller( controller );
 625              		.loc 1 173 0
 626 02aa BB1D     		adds	r3, r7, #6
 627 02ac 1B78     		ldrb	r3, [r3]
 628 02ae 1800     		movs	r0, r3
 629 02b0 FFF726FF 		bl	select_controller
 174:Z:/Media/Documents/DAT017/game\startup.c **** 	delay_500ns();
 630              		.loc 1 174 0
 631 02b4 FFF7FEFF 		bl	delay_500ns
 175:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_set( B_E );
 632              		.loc 1 175 0
 633 02b8 4020     		movs	r0, #64
 634 02ba FFF7EBFE 		bl	graphic_ctrl_bit_set
 176:Z:/Media/Documents/DAT017/game\startup.c **** 	delay_500ns();
 635              		.loc 1 176 0
 636 02be FFF7FEFF 		bl	delay_500ns
 177:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear( B_E ); 
 637              		.loc 1 177 0
 638 02c2 4020     		movs	r0, #64
 639 02c4 FFF702FF 		bl	graphic_ctrl_bit_clear
 178:Z:/Media/Documents/DAT017/game\startup.c **** 	if( controller & B_CS1 ){
 640              		.loc 1 178 0
 641 02c8 BB1D     		adds	r3, r7, #6
 642 02ca 1B78     		ldrb	r3, [r3]
 643 02cc 0822     		movs	r2, #8
 644 02ce 1340     		ands	r3, r2
 645 02d0 04D0     		beq	.L43
 179:Z:/Media/Documents/DAT017/game\startup.c **** 		select_controller( B_CS1);
 646              		.loc 1 179 0
 647 02d2 0820     		movs	r0, #8
 648 02d4 FFF714FF 		bl	select_controller
 180:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_wait_ready();
 649              		.loc 1 180 0
 650 02d8 FFF740FF 		bl	graphic_wait_ready
 651              	.L43:
 181:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 182:Z:/Media/Documents/DAT017/game\startup.c **** 	if( controller & B_CS2 ){
 652              		.loc 1 182 0
 653 02dc BB1D     		adds	r3, r7, #6
 654 02de 1B78     		ldrb	r3, [r3]
 655 02e0 1022     		movs	r2, #16
 656 02e2 1340     		ands	r3, r2
 657 02e4 04D0     		beq	.L44
 183:Z:/Media/Documents/DAT017/game\startup.c **** 		select_controller( B_CS2);
 658              		.loc 1 183 0
 659 02e6 1020     		movs	r0, #16
 660 02e8 FFF70AFF 		bl	select_controller
 184:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_wait_ready();
 661              		.loc 1 184 0
 662 02ec FFF736FF 		bl	graphic_wait_ready
 663              	.L44:
 185:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 186:Z:/Media/Documents/DAT017/game\startup.c **** 	*portOdrHigh = 0;
 664              		.loc 1 186 0
 665 02f0 064B     		ldr	r3, .L45
 666 02f2 0022     		movs	r2, #0
 667 02f4 1A70     		strb	r2, [r3]
 187:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_set( B_E );
 668              		.loc 1 187 0
 669 02f6 4020     		movs	r0, #64
 670 02f8 FFF7CCFE 		bl	graphic_ctrl_bit_set
 188:Z:/Media/Documents/DAT017/game\startup.c **** 	select_controller( 0 );
 671              		.loc 1 188 0
 672 02fc 0020     		movs	r0, #0
 673 02fe FFF7FFFE 		bl	select_controller
 189:Z:/Media/Documents/DAT017/game\startup.c **** }
 674              		.loc 1 189 0
 675 0302 C046     		nop
 676 0304 BD46     		mov	sp, r7
 677 0306 02B0     		add	sp, sp, #8
 678              		@ sp needed
 679 0308 80BD     		pop	{r7, pc}
 680              	.L46:
 681 030a C046     		.align	2
 682              	.L45:
 683 030c 15100240 		.word	1073877013
 684              		.cfi_endproc
 685              	.LFE11:
 687              		.align	2
 688              		.code	16
 689              		.thumb_func
 691              	graphic_writeCommand:
 692              	.LFB12:
 190:Z:/Media/Documents/DAT017/game\startup.c **** 
 191:Z:/Media/Documents/DAT017/game\startup.c **** static void graphic_writeCommand(unsigned char commandToWrite, unsigned char controller){
 693              		.loc 1 191 0
 694              		.cfi_startproc
 695 0310 80B5     		push	{r7, lr}
 696              		.cfi_def_cfa_offset 8
 697              		.cfi_offset 7, -8
 698              		.cfi_offset 14, -4
 699 0312 82B0     		sub	sp, sp, #8
 700              		.cfi_def_cfa_offset 16
 701 0314 00AF     		add	r7, sp, #0
 702              		.cfi_def_cfa_register 7
 703 0316 0200     		movs	r2, r0
 704 0318 FB1D     		adds	r3, r7, #7
 705 031a 1A70     		strb	r2, [r3]
 706 031c BB1D     		adds	r3, r7, #6
 707 031e 0A1C     		adds	r2, r1, #0
 708 0320 1A70     		strb	r2, [r3]
 192:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear( B_E );
 709              		.loc 1 192 0
 710 0322 4020     		movs	r0, #64
 711 0324 FFF7D2FE 		bl	graphic_ctrl_bit_clear
 193:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear( B_DI | B_RW );
 712              		.loc 1 193 0
 713 0328 0320     		movs	r0, #3
 714 032a FFF7CFFE 		bl	graphic_ctrl_bit_clear
 194:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_write(commandToWrite, controller);
 715              		.loc 1 194 0
 716 032e BB1D     		adds	r3, r7, #6
 717 0330 1A78     		ldrb	r2, [r3]
 718 0332 FB1D     		adds	r3, r7, #7
 719 0334 1B78     		ldrb	r3, [r3]
 720 0336 1100     		movs	r1, r2
 721 0338 1800     		movs	r0, r3
 722 033a FFF7A9FF 		bl	graphic_write
 195:Z:/Media/Documents/DAT017/game\startup.c **** }
 723              		.loc 1 195 0
 724 033e C046     		nop
 725 0340 BD46     		mov	sp, r7
 726 0342 02B0     		add	sp, sp, #8
 727              		@ sp needed
 728 0344 80BD     		pop	{r7, pc}
 729              		.cfi_endproc
 730              	.LFE12:
 732 0346 C046     		.align	2
 733              		.code	16
 734              		.thumb_func
 736              	graphic_writeData:
 737              	.LFB13:
 196:Z:/Media/Documents/DAT017/game\startup.c **** 
 197:Z:/Media/Documents/DAT017/game\startup.c **** static void graphic_writeData(unsigned char data, unsigned char controller){
 738              		.loc 1 197 0
 739              		.cfi_startproc
 740 0348 80B5     		push	{r7, lr}
 741              		.cfi_def_cfa_offset 8
 742              		.cfi_offset 7, -8
 743              		.cfi_offset 14, -4
 744 034a 82B0     		sub	sp, sp, #8
 745              		.cfi_def_cfa_offset 16
 746 034c 00AF     		add	r7, sp, #0
 747              		.cfi_def_cfa_register 7
 748 034e 0200     		movs	r2, r0
 749 0350 FB1D     		adds	r3, r7, #7
 750 0352 1A70     		strb	r2, [r3]
 751 0354 BB1D     		adds	r3, r7, #6
 752 0356 0A1C     		adds	r2, r1, #0
 753 0358 1A70     		strb	r2, [r3]
 198:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear( B_E );
 754              		.loc 1 198 0
 755 035a 4020     		movs	r0, #64
 756 035c FFF7B6FE 		bl	graphic_ctrl_bit_clear
 199:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_set( B_DI );
 757              		.loc 1 199 0
 758 0360 0120     		movs	r0, #1
 759 0362 FFF797FE 		bl	graphic_ctrl_bit_set
 200:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear( B_RW );
 760              		.loc 1 200 0
 761 0366 0220     		movs	r0, #2
 762 0368 FFF7B0FE 		bl	graphic_ctrl_bit_clear
 201:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_write(data, controller);
 763              		.loc 1 201 0
 764 036c BB1D     		adds	r3, r7, #6
 765 036e 1A78     		ldrb	r2, [r3]
 766 0370 FB1D     		adds	r3, r7, #7
 767 0372 1B78     		ldrb	r3, [r3]
 768 0374 1100     		movs	r1, r2
 769 0376 1800     		movs	r0, r3
 770 0378 FFF78AFF 		bl	graphic_write
 202:Z:/Media/Documents/DAT017/game\startup.c **** }
 771              		.loc 1 202 0
 772 037c C046     		nop
 773 037e BD46     		mov	sp, r7
 774 0380 02B0     		add	sp, sp, #8
 775              		@ sp needed
 776 0382 80BD     		pop	{r7, pc}
 777              		.cfi_endproc
 778              	.LFE13:
 780              		.align	2
 781              		.global	graphic_initalize
 782              		.code	16
 783              		.thumb_func
 785              	graphic_initalize:
 786              	.LFB14:
 203:Z:/Media/Documents/DAT017/game\startup.c **** 
 204:Z:/Media/Documents/DAT017/game\startup.c **** void graphic_initalize(void){
 787              		.loc 1 204 0
 788              		.cfi_startproc
 789 0384 80B5     		push	{r7, lr}
 790              		.cfi_def_cfa_offset 8
 791              		.cfi_offset 7, -8
 792              		.cfi_offset 14, -4
 793 0386 00AF     		add	r7, sp, #0
 794              		.cfi_def_cfa_register 7
 205:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_set( B_E );
 795              		.loc 1 205 0
 796 0388 4020     		movs	r0, #64
 797 038a FFF783FE 		bl	graphic_ctrl_bit_set
 206:Z:/Media/Documents/DAT017/game\startup.c **** 	delay_micro(10);
 798              		.loc 1 206 0
 799 038e 0A20     		movs	r0, #10
 800 0390 FFF7FEFF 		bl	delay_micro
 207:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_clear(B_CS1|B_CS2|B_RST|B_E);
 801              		.loc 1 207 0
 802 0394 7820     		movs	r0, #120
 803 0396 FFF799FE 		bl	graphic_ctrl_bit_clear
 208:Z:/Media/Documents/DAT017/game\startup.c **** 	delay_milli( 30 );
 804              		.loc 1 208 0
 805 039a 1E20     		movs	r0, #30
 806 039c FFF7FEFF 		bl	delay_milli
 209:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_ctrl_bit_set(B_RST);
 807              		.loc 1 209 0
 808 03a0 2020     		movs	r0, #32
 809 03a2 FFF777FE 		bl	graphic_ctrl_bit_set
 210:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_writeCommand(LCD_OFF, B_CS1|B_CS2);
 810              		.loc 1 210 0
 811 03a6 1821     		movs	r1, #24
 812 03a8 3E20     		movs	r0, #62
 813 03aa FFF7B1FF 		bl	graphic_writeCommand
 211:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_writeCommand(LCD_ON, B_CS1|B_CS2);
 814              		.loc 1 211 0
 815 03ae 1821     		movs	r1, #24
 816 03b0 3F20     		movs	r0, #63
 817 03b2 FFF7ADFF 		bl	graphic_writeCommand
 212:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_writeCommand(LCD_DISP_START, B_CS1|B_CS2);
 818              		.loc 1 212 0
 819 03b6 1821     		movs	r1, #24
 820 03b8 C020     		movs	r0, #192
 821 03ba FFF7A9FF 		bl	graphic_writeCommand
 213:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_writeCommand(LCD_SET_ADD, B_CS1|B_CS2);
 822              		.loc 1 213 0
 823 03be 1821     		movs	r1, #24
 824 03c0 4020     		movs	r0, #64
 825 03c2 FFF7A5FF 		bl	graphic_writeCommand
 214:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_writeCommand(LCD_SET_PAGE, B_CS1|B_CS2);
 826              		.loc 1 214 0
 827 03c6 1821     		movs	r1, #24
 828 03c8 B820     		movs	r0, #184
 829 03ca FFF7A1FF 		bl	graphic_writeCommand
 215:Z:/Media/Documents/DAT017/game\startup.c **** 	select_controller(0);
 830              		.loc 1 215 0
 831 03ce 0020     		movs	r0, #0
 832 03d0 FFF796FE 		bl	select_controller
 216:Z:/Media/Documents/DAT017/game\startup.c **** }
 833              		.loc 1 216 0
 834 03d4 C046     		nop
 835 03d6 BD46     		mov	sp, r7
 836              		@ sp needed
 837 03d8 80BD     		pop	{r7, pc}
 838              		.cfi_endproc
 839              	.LFE14:
 841 03da C046     		.align	2
 842              		.global	graphic_clearScreen
 843              		.code	16
 844              		.thumb_func
 846              	graphic_clearScreen:
 847              	.LFB15:
 217:Z:/Media/Documents/DAT017/game\startup.c **** 
 218:Z:/Media/Documents/DAT017/game\startup.c **** void graphic_clearScreen(void){
 848              		.loc 1 218 0
 849              		.cfi_startproc
 850 03dc 80B5     		push	{r7, lr}
 851              		.cfi_def_cfa_offset 8
 852              		.cfi_offset 7, -8
 853              		.cfi_offset 14, -4
 854 03de 82B0     		sub	sp, sp, #8
 855              		.cfi_def_cfa_offset 16
 856 03e0 00AF     		add	r7, sp, #0
 857              		.cfi_def_cfa_register 7
 219:Z:/Media/Documents/DAT017/game\startup.c **** 	unsigned char i, j;
 220:Z:/Media/Documents/DAT017/game\startup.c **** 	for(j = 0; j < 8; j++){
 858              		.loc 1 220 0
 859 03e2 BB1D     		adds	r3, r7, #6
 860 03e4 0022     		movs	r2, #0
 861 03e6 1A70     		strb	r2, [r3]
 862 03e8 23E0     		b	.L51
 863              	.L54:
 221:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_writeCommand(LCD_SET_PAGE | j, B_CS1|B_CS2 );
 864              		.loc 1 221 0
 865 03ea BB1D     		adds	r3, r7, #6
 866 03ec 1B78     		ldrb	r3, [r3]
 867 03ee 4822     		movs	r2, #72
 868 03f0 5242     		rsbs	r2, r2, #0
 869 03f2 1343     		orrs	r3, r2
 870 03f4 DBB2     		uxtb	r3, r3
 871 03f6 1821     		movs	r1, #24
 872 03f8 1800     		movs	r0, r3
 873 03fa FFF789FF 		bl	graphic_writeCommand
 222:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_writeCommand(LCD_SET_ADD | 0, B_CS1|B_CS2 );
 874              		.loc 1 222 0
 875 03fe 1821     		movs	r1, #24
 876 0400 4020     		movs	r0, #64
 877 0402 FFF785FF 		bl	graphic_writeCommand
 223:Z:/Media/Documents/DAT017/game\startup.c **** 		for(i = 0; i <= 63; i++){
 878              		.loc 1 223 0
 879 0406 FB1D     		adds	r3, r7, #7
 880 0408 0022     		movs	r2, #0
 881 040a 1A70     		strb	r2, [r3]
 882 040c 08E0     		b	.L52
 883              	.L53:
 224:Z:/Media/Documents/DAT017/game\startup.c **** 			graphic_writeData(0, B_CS1|B_CS2);
 884              		.loc 1 224 0 discriminator 3
 885 040e 1821     		movs	r1, #24
 886 0410 0020     		movs	r0, #0
 887 0412 FFF799FF 		bl	graphic_writeData
 223:Z:/Media/Documents/DAT017/game\startup.c **** 		for(i = 0; i <= 63; i++){
 888              		.loc 1 223 0 discriminator 3
 889 0416 FB1D     		adds	r3, r7, #7
 890 0418 1A78     		ldrb	r2, [r3]
 891 041a FB1D     		adds	r3, r7, #7
 892 041c 0132     		adds	r2, r2, #1
 893 041e 1A70     		strb	r2, [r3]
 894              	.L52:
 223:Z:/Media/Documents/DAT017/game\startup.c **** 		for(i = 0; i <= 63; i++){
 895              		.loc 1 223 0 is_stmt 0 discriminator 1
 896 0420 FB1D     		adds	r3, r7, #7
 897 0422 1B78     		ldrb	r3, [r3]
 898 0424 3F2B     		cmp	r3, #63
 899 0426 F2D9     		bls	.L53
 220:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_writeCommand(LCD_SET_PAGE | j, B_CS1|B_CS2 );
 900              		.loc 1 220 0 is_stmt 1 discriminator 2
 901 0428 BB1D     		adds	r3, r7, #6
 902 042a 1A78     		ldrb	r2, [r3]
 903 042c BB1D     		adds	r3, r7, #6
 904 042e 0132     		adds	r2, r2, #1
 905 0430 1A70     		strb	r2, [r3]
 906              	.L51:
 220:Z:/Media/Documents/DAT017/game\startup.c **** 		graphic_writeCommand(LCD_SET_PAGE | j, B_CS1|B_CS2 );
 907              		.loc 1 220 0 is_stmt 0 discriminator 1
 908 0432 BB1D     		adds	r3, r7, #6
 909 0434 1B78     		ldrb	r3, [r3]
 910 0436 072B     		cmp	r3, #7
 911 0438 D7D9     		bls	.L54
 225:Z:/Media/Documents/DAT017/game\startup.c **** 		}
 226:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 227:Z:/Media/Documents/DAT017/game\startup.c **** }
 912              		.loc 1 227 0 is_stmt 1
 913 043a C046     		nop
 914 043c BD46     		mov	sp, r7
 915 043e 02B0     		add	sp, sp, #8
 916              		@ sp needed
 917 0440 80BD     		pop	{r7, pc}
 918              		.cfi_endproc
 919              	.LFE15:
 921              		.comm	frameBuffer0,1024,4
 922              		.comm	frameBuffer1,1024,4
 923              		.global	frontBuffer
 924              		.data
 925              		.align	2
 928              	frontBuffer:
 929 0000 00000000 		.word	frameBuffer0
 930              		.global	backBuffer
 931              		.align	2
 934              	backBuffer:
 935 0004 00000000 		.word	frameBuffer1
 936              		.text
 937 0442 C046     		.align	2
 938              		.global	graphic_drawScreen
 939              		.code	16
 940              		.thumb_func
 942              	graphic_drawScreen:
 943              	.LFB16:
 228:Z:/Media/Documents/DAT017/game\startup.c **** 
 229:Z:/Media/Documents/DAT017/game\startup.c **** 
 230:Z:/Media/Documents/DAT017/game\startup.c **** unsigned char frameBuffer0[1024], frameBuffer1[1024];		
 231:Z:/Media/Documents/DAT017/game\startup.c **** unsigned char *frontBuffer = frameBuffer0;	
 232:Z:/Media/Documents/DAT017/game\startup.c **** unsigned char *backBuffer =	frameBuffer1;
 233:Z:/Media/Documents/DAT017/game\startup.c **** 
 234:Z:/Media/Documents/DAT017/game\startup.c **** void graphic_drawScreen(void){
 944              		.loc 1 234 0
 945              		.cfi_startproc
 946 0444 80B5     		push	{r7, lr}
 947              		.cfi_def_cfa_offset 8
 948              		.cfi_offset 7, -8
 949              		.cfi_offset 14, -4
 950 0446 84B0     		sub	sp, sp, #16
 951              		.cfi_def_cfa_offset 24
 952 0448 00AF     		add	r7, sp, #0
 953              		.cfi_def_cfa_register 7
 235:Z:/Media/Documents/DAT017/game\startup.c ****     unsigned int k = 0;
 954              		.loc 1 235 0
 955 044a 0023     		movs	r3, #0
 956 044c FB60     		str	r3, [r7, #12]
 236:Z:/Media/Documents/DAT017/game\startup.c ****     bool bUpdateAddr = true;
 957              		.loc 1 236 0
 958 044e 0B23     		movs	r3, #11
 959 0450 FB18     		adds	r3, r7, r3
 960 0452 0122     		movs	r2, #1
 961 0454 1A70     		strb	r2, [r3]
 962              	.LBB2:
 237:Z:/Media/Documents/DAT017/game\startup.c ****     for(uint8 c = 0; c < 2; c++) { //	loop	over	both	controllers	(the	two	displays)
 963              		.loc 1 237 0
 964 0456 0A23     		movs	r3, #10
 965 0458 FB18     		adds	r3, r7, r3
 966 045a 0022     		movs	r2, #0
 967 045c 1A70     		strb	r2, [r3]
 968 045e 79E0     		b	.L56
 969              	.L66:
 970              	.LBB3:
 238:Z:/Media/Documents/DAT017/game\startup.c **** 		uint8 controller = (c == 0) ? B_CS1 : B_CS2;
 971              		.loc 1 238 0
 972 0460 0A23     		movs	r3, #10
 973 0462 FB18     		adds	r3, r7, r3
 974 0464 1B78     		ldrb	r3, [r3]
 975 0466 002B     		cmp	r3, #0
 976 0468 01D1     		bne	.L57
 977              		.loc 1 238 0 is_stmt 0 discriminator 1
 978 046a 0822     		movs	r2, #8
 979 046c 00E0     		b	.L58
 980              	.L57:
 981              		.loc 1 238 0 discriminator 2
 982 046e 1022     		movs	r2, #16
 983              	.L58:
 984              		.loc 1 238 0 discriminator 4
 985 0470 FB1D     		adds	r3, r7, #7
 986 0472 1A70     		strb	r2, [r3]
 987              	.LBB4:
 239:Z:/Media/Documents/DAT017/game\startup.c **** 		for(uint8 j = 0; j < 8; j++) { //	loop	over	pages
 988              		.loc 1 239 0 is_stmt 1 discriminator 4
 989 0474 0923     		movs	r3, #9
 990 0476 FB18     		adds	r3, r7, r3
 991 0478 0022     		movs	r2, #0
 992 047a 1A70     		strb	r2, [r3]
 993 047c 5EE0     		b	.L59
 994              	.L65:
 240:Z:/Media/Documents/DAT017/game\startup.c **** 			graphic_writeCommand(LCD_SET_PAGE | j, controller);
 995              		.loc 1 240 0
 996 047e 0923     		movs	r3, #9
 997 0480 FB18     		adds	r3, r7, r3
 998 0482 1B78     		ldrb	r3, [r3]
 999 0484 4822     		movs	r2, #72
 1000 0486 5242     		rsbs	r2, r2, #0
 1001 0488 1343     		orrs	r3, r2
 1002 048a DAB2     		uxtb	r2, r3
 1003 048c FB1D     		adds	r3, r7, #7
 1004 048e 1B78     		ldrb	r3, [r3]
 1005 0490 1900     		movs	r1, r3
 1006 0492 1000     		movs	r0, r2
 1007 0494 FFF73CFF 		bl	graphic_writeCommand
 241:Z:/Media/Documents/DAT017/game\startup.c **** 			graphic_writeCommand(LCD_SET_ADD | 0, controller);
 1008              		.loc 1 241 0
 1009 0498 FB1D     		adds	r3, r7, #7
 1010 049a 1B78     		ldrb	r3, [r3]
 1011 049c 1900     		movs	r1, r3
 1012 049e 4020     		movs	r0, #64
 1013 04a0 FFF736FF 		bl	graphic_writeCommand
 1014              	.LBB5:
 242:Z:/Media/Documents/DAT017/game\startup.c **** 			for(uint8 i = 0; i <= 63; i++, k++) { //	loop	over	addresses
 1015              		.loc 1 242 0
 1016 04a4 0823     		movs	r3, #8
 1017 04a6 FB18     		adds	r3, r7, r3
 1018 04a8 0022     		movs	r2, #0
 1019 04aa 1A70     		strb	r2, [r3]
 1020 04ac 3AE0     		b	.L60
 1021              	.L64:
 243:Z:/Media/Documents/DAT017/game\startup.c **** 			//	update	display	only	where	it	is	different	from	last	frame
 244:Z:/Media/Documents/DAT017/game\startup.c **** 			if(backBuffer[k] != frontBuffer[k]) {
 1022              		.loc 1 244 0
 1023 04ae 2E4B     		ldr	r3, .L67
 1024 04b0 1A68     		ldr	r2, [r3]
 1025 04b2 FB68     		ldr	r3, [r7, #12]
 1026 04b4 D318     		adds	r3, r2, r3
 1027 04b6 1A78     		ldrb	r2, [r3]
 1028 04b8 2C4B     		ldr	r3, .L67+4
 1029 04ba 1968     		ldr	r1, [r3]
 1030 04bc FB68     		ldr	r3, [r7, #12]
 1031 04be CB18     		adds	r3, r1, r3
 1032 04c0 1B78     		ldrb	r3, [r3]
 1033 04c2 9A42     		cmp	r2, r3
 1034 04c4 20D0     		beq	.L61
 245:Z:/Media/Documents/DAT017/game\startup.c **** 				if(bUpdateAddr)
 1035              		.loc 1 245 0
 1036 04c6 0B23     		movs	r3, #11
 1037 04c8 FB18     		adds	r3, r7, r3
 1038 04ca 1B78     		ldrb	r3, [r3]
 1039 04cc 002B     		cmp	r3, #0
 1040 04ce 0BD0     		beq	.L62
 246:Z:/Media/Documents/DAT017/game\startup.c **** 				graphic_writeCommand(LCD_SET_ADD | i, controller);
 1041              		.loc 1 246 0
 1042 04d0 0823     		movs	r3, #8
 1043 04d2 FB18     		adds	r3, r7, r3
 1044 04d4 1B78     		ldrb	r3, [r3]
 1045 04d6 4022     		movs	r2, #64
 1046 04d8 1343     		orrs	r3, r2
 1047 04da DAB2     		uxtb	r2, r3
 1048 04dc FB1D     		adds	r3, r7, #7
 1049 04de 1B78     		ldrb	r3, [r3]
 1050 04e0 1900     		movs	r1, r3
 1051 04e2 1000     		movs	r0, r2
 1052 04e4 FFF714FF 		bl	graphic_writeCommand
 1053              	.L62:
 247:Z:/Media/Documents/DAT017/game\startup.c **** 				graphic_writeData(backBuffer[k], controller);
 1054              		.loc 1 247 0
 1055 04e8 1F4B     		ldr	r3, .L67
 1056 04ea 1A68     		ldr	r2, [r3]
 1057 04ec FB68     		ldr	r3, [r7, #12]
 1058 04ee D318     		adds	r3, r2, r3
 1059 04f0 1A78     		ldrb	r2, [r3]
 1060 04f2 FB1D     		adds	r3, r7, #7
 1061 04f4 1B78     		ldrb	r3, [r3]
 1062 04f6 1900     		movs	r1, r3
 1063 04f8 1000     		movs	r0, r2
 1064 04fa FFF725FF 		bl	graphic_writeData
 248:Z:/Media/Documents/DAT017/game\startup.c **** 				bUpdateAddr = false; //	Display	hardware	auto-increments	the	address	per	write
 1065              		.loc 1 248 0
 1066 04fe 0B23     		movs	r3, #11
 1067 0500 FB18     		adds	r3, r7, r3
 1068 0502 0022     		movs	r2, #0
 1069 0504 1A70     		strb	r2, [r3]
 1070 0506 03E0     		b	.L63
 1071              	.L61:
 249:Z:/Media/Documents/DAT017/game\startup.c **** 			} else
 250:Z:/Media/Documents/DAT017/game\startup.c **** 				bUpdateAddr = true; //	No	write	->	we	need	to	update	the
 1072              		.loc 1 250 0
 1073 0508 0B23     		movs	r3, #11
 1074 050a FB18     		adds	r3, r7, r3
 1075 050c 0122     		movs	r2, #1
 1076 050e 1A70     		strb	r2, [r3]
 1077              	.L63:
 242:Z:/Media/Documents/DAT017/game\startup.c **** 			//	update	display	only	where	it	is	different	from	last	frame
 1078              		.loc 1 242 0 discriminator 2
 1079 0510 0823     		movs	r3, #8
 1080 0512 FB18     		adds	r3, r7, r3
 1081 0514 1A78     		ldrb	r2, [r3]
 1082 0516 0823     		movs	r3, #8
 1083 0518 FB18     		adds	r3, r7, r3
 1084 051a 0132     		adds	r2, r2, #1
 1085 051c 1A70     		strb	r2, [r3]
 1086 051e FB68     		ldr	r3, [r7, #12]
 1087 0520 0133     		adds	r3, r3, #1
 1088 0522 FB60     		str	r3, [r7, #12]
 1089              	.L60:
 242:Z:/Media/Documents/DAT017/game\startup.c **** 			//	update	display	only	where	it	is	different	from	last	frame
 1090              		.loc 1 242 0 is_stmt 0 discriminator 1
 1091 0524 0823     		movs	r3, #8
 1092 0526 FB18     		adds	r3, r7, r3
 1093 0528 1B78     		ldrb	r3, [r3]
 1094 052a 3F2B     		cmp	r3, #63
 1095 052c BFD9     		bls	.L64
 1096              	.LBE5:
 239:Z:/Media/Documents/DAT017/game\startup.c **** 			graphic_writeCommand(LCD_SET_PAGE | j, controller);
 1097              		.loc 1 239 0 is_stmt 1 discriminator 2
 1098 052e 0923     		movs	r3, #9
 1099 0530 FB18     		adds	r3, r7, r3
 1100 0532 1A78     		ldrb	r2, [r3]
 1101 0534 0923     		movs	r3, #9
 1102 0536 FB18     		adds	r3, r7, r3
 1103 0538 0132     		adds	r2, r2, #1
 1104 053a 1A70     		strb	r2, [r3]
 1105              	.L59:
 239:Z:/Media/Documents/DAT017/game\startup.c **** 			graphic_writeCommand(LCD_SET_PAGE | j, controller);
 1106              		.loc 1 239 0 is_stmt 0 discriminator 1
 1107 053c 0923     		movs	r3, #9
 1108 053e FB18     		adds	r3, r7, r3
 1109 0540 1B78     		ldrb	r3, [r3]
 1110 0542 072B     		cmp	r3, #7
 1111 0544 9BD9     		bls	.L65
 1112              	.LBE4:
 1113              	.LBE3:
 237:Z:/Media/Documents/DAT017/game\startup.c **** 		uint8 controller = (c == 0) ? B_CS1 : B_CS2;
 1114              		.loc 1 237 0 is_stmt 1 discriminator 2
 1115 0546 0A23     		movs	r3, #10
 1116 0548 FB18     		adds	r3, r7, r3
 1117 054a 1A78     		ldrb	r2, [r3]
 1118 054c 0A23     		movs	r3, #10
 1119 054e FB18     		adds	r3, r7, r3
 1120 0550 0132     		adds	r2, r2, #1
 1121 0552 1A70     		strb	r2, [r3]
 1122              	.L56:
 237:Z:/Media/Documents/DAT017/game\startup.c **** 		uint8 controller = (c == 0) ? B_CS1 : B_CS2;
 1123              		.loc 1 237 0 is_stmt 0 discriminator 1
 1124 0554 0A23     		movs	r3, #10
 1125 0556 FB18     		adds	r3, r7, r3
 1126 0558 1B78     		ldrb	r3, [r3]
 1127 055a 012B     		cmp	r3, #1
 1128 055c 80D9     		bls	.L66
 1129              	.LBE2:
 251:Z:/Media/Documents/DAT017/game\startup.c **** 			// x-address	next	write
 252:Z:/Media/Documents/DAT017/game\startup.c **** 			}
 253:Z:/Media/Documents/DAT017/game\startup.c **** 		}
 254:Z:/Media/Documents/DAT017/game\startup.c ****     }
 255:Z:/Media/Documents/DAT017/game\startup.c **** }
 1130              		.loc 1 255 0 is_stmt 1
 1131 055e C046     		nop
 1132 0560 BD46     		mov	sp, r7
 1133 0562 04B0     		add	sp, sp, #16
 1134              		@ sp needed
 1135 0564 80BD     		pop	{r7, pc}
 1136              	.L68:
 1137 0566 C046     		.align	2
 1138              	.L67:
 1139 0568 00000000 		.word	backBuffer
 1140 056c 00000000 		.word	frontBuffer
 1141              		.cfi_endproc
 1142              	.LFE16:
 1144              		.align	2
 1145              		.global	clearBuffer
 1146              		.code	16
 1147              		.thumb_func
 1149              	clearBuffer:
 1150              	.LFB17:
 256:Z:/Media/Documents/DAT017/game\startup.c **** 
 257:Z:/Media/Documents/DAT017/game\startup.c **** 
 258:Z:/Media/Documents/DAT017/game\startup.c **** void clearBuffer(unsigned char val){	
 1151              		.loc 1 258 0
 1152              		.cfi_startproc
 1153 0570 80B5     		push	{r7, lr}
 1154              		.cfi_def_cfa_offset 8
 1155              		.cfi_offset 7, -8
 1156              		.cfi_offset 14, -4
 1157 0572 84B0     		sub	sp, sp, #16
 1158              		.cfi_def_cfa_offset 24
 1159 0574 00AF     		add	r7, sp, #0
 1160              		.cfi_def_cfa_register 7
 1161 0576 0200     		movs	r2, r0
 1162 0578 FB1D     		adds	r3, r7, #7
 1163 057a 1A70     		strb	r2, [r3]
 1164              	.LBB6:
 259:Z:/Media/Documents/DAT017/game\startup.c **** 	for	(int i=0; i<1024; i++)	
 1165              		.loc 1 259 0
 1166 057c 0023     		movs	r3, #0
 1167 057e FB60     		str	r3, [r7, #12]
 1168 0580 09E0     		b	.L70
 1169              	.L71:
 260:Z:/Media/Documents/DAT017/game\startup.c **** 		backBuffer[i] =	val;	
 1170              		.loc 1 260 0 discriminator 3
 1171 0582 094B     		ldr	r3, .L72
 1172 0584 1A68     		ldr	r2, [r3]
 1173 0586 FB68     		ldr	r3, [r7, #12]
 1174 0588 D318     		adds	r3, r2, r3
 1175 058a FA1D     		adds	r2, r7, #7
 1176 058c 1278     		ldrb	r2, [r2]
 1177 058e 1A70     		strb	r2, [r3]
 259:Z:/Media/Documents/DAT017/game\startup.c **** 	for	(int i=0; i<1024; i++)	
 1178              		.loc 1 259 0 discriminator 3
 1179 0590 FB68     		ldr	r3, [r7, #12]
 1180 0592 0133     		adds	r3, r3, #1
 1181 0594 FB60     		str	r3, [r7, #12]
 1182              	.L70:
 259:Z:/Media/Documents/DAT017/game\startup.c **** 	for	(int i=0; i<1024; i++)	
 1183              		.loc 1 259 0 is_stmt 0 discriminator 1
 1184 0596 FB68     		ldr	r3, [r7, #12]
 1185 0598 044A     		ldr	r2, .L72+4
 1186 059a 9342     		cmp	r3, r2
 1187 059c F1DD     		ble	.L71
 1188              	.LBE6:
 261:Z:/Media/Documents/DAT017/game\startup.c **** }
 1189              		.loc 1 261 0 is_stmt 1
 1190 059e C046     		nop
 1191 05a0 BD46     		mov	sp, r7
 1192 05a2 04B0     		add	sp, sp, #16
 1193              		@ sp needed
 1194 05a4 80BD     		pop	{r7, pc}
 1195              	.L73:
 1196 05a6 C046     		.align	2
 1197              	.L72:
 1198 05a8 00000000 		.word	backBuffer
 1199 05ac FF030000 		.word	1023
 1200              		.cfi_endproc
 1201              	.LFE17:
 1203              		.align	2
 1204              		.global	clearBuffers
 1205              		.code	16
 1206              		.thumb_func
 1208              	clearBuffers:
 1209              	.LFB18:
 262:Z:/Media/Documents/DAT017/game\startup.c **** 
 263:Z:/Media/Documents/DAT017/game\startup.c **** void clearBuffers()	{
 1210              		.loc 1 263 0
 1211              		.cfi_startproc
 1212 05b0 80B5     		push	{r7, lr}
 1213              		.cfi_def_cfa_offset 8
 1214              		.cfi_offset 7, -8
 1215              		.cfi_offset 14, -4
 1216 05b2 82B0     		sub	sp, sp, #8
 1217              		.cfi_def_cfa_offset 16
 1218 05b4 00AF     		add	r7, sp, #0
 1219              		.cfi_def_cfa_register 7
 1220              	.LBB7:
 264:Z:/Media/Documents/DAT017/game\startup.c **** 	for	(int i=0; i<1024; i++)	
 1221              		.loc 1 264 0
 1222 05b6 0023     		movs	r3, #0
 1223 05b8 7B60     		str	r3, [r7, #4]
 1224 05ba 0EE0     		b	.L75
 1225              	.L76:
 265:Z:/Media/Documents/DAT017/game\startup.c **** 		backBuffer[i] =	frontBuffer[i] = 0;	
 1226              		.loc 1 265 0 discriminator 3
 1227 05bc 0B4B     		ldr	r3, .L77
 1228 05be 1A68     		ldr	r2, [r3]
 1229 05c0 7B68     		ldr	r3, [r7, #4]
 1230 05c2 D218     		adds	r2, r2, r3
 1231 05c4 0A4B     		ldr	r3, .L77+4
 1232 05c6 1968     		ldr	r1, [r3]
 1233 05c8 7B68     		ldr	r3, [r7, #4]
 1234 05ca CB18     		adds	r3, r1, r3
 1235 05cc 0021     		movs	r1, #0
 1236 05ce 1970     		strb	r1, [r3]
 1237 05d0 1B78     		ldrb	r3, [r3]
 1238 05d2 1370     		strb	r3, [r2]
 264:Z:/Media/Documents/DAT017/game\startup.c **** 	for	(int i=0; i<1024; i++)	
 1239              		.loc 1 264 0 discriminator 3
 1240 05d4 7B68     		ldr	r3, [r7, #4]
 1241 05d6 0133     		adds	r3, r3, #1
 1242 05d8 7B60     		str	r3, [r7, #4]
 1243              	.L75:
 264:Z:/Media/Documents/DAT017/game\startup.c **** 	for	(int i=0; i<1024; i++)	
 1244              		.loc 1 264 0 is_stmt 0 discriminator 1
 1245 05da 7B68     		ldr	r3, [r7, #4]
 1246 05dc 054A     		ldr	r2, .L77+8
 1247 05de 9342     		cmp	r3, r2
 1248 05e0 ECDD     		ble	.L76
 1249              	.LBE7:
 266:Z:/Media/Documents/DAT017/game\startup.c **** }
 1250              		.loc 1 266 0 is_stmt 1
 1251 05e2 C046     		nop
 1252 05e4 BD46     		mov	sp, r7
 1253 05e6 02B0     		add	sp, sp, #8
 1254              		@ sp needed
 1255 05e8 80BD     		pop	{r7, pc}
 1256              	.L78:
 1257 05ea C046     		.align	2
 1258              	.L77:
 1259 05ec 00000000 		.word	backBuffer
 1260 05f0 00000000 		.word	frontBuffer
 1261 05f4 FF030000 		.word	1023
 1262              		.cfi_endproc
 1263              	.LFE18:
 1265              		.align	2
 1266              		.global	swapBuffers
 1267              		.code	16
 1268              		.thumb_func
 1270              	swapBuffers:
 1271              	.LFB19:
 267:Z:/Media/Documents/DAT017/game\startup.c **** 
 268:Z:/Media/Documents/DAT017/game\startup.c **** void swapBuffers()	{	
 1272              		.loc 1 268 0
 1273              		.cfi_startproc
 1274 05f8 80B5     		push	{r7, lr}
 1275              		.cfi_def_cfa_offset 8
 1276              		.cfi_offset 7, -8
 1277              		.cfi_offset 14, -4
 1278 05fa 82B0     		sub	sp, sp, #8
 1279              		.cfi_def_cfa_offset 16
 1280 05fc 00AF     		add	r7, sp, #0
 1281              		.cfi_def_cfa_register 7
 269:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_drawScreen();
 1282              		.loc 1 269 0
 1283 05fe FFF7FEFF 		bl	graphic_drawScreen
 270:Z:/Media/Documents/DAT017/game\startup.c **** 	unsigned char* tmp = frontBuffer;
 1284              		.loc 1 270 0
 1285 0602 074B     		ldr	r3, .L80
 1286 0604 1B68     		ldr	r3, [r3]
 1287 0606 7B60     		str	r3, [r7, #4]
 271:Z:/Media/Documents/DAT017/game\startup.c **** 	frontBuffer	= backBuffer;	
 1288              		.loc 1 271 0
 1289 0608 064B     		ldr	r3, .L80+4
 1290 060a 1A68     		ldr	r2, [r3]
 1291 060c 044B     		ldr	r3, .L80
 1292 060e 1A60     		str	r2, [r3]
 272:Z:/Media/Documents/DAT017/game\startup.c **** 	backBuffer = tmp;
 1293              		.loc 1 272 0
 1294 0610 044B     		ldr	r3, .L80+4
 1295 0612 7A68     		ldr	r2, [r7, #4]
 1296 0614 1A60     		str	r2, [r3]
 273:Z:/Media/Documents/DAT017/game\startup.c **** }
 1297              		.loc 1 273 0
 1298 0616 C046     		nop
 1299 0618 BD46     		mov	sp, r7
 1300 061a 02B0     		add	sp, sp, #8
 1301              		@ sp needed
 1302 061c 80BD     		pop	{r7, pc}
 1303              	.L81:
 1304 061e C046     		.align	2
 1305              	.L80:
 1306 0620 00000000 		.word	frontBuffer
 1307 0624 00000000 		.word	backBuffer
 1308              		.cfi_endproc
 1309              	.LFE19:
 1311              		.align	2
 1312              		.global	pixel
 1313              		.code	16
 1314              		.thumb_func
 1316              	pixel:
 1317              	.LFB20:
 274:Z:/Media/Documents/DAT017/game\startup.c **** void pixel(int x, int y, int set){
 1318              		.loc 1 274 0
 1319              		.cfi_startproc
 1320 0628 80B5     		push	{r7, lr}
 1321              		.cfi_def_cfa_offset 8
 1322              		.cfi_offset 7, -8
 1323              		.cfi_offset 14, -4
 1324 062a 86B0     		sub	sp, sp, #24
 1325              		.cfi_def_cfa_offset 32
 1326 062c 00AF     		add	r7, sp, #0
 1327              		.cfi_def_cfa_register 7
 1328 062e F860     		str	r0, [r7, #12]
 1329 0630 B960     		str	r1, [r7, #8]
 1330 0632 7A60     		str	r2, [r7, #4]
 275:Z:/Media/Documents/DAT017/game\startup.c ****     if(!set)
 1331              		.loc 1 275 0
 1332 0634 7B68     		ldr	r3, [r7, #4]
 1333 0636 002B     		cmp	r3, #0
 1334 0638 41D0     		beq	.L90
 276:Z:/Media/Documents/DAT017/game\startup.c **** 		return;
 277:Z:/Media/Documents/DAT017/game\startup.c ****     if((x > 127) || (x < 0) || (y > 63) || (y < 0))
 1335              		.loc 1 277 0
 1336 063a FB68     		ldr	r3, [r7, #12]
 1337 063c 7F2B     		cmp	r3, #127
 1338 063e 40DC     		bgt	.L91
 1339              		.loc 1 277 0 is_stmt 0 discriminator 1
 1340 0640 FB68     		ldr	r3, [r7, #12]
 1341 0642 002B     		cmp	r3, #0
 1342 0644 3DDB     		blt	.L91
 1343              		.loc 1 277 0 discriminator 2
 1344 0646 BB68     		ldr	r3, [r7, #8]
 1345 0648 3F2B     		cmp	r3, #63
 1346 064a 3ADC     		bgt	.L91
 1347              		.loc 1 277 0 discriminator 3
 1348 064c BB68     		ldr	r3, [r7, #8]
 1349 064e 002B     		cmp	r3, #0
 1350 0650 37DB     		blt	.L91
 278:Z:/Media/Documents/DAT017/game\startup.c **** 		return;
 279:Z:/Media/Documents/DAT017/game\startup.c **** 		
 280:Z:/Media/Documents/DAT017/game\startup.c ****     unsigned char mask = 1 << (y % 8);
 1351              		.loc 1 280 0 is_stmt 1
 1352 0652 BB68     		ldr	r3, [r7, #8]
 1353 0654 1D4A     		ldr	r2, .L92
 1354 0656 1340     		ands	r3, r2
 1355 0658 04D5     		bpl	.L87
 1356 065a 013B     		subs	r3, r3, #1
 1357 065c 0822     		movs	r2, #8
 1358 065e 5242     		rsbs	r2, r2, #0
 1359 0660 1343     		orrs	r3, r2
 1360 0662 0133     		adds	r3, r3, #1
 1361              	.L87:
 1362 0664 1A00     		movs	r2, r3
 1363 0666 0123     		movs	r3, #1
 1364 0668 9340     		lsls	r3, r3, r2
 1365 066a 1A00     		movs	r2, r3
 1366 066c 1323     		movs	r3, #19
 1367 066e FB18     		adds	r3, r7, r3
 1368 0670 1A70     		strb	r2, [r3]
 281:Z:/Media/Documents/DAT017/game\startup.c ****     int index = 0;
 1369              		.loc 1 281 0
 1370 0672 0023     		movs	r3, #0
 1371 0674 7B61     		str	r3, [r7, #20]
 282:Z:/Media/Documents/DAT017/game\startup.c ****     if(x >= 64) {
 1372              		.loc 1 282 0
 1373 0676 FB68     		ldr	r3, [r7, #12]
 1374 0678 3F2B     		cmp	r3, #63
 1375 067a 05DD     		ble	.L88
 283:Z:/Media/Documents/DAT017/game\startup.c **** 		x -= 64;
 1376              		.loc 1 283 0
 1377 067c FB68     		ldr	r3, [r7, #12]
 1378 067e 403B     		subs	r3, r3, #64
 1379 0680 FB60     		str	r3, [r7, #12]
 284:Z:/Media/Documents/DAT017/game\startup.c **** 		index = 512;
 1380              		.loc 1 284 0
 1381 0682 8023     		movs	r3, #128
 1382 0684 9B00     		lsls	r3, r3, #2
 1383 0686 7B61     		str	r3, [r7, #20]
 1384              	.L88:
 285:Z:/Media/Documents/DAT017/game\startup.c ****     }
 286:Z:/Media/Documents/DAT017/game\startup.c ****     index += x + (y / 8) * 64;
 1385              		.loc 1 286 0
 1386 0688 BB68     		ldr	r3, [r7, #8]
 1387 068a 002B     		cmp	r3, #0
 1388 068c 00DA     		bge	.L89
 1389 068e 0733     		adds	r3, r3, #7
 1390              	.L89:
 1391 0690 DB10     		asrs	r3, r3, #3
 1392 0692 9A01     		lsls	r2, r3, #6
 1393 0694 FB68     		ldr	r3, [r7, #12]
 1394 0696 D318     		adds	r3, r2, r3
 1395 0698 7A69     		ldr	r2, [r7, #20]
 1396 069a D318     		adds	r3, r2, r3
 1397 069c 7B61     		str	r3, [r7, #20]
 287:Z:/Media/Documents/DAT017/game\startup.c ****     backBuffer[index] |= mask;
 1398              		.loc 1 287 0
 1399 069e 0C4B     		ldr	r3, .L92+4
 1400 06a0 1A68     		ldr	r2, [r3]
 1401 06a2 7B69     		ldr	r3, [r7, #20]
 1402 06a4 D218     		adds	r2, r2, r3
 1403 06a6 0A4B     		ldr	r3, .L92+4
 1404 06a8 1968     		ldr	r1, [r3]
 1405 06aa 7B69     		ldr	r3, [r7, #20]
 1406 06ac CB18     		adds	r3, r1, r3
 1407 06ae 1978     		ldrb	r1, [r3]
 1408 06b0 1323     		movs	r3, #19
 1409 06b2 FB18     		adds	r3, r7, r3
 1410 06b4 1B78     		ldrb	r3, [r3]
 1411 06b6 0B43     		orrs	r3, r1
 1412 06b8 DBB2     		uxtb	r3, r3
 1413 06ba 1370     		strb	r3, [r2]
 1414 06bc 02E0     		b	.L82
 1415              	.L90:
 276:Z:/Media/Documents/DAT017/game\startup.c ****     if((x > 127) || (x < 0) || (y > 63) || (y < 0))
 1416              		.loc 1 276 0
 1417 06be C046     		nop
 1418 06c0 00E0     		b	.L82
 1419              	.L91:
 278:Z:/Media/Documents/DAT017/game\startup.c **** 		
 1420              		.loc 1 278 0
 1421 06c2 C046     		nop
 1422              	.L82:
 288:Z:/Media/Documents/DAT017/game\startup.c **** }
 1423              		.loc 1 288 0
 1424 06c4 BD46     		mov	sp, r7
 1425 06c6 06B0     		add	sp, sp, #24
 1426              		@ sp needed
 1427 06c8 80BD     		pop	{r7, pc}
 1428              	.L93:
 1429 06ca C046     		.align	2
 1430              	.L92:
 1431 06cc 07000080 		.word	-2147483641
 1432 06d0 00000000 		.word	backBuffer
 1433              		.cfi_endproc
 1434              	.LFE20:
 1436              		.align	2
 1437              		.global	init_app
 1438              		.code	16
 1439              		.thumb_func
 1441              	init_app:
 1442              	.LFB21:
 289:Z:/Media/Documents/DAT017/game\startup.c **** 
 290:Z:/Media/Documents/DAT017/game\startup.c **** void init_app(void){
 1443              		.loc 1 290 0
 1444              		.cfi_startproc
 1445 06d4 80B5     		push	{r7, lr}
 1446              		.cfi_def_cfa_offset 8
 1447              		.cfi_offset 7, -8
 1448              		.cfi_offset 14, -4
 1449 06d6 00AF     		add	r7, sp, #0
 1450              		.cfi_def_cfa_register 7
 291:Z:/Media/Documents/DAT017/game\startup.c **** 	/* PORT E */
 292:Z:/Media/Documents/DAT017/game\startup.c **** 	*portModer = 0x55555555; /* all bits outputs */
 1451              		.loc 1 292 0
 1452 06d8 074B     		ldr	r3, .L95
 1453 06da 084A     		ldr	r2, .L95+4
 1454 06dc 1A60     		str	r2, [r3]
 293:Z:/Media/Documents/DAT017/game\startup.c **** 	*portOtyper = 0x00000000; /* outputs are push/pull */
 1455              		.loc 1 293 0
 1456 06de 084B     		ldr	r3, .L95+8
 1457 06e0 0022     		movs	r2, #0
 1458 06e2 1A80     		strh	r2, [r3]
 294:Z:/Media/Documents/DAT017/game\startup.c **** 	*portOspeedr = 0x55555555; /* medium speed */
 1459              		.loc 1 294 0
 1460 06e4 074B     		ldr	r3, .L95+12
 1461 06e6 054A     		ldr	r2, .L95+4
 1462 06e8 1A60     		str	r2, [r3]
 295:Z:/Media/Documents/DAT017/game\startup.c **** 	*portPupdr = 0x55550000; /* inputs are pull up */
 1463              		.loc 1 295 0
 1464 06ea 074B     		ldr	r3, .L95+16
 1465 06ec 074A     		ldr	r2, .L95+20
 1466 06ee 1A60     		str	r2, [r3]
 296:Z:/Media/Documents/DAT017/game\startup.c **** }
 1467              		.loc 1 296 0
 1468 06f0 C046     		nop
 1469 06f2 BD46     		mov	sp, r7
 1470              		@ sp needed
 1471 06f4 80BD     		pop	{r7, pc}
 1472              	.L96:
 1473 06f6 C046     		.align	2
 1474              	.L95:
 1475 06f8 00100240 		.word	1073876992
 1476 06fc 55555555 		.word	1431655765
 1477 0700 04100240 		.word	1073876996
 1478 0704 08100240 		.word	1073877000
 1479 0708 0C100240 		.word	1073877004
 1480 070c 00005555 		.word	1431633920
 1481              		.cfi_endproc
 1482              	.LFE21:
 1484              		.global	courtStartY
 1485              		.data
 1488              	courtStartY:
 1489 0008 03       		.byte	3
 1490              		.global	courtStartX
 1493              	courtStartX:
 1494 0009 03       		.byte	3
 1495              		.global	blockWidth
 1498              	blockWidth:
 1499 000a 04       		.byte	4
 1500              		.global	courtWidth
 1503              	courtWidth:
 1504 000b 0A       		.byte	10
 1505              		.global	courtHeight
 1508              	courtHeight:
 1509 000c 14       		.byte	20
 1510              		.comm	blocks,200,4
 1511              		.text
 1512              		.align	2
 1513              		.global	getBlock
 1514              		.code	16
 1515              		.thumb_func
 1517              	getBlock:
 1518              	.LFB22:
 297:Z:/Media/Documents/DAT017/game\startup.c **** 
 298:Z:/Media/Documents/DAT017/game\startup.c **** uint8 courtStartY = 3;
 299:Z:/Media/Documents/DAT017/game\startup.c **** uint8 courtStartX = 3;
 300:Z:/Media/Documents/DAT017/game\startup.c **** uint8 blockWidth = 4;
 301:Z:/Media/Documents/DAT017/game\startup.c **** uint8 courtWidth = 10;
 302:Z:/Media/Documents/DAT017/game\startup.c **** uint8 courtHeight = 20;
 303:Z:/Media/Documents/DAT017/game\startup.c **** bool blocks[10][20];
 304:Z:/Media/Documents/DAT017/game\startup.c **** 
 305:Z:/Media/Documents/DAT017/game\startup.c **** bool getBlock(uint8 x, uint8 y){
 1519              		.loc 1 305 0
 1520              		.cfi_startproc
 1521 0710 80B5     		push	{r7, lr}
 1522              		.cfi_def_cfa_offset 8
 1523              		.cfi_offset 7, -8
 1524              		.cfi_offset 14, -4
 1525 0712 82B0     		sub	sp, sp, #8
 1526              		.cfi_def_cfa_offset 16
 1527 0714 00AF     		add	r7, sp, #0
 1528              		.cfi_def_cfa_register 7
 1529 0716 0200     		movs	r2, r0
 1530 0718 FB1D     		adds	r3, r7, #7
 1531 071a 1A70     		strb	r2, [r3]
 1532 071c BB1D     		adds	r3, r7, #6
 1533 071e 0A1C     		adds	r2, r1, #0
 1534 0720 1A70     		strb	r2, [r3]
 306:Z:/Media/Documents/DAT017/game\startup.c **** 	return blocks[x][y];
 1535              		.loc 1 306 0
 1536 0722 FB1D     		adds	r3, r7, #7
 1537 0724 1A78     		ldrb	r2, [r3]
 1538 0726 BB1D     		adds	r3, r7, #6
 1539 0728 1978     		ldrb	r1, [r3]
 1540 072a 0548     		ldr	r0, .L99
 1541 072c 1300     		movs	r3, r2
 1542 072e 9B00     		lsls	r3, r3, #2
 1543 0730 9B18     		adds	r3, r3, r2
 1544 0732 9B00     		lsls	r3, r3, #2
 1545 0734 C318     		adds	r3, r0, r3
 1546 0736 5B5C     		ldrb	r3, [r3, r1]
 307:Z:/Media/Documents/DAT017/game\startup.c **** }
 1547              		.loc 1 307 0
 1548 0738 1800     		movs	r0, r3
 1549 073a BD46     		mov	sp, r7
 1550 073c 02B0     		add	sp, sp, #8
 1551              		@ sp needed
 1552 073e 80BD     		pop	{r7, pc}
 1553              	.L100:
 1554              		.align	2
 1555              	.L99:
 1556 0740 00000000 		.word	blocks
 1557              		.cfi_endproc
 1558              	.LFE22:
 1560              		.align	2
 1561              		.global	setBlock
 1562              		.code	16
 1563              		.thumb_func
 1565              	setBlock:
 1566              	.LFB23:
 308:Z:/Media/Documents/DAT017/game\startup.c **** void setBlock(uint8 x, uint8 y, bool set){
 1567              		.loc 1 308 0
 1568              		.cfi_startproc
 1569 0744 90B5     		push	{r4, r7, lr}
 1570              		.cfi_def_cfa_offset 12
 1571              		.cfi_offset 4, -12
 1572              		.cfi_offset 7, -8
 1573              		.cfi_offset 14, -4
 1574 0746 83B0     		sub	sp, sp, #12
 1575              		.cfi_def_cfa_offset 24
 1576 0748 00AF     		add	r7, sp, #0
 1577              		.cfi_def_cfa_register 7
 1578 074a 0400     		movs	r4, r0
 1579 074c 0800     		movs	r0, r1
 1580 074e 1100     		movs	r1, r2
 1581 0750 FB1D     		adds	r3, r7, #7
 1582 0752 221C     		adds	r2, r4, #0
 1583 0754 1A70     		strb	r2, [r3]
 1584 0756 BB1D     		adds	r3, r7, #6
 1585 0758 021C     		adds	r2, r0, #0
 1586 075a 1A70     		strb	r2, [r3]
 1587 075c 7B1D     		adds	r3, r7, #5
 1588 075e 0A1C     		adds	r2, r1, #0
 1589 0760 1A70     		strb	r2, [r3]
 309:Z:/Media/Documents/DAT017/game\startup.c **** 	blocks[x][y] = set;
 1590              		.loc 1 309 0
 1591 0762 FB1D     		adds	r3, r7, #7
 1592 0764 1A78     		ldrb	r2, [r3]
 1593 0766 BB1D     		adds	r3, r7, #6
 1594 0768 1978     		ldrb	r1, [r3]
 1595 076a 0648     		ldr	r0, .L102
 1596 076c 1300     		movs	r3, r2
 1597 076e 9B00     		lsls	r3, r3, #2
 1598 0770 9B18     		adds	r3, r3, r2
 1599 0772 9B00     		lsls	r3, r3, #2
 1600 0774 C318     		adds	r3, r0, r3
 1601 0776 7A1D     		adds	r2, r7, #5
 1602 0778 1278     		ldrb	r2, [r2]
 1603 077a 5A54     		strb	r2, [r3, r1]
 310:Z:/Media/Documents/DAT017/game\startup.c **** }
 1604              		.loc 1 310 0
 1605 077c C046     		nop
 1606 077e BD46     		mov	sp, r7
 1607 0780 03B0     		add	sp, sp, #12
 1608              		@ sp needed
 1609 0782 90BD     		pop	{r4, r7, pc}
 1610              	.L103:
 1611              		.align	2
 1612              	.L102:
 1613 0784 00000000 		.word	blocks
 1614              		.cfi_endproc
 1615              	.LFE23:
 1617              		.align	2
 1618              		.global	drawCourt
 1619              		.code	16
 1620              		.thumb_func
 1622              	drawCourt:
 1623              	.LFB24:
 311:Z:/Media/Documents/DAT017/game\startup.c **** 
 312:Z:/Media/Documents/DAT017/game\startup.c **** void drawCourt(){
 1624              		.loc 1 312 0
 1625              		.cfi_startproc
 1626 0788 80B5     		push	{r7, lr}
 1627              		.cfi_def_cfa_offset 8
 1628              		.cfi_offset 7, -8
 1629              		.cfi_offset 14, -4
 1630 078a 82B0     		sub	sp, sp, #8
 1631              		.cfi_def_cfa_offset 16
 1632 078c 00AF     		add	r7, sp, #0
 1633              		.cfi_def_cfa_register 7
 313:Z:/Media/Documents/DAT017/game\startup.c **** 	
 314:Z:/Media/Documents/DAT017/game\startup.c **** 	uint8 y = courtStartY-2;
 1634              		.loc 1 314 0
 1635 078e 544B     		ldr	r3, .L113
 1636 0790 1A78     		ldrb	r2, [r3]
 1637 0792 FB1C     		adds	r3, r7, #3
 1638 0794 023A     		subs	r2, r2, #2
 1639 0796 1A70     		strb	r2, [r3]
 1640              	.LBB8:
 315:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++){
 1641              		.loc 1 315 0
 1642 0798 524B     		ldr	r3, .L113+4
 1643 079a 1A78     		ldrb	r2, [r3]
 1644 079c FB1D     		adds	r3, r7, #7
 1645 079e 023A     		subs	r2, r2, #2
 1646 07a0 1A70     		strb	r2, [r3]
 1647 07a2 0CE0     		b	.L105
 1648              	.L106:
 316:Z:/Media/Documents/DAT017/game\startup.c **** 		pixel(x, y, 1);
 1649              		.loc 1 316 0 discriminator 3
 1650 07a4 FB1D     		adds	r3, r7, #7
 1651 07a6 1878     		ldrb	r0, [r3]
 1652 07a8 FB1C     		adds	r3, r7, #3
 1653 07aa 1B78     		ldrb	r3, [r3]
 1654 07ac 0122     		movs	r2, #1
 1655 07ae 1900     		movs	r1, r3
 1656 07b0 FFF7FEFF 		bl	pixel
 315:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++){
 1657              		.loc 1 315 0 discriminator 3
 1658 07b4 FB1D     		adds	r3, r7, #7
 1659 07b6 1A78     		ldrb	r2, [r3]
 1660 07b8 FB1D     		adds	r3, r7, #7
 1661 07ba 0132     		adds	r2, r2, #1
 1662 07bc 1A70     		strb	r2, [r3]
 1663              	.L105:
 315:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++){
 1664              		.loc 1 315 0 is_stmt 0 discriminator 1
 1665 07be FB1D     		adds	r3, r7, #7
 1666 07c0 1A78     		ldrb	r2, [r3]
 1667 07c2 484B     		ldr	r3, .L113+4
 1668 07c4 1B78     		ldrb	r3, [r3]
 1669 07c6 1900     		movs	r1, r3
 1670 07c8 474B     		ldr	r3, .L113+8
 1671 07ca 1B78     		ldrb	r3, [r3]
 1672 07cc 1800     		movs	r0, r3
 1673 07ce 474B     		ldr	r3, .L113+12
 1674 07d0 1B78     		ldrb	r3, [r3]
 1675 07d2 4343     		muls	r3, r0
 1676 07d4 CB18     		adds	r3, r1, r3
 1677 07d6 9A42     		cmp	r2, r3
 1678 07d8 E4DB     		blt	.L106
 1679              	.LBE8:
 317:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 318:Z:/Media/Documents/DAT017/game\startup.c **** 	
 319:Z:/Media/Documents/DAT017/game\startup.c **** 	y = courtStartY + blockWidth*courtHeight;
 1680              		.loc 1 319 0 is_stmt 1
 1681 07da 434B     		ldr	r3, .L113+8
 1682 07dc 1B78     		ldrb	r3, [r3]
 1683 07de 444A     		ldr	r2, .L113+16
 1684 07e0 1278     		ldrb	r2, [r2]
 1685 07e2 5343     		muls	r3, r2
 1686 07e4 D9B2     		uxtb	r1, r3
 1687 07e6 3E4B     		ldr	r3, .L113
 1688 07e8 1A78     		ldrb	r2, [r3]
 1689 07ea FB1C     		adds	r3, r7, #3
 1690 07ec 8A18     		adds	r2, r1, r2
 1691 07ee 1A70     		strb	r2, [r3]
 1692              	.LBB9:
 320:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++){
 1693              		.loc 1 320 0
 1694 07f0 3C4B     		ldr	r3, .L113+4
 1695 07f2 1A78     		ldrb	r2, [r3]
 1696 07f4 BB1D     		adds	r3, r7, #6
 1697 07f6 023A     		subs	r2, r2, #2
 1698 07f8 1A70     		strb	r2, [r3]
 1699 07fa 0CE0     		b	.L107
 1700              	.L108:
 321:Z:/Media/Documents/DAT017/game\startup.c **** 		pixel(x, y, 1);
 1701              		.loc 1 321 0 discriminator 3
 1702 07fc BB1D     		adds	r3, r7, #6
 1703 07fe 1878     		ldrb	r0, [r3]
 1704 0800 FB1C     		adds	r3, r7, #3
 1705 0802 1B78     		ldrb	r3, [r3]
 1706 0804 0122     		movs	r2, #1
 1707 0806 1900     		movs	r1, r3
 1708 0808 FFF7FEFF 		bl	pixel
 320:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++){
 1709              		.loc 1 320 0 discriminator 3
 1710 080c BB1D     		adds	r3, r7, #6
 1711 080e 1A78     		ldrb	r2, [r3]
 1712 0810 BB1D     		adds	r3, r7, #6
 1713 0812 0132     		adds	r2, r2, #1
 1714 0814 1A70     		strb	r2, [r3]
 1715              	.L107:
 320:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++){
 1716              		.loc 1 320 0 is_stmt 0 discriminator 1
 1717 0816 BB1D     		adds	r3, r7, #6
 1718 0818 1A78     		ldrb	r2, [r3]
 1719 081a 324B     		ldr	r3, .L113+4
 1720 081c 1B78     		ldrb	r3, [r3]
 1721 081e 1900     		movs	r1, r3
 1722 0820 314B     		ldr	r3, .L113+8
 1723 0822 1B78     		ldrb	r3, [r3]
 1724 0824 1800     		movs	r0, r3
 1725 0826 314B     		ldr	r3, .L113+12
 1726 0828 1B78     		ldrb	r3, [r3]
 1727 082a 4343     		muls	r3, r0
 1728 082c CB18     		adds	r3, r1, r3
 1729 082e 9A42     		cmp	r2, r3
 1730 0830 E4DB     		blt	.L108
 1731              	.LBE9:
 322:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 323:Z:/Media/Documents/DAT017/game\startup.c **** 	
 324:Z:/Media/Documents/DAT017/game\startup.c **** 	
 325:Z:/Media/Documents/DAT017/game\startup.c **** 	uint8 x = courtStartX-2;
 1732              		.loc 1 325 0 is_stmt 1
 1733 0832 2C4B     		ldr	r3, .L113+4
 1734 0834 1A78     		ldrb	r2, [r3]
 1735 0836 BB1C     		adds	r3, r7, #2
 1736 0838 023A     		subs	r2, r2, #2
 1737 083a 1A70     		strb	r2, [r3]
 1738              	.LBB10:
 326:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++){
 1739              		.loc 1 326 0
 1740 083c 284B     		ldr	r3, .L113
 1741 083e 1A78     		ldrb	r2, [r3]
 1742 0840 7B1D     		adds	r3, r7, #5
 1743 0842 023A     		subs	r2, r2, #2
 1744 0844 1A70     		strb	r2, [r3]
 1745 0846 0CE0     		b	.L109
 1746              	.L110:
 327:Z:/Media/Documents/DAT017/game\startup.c **** 		pixel(x, y, 1);
 1747              		.loc 1 327 0 discriminator 3
 1748 0848 BB1C     		adds	r3, r7, #2
 1749 084a 1878     		ldrb	r0, [r3]
 1750 084c 7B1D     		adds	r3, r7, #5
 1751 084e 1B78     		ldrb	r3, [r3]
 1752 0850 0122     		movs	r2, #1
 1753 0852 1900     		movs	r1, r3
 1754 0854 FFF7FEFF 		bl	pixel
 326:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++){
 1755              		.loc 1 326 0 discriminator 3
 1756 0858 7B1D     		adds	r3, r7, #5
 1757 085a 1A78     		ldrb	r2, [r3]
 1758 085c 7B1D     		adds	r3, r7, #5
 1759 085e 0132     		adds	r2, r2, #1
 1760 0860 1A70     		strb	r2, [r3]
 1761              	.L109:
 326:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++){
 1762              		.loc 1 326 0 is_stmt 0 discriminator 1
 1763 0862 7B1D     		adds	r3, r7, #5
 1764 0864 1A78     		ldrb	r2, [r3]
 1765 0866 1E4B     		ldr	r3, .L113
 1766 0868 1B78     		ldrb	r3, [r3]
 1767 086a 1900     		movs	r1, r3
 1768 086c 1E4B     		ldr	r3, .L113+8
 1769 086e 1B78     		ldrb	r3, [r3]
 1770 0870 1800     		movs	r0, r3
 1771 0872 1F4B     		ldr	r3, .L113+16
 1772 0874 1B78     		ldrb	r3, [r3]
 1773 0876 4343     		muls	r3, r0
 1774 0878 CB18     		adds	r3, r1, r3
 1775 087a 9A42     		cmp	r2, r3
 1776 087c E4DB     		blt	.L110
 1777              	.LBE10:
 328:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 329:Z:/Media/Documents/DAT017/game\startup.c **** 	
 330:Z:/Media/Documents/DAT017/game\startup.c **** 	x = courtStartX + blockWidth*courtWidth;
 1778              		.loc 1 330 0 is_stmt 1
 1779 087e 1A4B     		ldr	r3, .L113+8
 1780 0880 1B78     		ldrb	r3, [r3]
 1781 0882 1A4A     		ldr	r2, .L113+12
 1782 0884 1278     		ldrb	r2, [r2]
 1783 0886 5343     		muls	r3, r2
 1784 0888 D9B2     		uxtb	r1, r3
 1785 088a 164B     		ldr	r3, .L113+4
 1786 088c 1A78     		ldrb	r2, [r3]
 1787 088e BB1C     		adds	r3, r7, #2
 1788 0890 8A18     		adds	r2, r1, r2
 1789 0892 1A70     		strb	r2, [r3]
 1790              	.LBB11:
 331:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++){
 1791              		.loc 1 331 0
 1792 0894 124B     		ldr	r3, .L113
 1793 0896 1A78     		ldrb	r2, [r3]
 1794 0898 3B1D     		adds	r3, r7, #4
 1795 089a 023A     		subs	r2, r2, #2
 1796 089c 1A70     		strb	r2, [r3]
 1797 089e 0CE0     		b	.L111
 1798              	.L112:
 332:Z:/Media/Documents/DAT017/game\startup.c **** 		pixel(x, y, 1);
 1799              		.loc 1 332 0 discriminator 3
 1800 08a0 BB1C     		adds	r3, r7, #2
 1801 08a2 1878     		ldrb	r0, [r3]
 1802 08a4 3B1D     		adds	r3, r7, #4
 1803 08a6 1B78     		ldrb	r3, [r3]
 1804 08a8 0122     		movs	r2, #1
 1805 08aa 1900     		movs	r1, r3
 1806 08ac FFF7FEFF 		bl	pixel
 331:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++){
 1807              		.loc 1 331 0 discriminator 3
 1808 08b0 3B1D     		adds	r3, r7, #4
 1809 08b2 1A78     		ldrb	r2, [r3]
 1810 08b4 3B1D     		adds	r3, r7, #4
 1811 08b6 0132     		adds	r2, r2, #1
 1812 08b8 1A70     		strb	r2, [r3]
 1813              	.L111:
 331:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++){
 1814              		.loc 1 331 0 is_stmt 0 discriminator 1
 1815 08ba 3B1D     		adds	r3, r7, #4
 1816 08bc 1A78     		ldrb	r2, [r3]
 1817 08be 084B     		ldr	r3, .L113
 1818 08c0 1B78     		ldrb	r3, [r3]
 1819 08c2 1900     		movs	r1, r3
 1820 08c4 084B     		ldr	r3, .L113+8
 1821 08c6 1B78     		ldrb	r3, [r3]
 1822 08c8 1800     		movs	r0, r3
 1823 08ca 094B     		ldr	r3, .L113+16
 1824 08cc 1B78     		ldrb	r3, [r3]
 1825 08ce 4343     		muls	r3, r0
 1826 08d0 CB18     		adds	r3, r1, r3
 1827 08d2 9A42     		cmp	r2, r3
 1828 08d4 E4DB     		blt	.L112
 1829              	.LBE11:
 333:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 334:Z:/Media/Documents/DAT017/game\startup.c **** 	
 335:Z:/Media/Documents/DAT017/game\startup.c **** }
 1830              		.loc 1 335 0 is_stmt 1
 1831 08d6 C046     		nop
 1832 08d8 BD46     		mov	sp, r7
 1833 08da 02B0     		add	sp, sp, #8
 1834              		@ sp needed
 1835 08dc 80BD     		pop	{r7, pc}
 1836              	.L114:
 1837 08de C046     		.align	2
 1838              	.L113:
 1839 08e0 00000000 		.word	courtStartY
 1840 08e4 00000000 		.word	courtStartX
 1841 08e8 00000000 		.word	blockWidth
 1842 08ec 00000000 		.word	courtWidth
 1843 08f0 00000000 		.word	courtHeight
 1844              		.cfi_endproc
 1845              	.LFE24:
 1847              		.align	2
 1848              		.global	drawBlock
 1849              		.code	16
 1850              		.thumb_func
 1852              	drawBlock:
 1853              	.LFB25:
 336:Z:/Media/Documents/DAT017/game\startup.c **** 
 337:Z:/Media/Documents/DAT017/game\startup.c **** void drawBlock(uint8 x, uint8 y){
 1854              		.loc 1 337 0
 1855              		.cfi_startproc
 1856 08f4 80B5     		push	{r7, lr}
 1857              		.cfi_def_cfa_offset 8
 1858              		.cfi_offset 7, -8
 1859              		.cfi_offset 14, -4
 1860 08f6 84B0     		sub	sp, sp, #16
 1861              		.cfi_def_cfa_offset 24
 1862 08f8 00AF     		add	r7, sp, #0
 1863              		.cfi_def_cfa_register 7
 1864 08fa 0200     		movs	r2, r0
 1865 08fc FB1D     		adds	r3, r7, #7
 1866 08fe 1A70     		strb	r2, [r3]
 1867 0900 BB1D     		adds	r3, r7, #6
 1868 0902 0A1C     		adds	r2, r1, #0
 1869 0904 1A70     		strb	r2, [r3]
 1870              	.LBB12:
 338:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 by = 0; by < blockWidth-1; by++){
 1871              		.loc 1 338 0
 1872 0906 0F23     		movs	r3, #15
 1873 0908 FB18     		adds	r3, r7, r3
 1874 090a 0022     		movs	r2, #0
 1875 090c 1A70     		strb	r2, [r3]
 1876 090e 38E0     		b	.L116
 1877              	.L119:
 1878              	.LBB13:
 339:Z:/Media/Documents/DAT017/game\startup.c **** 		for(uint8 bx = 0; bx < blockWidth-1; bx++){
 1879              		.loc 1 339 0
 1880 0910 0E23     		movs	r3, #14
 1881 0912 FB18     		adds	r3, r7, r3
 1882 0914 0022     		movs	r2, #0
 1883 0916 1A70     		strb	r2, [r3]
 1884 0918 24E0     		b	.L117
 1885              	.L118:
 340:Z:/Media/Documents/DAT017/game\startup.c **** 			pixel(courtStartX + x*blockWidth + bx, courtStartY + y*blockWidth + by, 1);
 1886              		.loc 1 340 0 discriminator 3
 1887 091a 204B     		ldr	r3, .L120
 1888 091c 1B78     		ldrb	r3, [r3]
 1889 091e 1900     		movs	r1, r3
 1890 0920 FB1D     		adds	r3, r7, #7
 1891 0922 1B78     		ldrb	r3, [r3]
 1892 0924 1E4A     		ldr	r2, .L120+4
 1893 0926 1278     		ldrb	r2, [r2]
 1894 0928 5343     		muls	r3, r2
 1895 092a CA18     		adds	r2, r1, r3
 1896 092c 0E23     		movs	r3, #14
 1897 092e FB18     		adds	r3, r7, r3
 1898 0930 1B78     		ldrb	r3, [r3]
 1899 0932 D018     		adds	r0, r2, r3
 1900 0934 1B4B     		ldr	r3, .L120+8
 1901 0936 1B78     		ldrb	r3, [r3]
 1902 0938 1900     		movs	r1, r3
 1903 093a BB1D     		adds	r3, r7, #6
 1904 093c 1B78     		ldrb	r3, [r3]
 1905 093e 184A     		ldr	r2, .L120+4
 1906 0940 1278     		ldrb	r2, [r2]
 1907 0942 5343     		muls	r3, r2
 1908 0944 CA18     		adds	r2, r1, r3
 1909 0946 0F23     		movs	r3, #15
 1910 0948 FB18     		adds	r3, r7, r3
 1911 094a 1B78     		ldrb	r3, [r3]
 1912 094c D318     		adds	r3, r2, r3
 1913 094e 0122     		movs	r2, #1
 1914 0950 1900     		movs	r1, r3
 1915 0952 FFF7FEFF 		bl	pixel
 339:Z:/Media/Documents/DAT017/game\startup.c **** 		for(uint8 bx = 0; bx < blockWidth-1; bx++){
 1916              		.loc 1 339 0 discriminator 3
 1917 0956 0E23     		movs	r3, #14
 1918 0958 FB18     		adds	r3, r7, r3
 1919 095a 1A78     		ldrb	r2, [r3]
 1920 095c 0E23     		movs	r3, #14
 1921 095e FB18     		adds	r3, r7, r3
 1922 0960 0132     		adds	r2, r2, #1
 1923 0962 1A70     		strb	r2, [r3]
 1924              	.L117:
 339:Z:/Media/Documents/DAT017/game\startup.c **** 		for(uint8 bx = 0; bx < blockWidth-1; bx++){
 1925              		.loc 1 339 0 is_stmt 0 discriminator 1
 1926 0964 0E23     		movs	r3, #14
 1927 0966 FB18     		adds	r3, r7, r3
 1928 0968 1A78     		ldrb	r2, [r3]
 1929 096a 0D4B     		ldr	r3, .L120+4
 1930 096c 1B78     		ldrb	r3, [r3]
 1931 096e 013B     		subs	r3, r3, #1
 1932 0970 9A42     		cmp	r2, r3
 1933 0972 D2DB     		blt	.L118
 1934              	.LBE13:
 338:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 by = 0; by < blockWidth-1; by++){
 1935              		.loc 1 338 0 is_stmt 1 discriminator 2
 1936 0974 0F23     		movs	r3, #15
 1937 0976 FB18     		adds	r3, r7, r3
 1938 0978 1A78     		ldrb	r2, [r3]
 1939 097a 0F23     		movs	r3, #15
 1940 097c FB18     		adds	r3, r7, r3
 1941 097e 0132     		adds	r2, r2, #1
 1942 0980 1A70     		strb	r2, [r3]
 1943              	.L116:
 338:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 by = 0; by < blockWidth-1; by++){
 1944              		.loc 1 338 0 is_stmt 0 discriminator 1
 1945 0982 0F23     		movs	r3, #15
 1946 0984 FB18     		adds	r3, r7, r3
 1947 0986 1A78     		ldrb	r2, [r3]
 1948 0988 054B     		ldr	r3, .L120+4
 1949 098a 1B78     		ldrb	r3, [r3]
 1950 098c 013B     		subs	r3, r3, #1
 1951 098e 9A42     		cmp	r2, r3
 1952 0990 BEDB     		blt	.L119
 1953              	.LBE12:
 341:Z:/Media/Documents/DAT017/game\startup.c **** 		}
 342:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 343:Z:/Media/Documents/DAT017/game\startup.c **** }
 1954              		.loc 1 343 0 is_stmt 1
 1955 0992 C046     		nop
 1956 0994 BD46     		mov	sp, r7
 1957 0996 04B0     		add	sp, sp, #16
 1958              		@ sp needed
 1959 0998 80BD     		pop	{r7, pc}
 1960              	.L121:
 1961 099a C046     		.align	2
 1962              	.L120:
 1963 099c 00000000 		.word	courtStartX
 1964 09a0 00000000 		.word	blockWidth
 1965 09a4 00000000 		.word	courtStartY
 1966              		.cfi_endproc
 1967              	.LFE25:
 1969              		.align	2
 1970              		.global	drawBlocks
 1971              		.code	16
 1972              		.thumb_func
 1974              	drawBlocks:
 1975              	.LFB26:
 344:Z:/Media/Documents/DAT017/game\startup.c **** 
 345:Z:/Media/Documents/DAT017/game\startup.c **** void drawBlocks(){
 1976              		.loc 1 345 0
 1977              		.cfi_startproc
 1978 09a8 80B5     		push	{r7, lr}
 1979              		.cfi_def_cfa_offset 8
 1980              		.cfi_offset 7, -8
 1981              		.cfi_offset 14, -4
 1982 09aa 82B0     		sub	sp, sp, #8
 1983              		.cfi_def_cfa_offset 16
 1984 09ac 00AF     		add	r7, sp, #0
 1985              		.cfi_def_cfa_register 7
 1986              	.LBB14:
 346:Z:/Media/Documents/DAT017/game\startup.c **** 	for(uint8 y = 0; y < courtHeight; y++){
 1987              		.loc 1 346 0
 1988 09ae FB1D     		adds	r3, r7, #7
 1989 09b0 0022     		movs	r2, #0
 1990 09b2 1A70     		strb	r2, [r3]
 1991 09b4 28E0     		b	.L123
 1992              	.L127:
 1993              	.LBB15:
 347:Z:/Media/Documents/DAT017/game\startup.c **** 		for(uint8 x = 0; x < courtWidth; x++){
 1994              		.loc 1 347 0
 1995 09b6 BB1D     		adds	r3, r7, #6
 1996 09b8 0022     		movs	r2, #0
 1997 09ba 1A70     		strb	r2, [r3]
 1998 09bc 19E0     		b	.L124
 1999              	.L126:
 348:Z:/Media/Documents/DAT017/game\startup.c **** 			if(blocks[x][y])
 2000              		.loc 1 348 0
 2001 09be BB1D     		adds	r3, r7, #6
 2002 09c0 1A78     		ldrb	r2, [r3]
 2003 09c2 FB1D     		adds	r3, r7, #7
 2004 09c4 1978     		ldrb	r1, [r3]
 2005 09c6 1548     		ldr	r0, .L128
 2006 09c8 1300     		movs	r3, r2
 2007 09ca 9B00     		lsls	r3, r3, #2
 2008 09cc 9B18     		adds	r3, r3, r2
 2009 09ce 9B00     		lsls	r3, r3, #2
 2010 09d0 C318     		adds	r3, r0, r3
 2011 09d2 5B5C     		ldrb	r3, [r3, r1]
 2012 09d4 002B     		cmp	r3, #0
 2013 09d6 07D0     		beq	.L125
 349:Z:/Media/Documents/DAT017/game\startup.c **** 				drawBlock(x,y);
 2014              		.loc 1 349 0
 2015 09d8 FB1D     		adds	r3, r7, #7
 2016 09da 1A78     		ldrb	r2, [r3]
 2017 09dc BB1D     		adds	r3, r7, #6
 2018 09de 1B78     		ldrb	r3, [r3]
 2019 09e0 1100     		movs	r1, r2
 2020 09e2 1800     		movs	r0, r3
 2021 09e4 FFF7FEFF 		bl	drawBlock
 2022              	.L125:
 347:Z:/Media/Documents/DAT017/game\startup.c **** 		for(uint8 x = 0; x < courtWidth; x++){
 2023              		.loc 1 347 0 discriminator 2
 2024 09e8 BB1D     		adds	r3, r7, #6
 2025 09ea 1A78     		ldrb	r2, [r3]
 2026 09ec BB1D     		adds	r3, r7, #6
 2027 09ee 0132     		adds	r2, r2, #1
 2028 09f0 1A70     		strb	r2, [r3]
 2029              	.L124:
 347:Z:/Media/Documents/DAT017/game\startup.c **** 		for(uint8 x = 0; x < courtWidth; x++){
 2030              		.loc 1 347 0 is_stmt 0 discriminator 1
 2031 09f2 0B4B     		ldr	r3, .L128+4
 2032 09f4 1B78     		ldrb	r3, [r3]
 2033 09f6 BA1D     		adds	r2, r7, #6
 2034 09f8 1278     		ldrb	r2, [r2]
 2035 09fa 9A42     		cmp	r2, r3
 2036 09fc DFD3     		bcc	.L126
 2037              	.LBE15:
 346:Z:/Media/Documents/DAT017/game\startup.c **** 		for(uint8 x = 0; x < courtWidth; x++){
 2038              		.loc 1 346 0 is_stmt 1 discriminator 2
 2039 09fe FB1D     		adds	r3, r7, #7
 2040 0a00 1A78     		ldrb	r2, [r3]
 2041 0a02 FB1D     		adds	r3, r7, #7
 2042 0a04 0132     		adds	r2, r2, #1
 2043 0a06 1A70     		strb	r2, [r3]
 2044              	.L123:
 346:Z:/Media/Documents/DAT017/game\startup.c **** 		for(uint8 x = 0; x < courtWidth; x++){
 2045              		.loc 1 346 0 is_stmt 0 discriminator 1
 2046 0a08 064B     		ldr	r3, .L128+8
 2047 0a0a 1B78     		ldrb	r3, [r3]
 2048 0a0c FA1D     		adds	r2, r7, #7
 2049 0a0e 1278     		ldrb	r2, [r2]
 2050 0a10 9A42     		cmp	r2, r3
 2051 0a12 D0D3     		bcc	.L127
 2052              	.LBE14:
 350:Z:/Media/Documents/DAT017/game\startup.c **** 		}
 351:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 352:Z:/Media/Documents/DAT017/game\startup.c **** }
 2053              		.loc 1 352 0 is_stmt 1
 2054 0a14 C046     		nop
 2055 0a16 BD46     		mov	sp, r7
 2056 0a18 02B0     		add	sp, sp, #8
 2057              		@ sp needed
 2058 0a1a 80BD     		pop	{r7, pc}
 2059              	.L129:
 2060              		.align	2
 2061              	.L128:
 2062 0a1c 00000000 		.word	blocks
 2063 0a20 00000000 		.word	courtWidth
 2064 0a24 00000000 		.word	courtHeight
 2065              		.cfi_endproc
 2066              	.LFE26:
 2068              		.align	2
 2069              		.global	main
 2070              		.code	16
 2071              		.thumb_func
 2073              	main:
 2074              	.LFB27:
 353:Z:/Media/Documents/DAT017/game\startup.c **** 
 354:Z:/Media/Documents/DAT017/game\startup.c **** int main(void){
 2075              		.loc 1 354 0
 2076              		.cfi_startproc
 2077 0a28 80B5     		push	{r7, lr}
 2078              		.cfi_def_cfa_offset 8
 2079              		.cfi_offset 7, -8
 2080              		.cfi_offset 14, -4
 2081 0a2a 00AF     		add	r7, sp, #0
 2082              		.cfi_def_cfa_register 7
 355:Z:/Media/Documents/DAT017/game\startup.c **** 	init_app();
 2083              		.loc 1 355 0
 2084 0a2c FFF7FEFF 		bl	init_app
 356:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_initalize();
 2085              		.loc 1 356 0
 2086 0a30 FFF7FEFF 		bl	graphic_initalize
 357:Z:/Media/Documents/DAT017/game\startup.c **** 	graphic_clearScreen();
 2087              		.loc 1 357 0
 2088 0a34 FFF7FEFF 		bl	graphic_clearScreen
 358:Z:/Media/Documents/DAT017/game\startup.c **** 	clearBuffers();
 2089              		.loc 1 358 0
 2090 0a38 FFF7FEFF 		bl	clearBuffers
 359:Z:/Media/Documents/DAT017/game\startup.c **** 
 360:Z:/Media/Documents/DAT017/game\startup.c **** 	setBlock(0,0,true);
 2091              		.loc 1 360 0
 2092 0a3c 0122     		movs	r2, #1
 2093 0a3e 0021     		movs	r1, #0
 2094 0a40 0020     		movs	r0, #0
 2095 0a42 FFF7FEFF 		bl	setBlock
 361:Z:/Media/Documents/DAT017/game\startup.c **** 	setBlock(1,0,true);
 2096              		.loc 1 361 0
 2097 0a46 0122     		movs	r2, #1
 2098 0a48 0021     		movs	r1, #0
 2099 0a4a 0120     		movs	r0, #1
 2100 0a4c FFF7FEFF 		bl	setBlock
 362:Z:/Media/Documents/DAT017/game\startup.c **** 	setBlock(1,1,true);
 2101              		.loc 1 362 0
 2102 0a50 0122     		movs	r2, #1
 2103 0a52 0121     		movs	r1, #1
 2104 0a54 0120     		movs	r0, #1
 2105 0a56 FFF7FEFF 		bl	setBlock
 363:Z:/Media/Documents/DAT017/game\startup.c **** 	setBlock(1,2,true);
 2106              		.loc 1 363 0
 2107 0a5a 0122     		movs	r2, #1
 2108 0a5c 0221     		movs	r1, #2
 2109 0a5e 0120     		movs	r0, #1
 2110 0a60 FFF7FEFF 		bl	setBlock
 2111              	.L131:
 364:Z:/Media/Documents/DAT017/game\startup.c **** 	
 365:Z:/Media/Documents/DAT017/game\startup.c **** 	while(1){
 366:Z:/Media/Documents/DAT017/game\startup.c **** 		clearBuffer(0);
 2112              		.loc 1 366 0 discriminator 1
 2113 0a64 0020     		movs	r0, #0
 2114 0a66 FFF7FEFF 		bl	clearBuffer
 367:Z:/Media/Documents/DAT017/game\startup.c **** 		
 368:Z:/Media/Documents/DAT017/game\startup.c **** 		drawCourt();
 2115              		.loc 1 368 0 discriminator 1
 2116 0a6a FFF7FEFF 		bl	drawCourt
 369:Z:/Media/Documents/DAT017/game\startup.c **** 		drawBlocks();
 2117              		.loc 1 369 0 discriminator 1
 2118 0a6e FFF7FEFF 		bl	drawBlocks
 370:Z:/Media/Documents/DAT017/game\startup.c **** 		
 371:Z:/Media/Documents/DAT017/game\startup.c **** 		swapBuffers();
 2119              		.loc 1 371 0 discriminator 1
 2120 0a72 FFF7FEFF 		bl	swapBuffers
 372:Z:/Media/Documents/DAT017/game\startup.c **** 		delay_milli(50);
 2121              		.loc 1 372 0 discriminator 1
 2122 0a76 3220     		movs	r0, #50
 2123 0a78 FFF7FEFF 		bl	delay_milli
 373:Z:/Media/Documents/DAT017/game\startup.c **** 	}
 2124              		.loc 1 373 0 discriminator 1
 2125 0a7c F2E7     		b	.L131
 2126              		.cfi_endproc
 2127              	.LFE27:
 2129              	.Letext0:
