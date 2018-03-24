 GNU assembler version 2.21 (propeller-elf)
	 using BFD version (propellergcc_v1_0_0_2408) 2.21.
 options passed	: -lmm -ahdlnsg=lmm/Pads.asm 
 input file    	: C:\Users\mbmis006\AppData\Local\Temp\ccrUaDFi.s
 output file   	: lmm/Pads.o
 target        	: propeller-parallax-elf
 time stamp    	: 

   1              		.text
   2              	.Ltext0
   3              		.balign	4
   4              		.global	_doPadScan
   5              	_doPadScan
   6              	.LFB2
   7              		.file 1 "Pads.c"
   1:Pads.c        **** /*
   2:Pads.c        ****  * @brief Read Finger Touch Pads
   3:Pads.c        ****  * @author Michael Burmeister
   4:Pads.c        ****  * @date March 14, 2018
   5:Pads.c        ****  * @version 1.0
   6:Pads.c        ****  */
   7:Pads.c        **** 
   8:Pads.c        **** #include "simpletools.h"
   9:Pads.c        **** #include "Pads.h"
  10:Pads.c        **** 
  11:Pads.c        **** void doPadScan(void *);
  12:Pads.c        **** 
  13:Pads.c        **** int *_pcog;
  14:Pads.c        **** 
  15:Pads.c        **** char *_P;
  16:Pads.c        **** char _T[30];
  17:Pads.c        **** 
  18:Pads.c        **** void Pads(char *p)
  19:Pads.c        **** {
  20:Pads.c        ****   _P = p;
  21:Pads.c        ****   _pcog = cog_run(&doPadScan, 50);
  22:Pads.c        **** }
  23:Pads.c        **** 
  24:Pads.c        **** void doPadScan(void *par)
  25:Pads.c        **** {
   8              		.loc 1 25 0
   9              	.LVL0
  10 0000 5B00FCA0 		mov	__TMP0,#(5<<4)+11
  11 0004 0000FC5C 		call	#__LMM_PUSHM
  12              	.LCFI0
  26:Pads.c        ****   int i, p, x;
  27:Pads.c        ****   
  28:Pads.c        ****   FRQA = 1;
  13              		.loc 1 28 0
  14 0008 0100FCA0 		mov	FRQA, #1
  15              	.LVL1
  25:Pads.c        **** {
  16              		.loc 1 25 0
  29:Pads.c        ****   
  30:Pads.c        ****   i = 0;
  17              		.loc 1 30 0
  18 000c 0000FCA0 		mov	r14, #0
  31:Pads.c        ****   while (1)
  32:Pads.c        ****   {
  33:Pads.c        ****     if (_P[i] < 0)
  34:Pads.c        ****       i = 0;
  35:Pads.c        ****     p = _P[i];
  19              		.loc 1 35 0
  20 0010 00007C5C 		mvi	r11,#__P
  20      00000000 
  36:Pads.c        ****     high(p);
  37:Pads.c        ****     pause(1);
  38:Pads.c        ****     CTRA = 4 << 26 | p;
  21              		.loc 1 38 0
  22 0018 00007C5C 		mvi	r12,#268435456
  22      00000010 
  23              	.LVL2
  24              	.L8
  35:Pads.c        ****     p = _P[i];
  25              		.loc 1 35 0
  26 0020 0000BC08 		rdlong	r7, r11
  27 0024 0000BC80 		add	r7, r14
  28 0028 0000BC00 		rdbyte	r13, r7
  29              	.LVL3
  36:Pads.c        ****     high(p);
  30              		.loc 1 36 0
  31 002c 0000BCA0 		mov	r0, r13
  32              		.loc 1 38 0
  33 0030 0000BC68 		or	r13, r12
  34              	.LVL4
  36:Pads.c        ****     high(p);
  35              		.loc 1 36 0
  36 0034 00007C5C 		lcall	#_high
  36      00000000 
  37              	.LVL5
  37:Pads.c        ****     pause(1);
  38              		.loc 1 37 0
  39 003c 0100FCA0 		mov	r0, #1
  40 0040 00007C5C 		lcall	#_pause
  40      00000000 
  39:Pads.c        ****     PHSA = 0;
  40:Pads.c        ****     pause(80);
  41              		.loc 1 40 0
  42 0048 5000FCA0 		mov	r0, #80
  38:Pads.c        ****     CTRA = 4 << 26 | p;
  43              		.loc 1 38 0
  44 004c 0000BCA0 		mov	CTRA, r13
  45              	.LVL6
  39:Pads.c        ****     PHSA = 0;
  46              		.loc 1 39 0
  47 0050 0000FCA0 		mov	PHSA, #0
  48              		.loc 1 40 0
  49 0054 00007C5C 		lcall	#_pause
  49      00000000 
  41:Pads.c        ****     x = PHSA;
  50              		.loc 1 41 0
  51 005c 0000BCA0 		mov	r7, PHSA
  52              	.LVL7
  42:Pads.c        ****     if (x < 50)
  43:Pads.c        ****       _T[i] = 'Y';
  53              		.loc 1 43 0
  54 0060 31007CC3 		cmps	r7, #49 wz,wc
  42:Pads.c        ****     if (x < 50)
  55              		.loc 1 42 0
  56 0064 00007C5C 		mvi	r7,#__T
  56      00000000 
  57              	.LVL8
  58 006c 0000BC80 		add	r7, r14
  59              		.loc 1 43 0
  60 0070 4E00C4A0 		IF_A  mov	r6,#78
  61 0074 5900F8A0 		IF_BE mov	r6,#89
  44:Pads.c        ****     else
  45:Pads.c        ****       _T[i] = 'N';
  46:Pads.c        ****     i++;
  62              		.loc 1 46 0
  63 0078 0100FC80 		add	r14, #1
  64              	.LVL9
  47:Pads.c        ****     if (i > 30)
  48:Pads.c        ****       i = 0;
  65              		.loc 1 48 0
  66 007c 1F007CC3 		cmps	r14, #31 wz,wc
  42:Pads.c        ****     if (x < 50)
  67              		.loc 1 42 0
  68 0080 00003C00 		wrbyte	r6, r7
  69              		.loc 1 48 0
  70 0084 0000FCA0 		mov	r7, #0
  71 0088 0000BC70 		muxc	r7,r14
  72 008c 0000BCA0 		mov	r14, r7
  73              	.LVL10
  74 0090 7400FC84 		brs	#.L8
  75              	.LFE2
  76              		.balign	4
  77              		.global	_Pads
  78              	_Pads
  79              	.LFB1
  19:Pads.c        **** {
  80              		.loc 1 19 0
  81              	.LVL11
  82 0094 0400FC84 		sub	sp, #4
  83              	.LCFI1
  84 0098 00003C08 		wrlong	lr, sp
  85              	.LCFI2
  20:Pads.c        ****   _P = p;
  86              		.loc 1 20 0
  87 009c 00007C5C 		mvi	r7,#__P
  87      00000000 
  21:Pads.c        ****   _pcog = cog_run(&doPadScan, 50);
  88              		.loc 1 21 0
  89 00a4 3200FCA0 		mov	r1, #50
  20:Pads.c        ****   _P = p;
  90              		.loc 1 20 0
  91 00a8 00003C08 		wrlong	r0, r7
  21:Pads.c        ****   _pcog = cog_run(&doPadScan, 50);
  92              		.loc 1 21 0
  93 00ac 00007C5C 		mvi	r0,#_doPadScan
  93      00000000 
  94              	.LVL12
  95 00b4 00007C5C 		lcall	#_cog_run
  95      00000000 
  96              	.LVL13
  97 00bc 00007C5C 		mvi	r7,#__pcog
  97      00000000 
  98 00c4 00003C08 		wrlong	r0, r7
  22:Pads.c        **** }
  99              		.loc 1 22 0
 100 00c8 0000BC08 		rdlong	lr, sp
 101 00cc 0400FC80 		add	sp, #4
 102 00d0 0000BCA0 		mov	pc,lr
 103              	.LFE1
 104              		.balign	4
 105              		.global	_getPads
 106              	_getPads
 107              	.LFB3
  49:Pads.c        ****   }
  50:Pads.c        **** }      
  51:Pads.c        **** 
  52:Pads.c        **** void getPads(char *t)
  53:Pads.c        **** {
 108              		.loc 1 53 0
 109              	.LVL14
  54:Pads.c        ****   t = _T;
  55:Pads.c        **** }
 110              		.loc 1 55 0
 111 00d4 0000BCA0 		mov	pc,lr
 112              	.LFE3
 113              		.comm	__T,30,4
 114              		.comm	__P,4,4
 115              		.comm	__pcog,4,4
 181              	.Letext0
 182              		.file 2 "D:/Documents/SimpleIDE/Learn/Simple Libraries/TextDevices/libsimpletext/simpletext.h"
 183              		.file 3 "c:\\program files (x86)\\simpleide\\propeller-gcc\\bin\\../lib/gcc/propeller-elf/4.6.1/..
DEFINED SYMBOLS
C:\Users\mbmis006\AppData\Local\Temp\ccrUaDFi.s:5      .text:00000000 _doPadScan
C:\Users\mbmis006\AppData\Local\Temp\ccrUaDFi.s:10     .text:00000000 L0
                            *COM*:00000004 __P
                            *COM*:0000001e __T
C:\Users\mbmis006\AppData\Local\Temp\ccrUaDFi.s:78     .text:00000094 _Pads
                            *COM*:00000004 __pcog
C:\Users\mbmis006\AppData\Local\Temp\ccrUaDFi.s:106    .text:000000d4 _getPads
                     .debug_frame:00000000 .Lframe0
                            .text:00000000 .LFB2
                            .text:00000094 .LFB1
                            .text:000000d4 .LFB3
                    .debug_abbrev:00000000 .Ldebug_abbrev0
                            .text:00000000 .Ltext0
                            .text:000000d8 .Letext0
                      .debug_line:00000000 .Ldebug_line0
                            .text:00000094 .LFE2
                       .debug_loc:00000000 .LLST0
                       .debug_loc:00000020 .LLST1
                       .debug_loc:00000033 .LLST2
                       .debug_loc:00000052 .LLST3
                       .debug_loc:00000070 .LLST4
                            .text:000000d4 .LFE1
                       .debug_loc:00000083 .LLST5
                       .debug_loc:000000a3 .LLST6
                            .text:000000d8 .LFE3
                      .debug_info:00000000 .Ldebug_info0

UNDEFINED SYMBOLS
__TMP0
__LMM_PUSHM
__LMM_PUSHM_ret
FRQA
r14
__LMM_MVI_r11
__LMM_MVI_r12
r7
r11
r13
r0
r12
__LMM_CALL
_high
_pause
CTRA
PHSA
__LMM_MVI_r7
r6
pc
sp
lr
r1
__LMM_MVI_r0
_cog_run
