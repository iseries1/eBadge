 GNU assembler version 2.21 (propeller-elf)
	 using BFD version (propellergcc_v1_0_0_2408) 2.21.
 options passed	: -lmm -ahdlnsg=lmm/SSD1306.asm 
 input file    	: C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s
 output file   	: lmm/SSD1306.o
 target        	: propeller-parallax-elf
 time stamp    	: 

   1              		.text
   2              	.Ltext0
   3              		.balign	4
   4              		.global	_SSD1306_write
   5              	_SSD1306_write
   6              	.LFB2
   7              		.file 1 "SSD1306.c"
   1:SSD1306.c     **** /*
   2:SSD1306.c     ****  * @brief SSD1306 Display Driver
   3:SSD1306.c     ****  * @author Michael Burmeister
   4:SSD1306.c     ****  * @date March 14, 2018
   5:SSD1306.c     ****  * @version 1.0
   6:SSD1306.c     ****  */
   7:SSD1306.c     **** 
   8:SSD1306.c     **** #include "simpletools.h"
   9:SSD1306.c     **** #include "SSD1306.h"
  10:SSD1306.c     **** #include "SSD1306cmd.h"
  11:SSD1306.c     **** 
  12:SSD1306.c     **** int _CS;
  13:SSD1306.c     **** int _DC;
  14:SSD1306.c     **** int _SDA;
  15:SSD1306.c     **** int _SCL;
  16:SSD1306.c     **** int _RST;
  17:SSD1306.c     **** int _Auto;
  18:SSD1306.c     **** int _Width;
  19:SSD1306.c     **** int _Height;
  20:SSD1306.c     **** char _Buffer[LCD_BUFFER_SIZE_BOTH_TYPES];
  21:SSD1306.c     **** 
  22:SSD1306.c     **** 
  23:SSD1306.c     **** int SSD1306_init(int cs, int dc, int sda, int scl, int rst, int s, int t)
  24:SSD1306.c     **** {
  25:SSD1306.c     ****   _CS = cs;
  26:SSD1306.c     ****   _DC = dc;
  27:SSD1306.c     ****   _SDA = sda;
  28:SSD1306.c     ****   _SCL = scl;
  29:SSD1306.c     ****   _RST = rst;
  30:SSD1306.c     ****   _Auto = 0;
  31:SSD1306.c     ****   
  32:SSD1306.c     ****   if (t == TYPE_128X32)
  33:SSD1306.c     ****   {
  34:SSD1306.c     ****     _Width = SSD1306_LCDWIDTH;
  35:SSD1306.c     ****     _Height = SSD1306_LCDHEIGHT32;
  36:SSD1306.c     ****   }
  37:SSD1306.c     ****   else
  38:SSD1306.c     ****   {
  39:SSD1306.c     ****     _Width = SSD1306_LCDWIDTH;
  40:SSD1306.c     ****     _Height = SSD1306_LCDHEIGHT64;
  41:SSD1306.c     ****   }
  42:SSD1306.c     ****   
  43:SSD1306.c     ****   //reset display
  44:SSD1306.c     ****   high(_RST);
  45:SSD1306.c     ****   pause(10);
  46:SSD1306.c     ****   low(_RST);
  47:SSD1306.c     ****   pause(10);
  48:SSD1306.c     ****   high(_RST);
  49:SSD1306.c     **** 
  50:SSD1306.c     ****   SSD1306_cmd(SSD1306_DISPLAYOFF);
  51:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETDISPLAYCLOCKDIV);
  52:SSD1306.c     ****   SSD1306_cmd(0x80);
  53:SSD1306.c     ****   
  54:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETMULTIPLEX);
  55:SSD1306.c     ****   SSD1306_cmd(_Height - 1);
  56:SSD1306.c     **** 
  57:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETDISPLAYOFFSET);
  58:SSD1306.c     ****   SSD1306_cmd(0x0);
  59:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETSTARTLINE);
  60:SSD1306.c     ****   SSD1306_cmd(SSD1306_CHARGEPUMP);
  61:SSD1306.c     ****   if (s == SSD1306_EXTERNALVCC)
  62:SSD1306.c     ****     SSD1306_cmd(0x10);
  63:SSD1306.c     ****   else
  64:SSD1306.c     ****     SSD1306_cmd(0x14);
  65:SSD1306.c     ****   SSD1306_cmd(SSD1306_MEMORYMODE);
  66:SSD1306.c     ****   SSD1306_cmd(0x00);
  67:SSD1306.c     ****   SSD1306_cmd(SSD1306_SEGREMAP | 0x1);
  68:SSD1306.c     ****   SSD1306_cmd(SSD1306_COMSCANDEC);
  69:SSD1306.c     ****   
  70:SSD1306.c     ****   if (t == TYPE_128X32)
  71:SSD1306.c     ****   {
  72:SSD1306.c     ****     SSD1306_cmd(SSD1306_SETCOMPINS);
  73:SSD1306.c     ****     SSD1306_cmd(0x02);
  74:SSD1306.c     ****     SSD1306_cmd(SSD1306_SETCONTRAST);
  75:SSD1306.c     ****     SSD1306_cmd(0x8F);
  76:SSD1306.c     ****   }    
  77:SSD1306.c     ****   
  78:SSD1306.c     ****   if (t == TYPE_128X64)
  79:SSD1306.c     ****   {
  80:SSD1306.c     ****     SSD1306_cmd(SSD1306_SETCOMPINS);
  81:SSD1306.c     ****     SSD1306_cmd(0x12);
  82:SSD1306.c     ****     SSD1306_cmd(SSD1306_SETCONTRAST);
  83:SSD1306.c     ****     if (s == SSD1306_EXTERNALVCC)
  84:SSD1306.c     ****       SSD1306_cmd(0x9F);
  85:SSD1306.c     ****     else
  86:SSD1306.c     ****       SSD1306_cmd(0xCF);
  87:SSD1306.c     ****   }
  88:SSD1306.c     ****   
  89:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETPRECHARGE);
  90:SSD1306.c     ****   if (s == SSD1306_EXTERNALVCC)
  91:SSD1306.c     ****     SSD1306_cmd(0x22);
  92:SSD1306.c     ****   else
  93:SSD1306.c     ****     SSD1306_cmd(0xF1);
  94:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETVCOMDETECT);
  95:SSD1306.c     ****   SSD1306_cmd(0x40);
  96:SSD1306.c     ****   SSD1306_cmd(SSD1306_DISPLAYALLON_RESUME);
  97:SSD1306.c     ****   SSD1306_cmd(SSD1306_NORMALDISPLAY);
  98:SSD1306.c     ****   SSD1306_cmd(SSD1306_DEACTIVATE_SCROLL);
  99:SSD1306.c     ****   SSD1306_cmd(SSD1306_DISPLAYON);
 100:SSD1306.c     ****   SSD1306_invert(0);
 101:SSD1306.c     ****   SSD1306_cls();
 102:SSD1306.c     **** }
 103:SSD1306.c     **** 
 104:SSD1306.c     **** void SSD1306_write(char b)
 105:SSD1306.c     **** {
   8              		.loc 1 105 0
   9              	.LVL0
  10 0000 3D00FCA0 		mov	__TMP0,#(3<<4)+13
  11 0004 0000FC5C 		call	#__LMM_PUSHM
  12              	.LCFI0
 106:SSD1306.c     ****   low(_CS);
  13              		.loc 1 106 0
  14 0008 00007C5C 		mvi	r14,#__CS
  14      00000000 
 105:SSD1306.c     **** {
  15              		.loc 1 105 0
  16 0010 0000BCA0 		mov	r13, r0
  17              		.loc 1 106 0
  18 0014 0000BC08 		rdlong	r0, r14
  19              	.LVL1
  20 0018 00007C5C 		lcall	#_low
  20      00000000 
 107:SSD1306.c     ****   shift_out(_SDA, _SCL, MSBFIRST, 8, b);
  21              		.loc 1 107 0
  22 0020 00007C5C 		mvi	r7,#__SDA
  22      00000000 
  23 0028 00007C5C 		mvi	r6,#__SCL
  23      00000000 
  24 0030 0100FCA0 		mov	r2, #1
  25 0034 0800FCA0 		mov	r3, #8
  26 0038 0000BCA0 		mov	r4, r13
  27 003c 0000BC08 		rdlong	r7, r7
  28 0040 0000BCA0 		mov	r0, r7
  29 0044 0000BC08 		rdlong	r1, r6
  30 0048 00007C5C 		lcall	#_shift_out
  30      00000000 
 108:SSD1306.c     ****   high(_CS);
  31              		.loc 1 108 0
  32 0050 0000BC08 		rdlong	r0, r14
  33 0054 00007C5C 		lcall	#_high
  33      00000000 
 109:SSD1306.c     **** }
  34              		.loc 1 109 0
  35 005c 3F00FCA0 		mov	__TMP0,#(3<<4)+15
  36 0060 0000FC5C 		call	#__LMM_POPRET
  37              		'' never returns
  38              	.LFE2
  39              		.balign	4
  40              		.global	_SSD1306_cmd
  41              	_SSD1306_cmd
  42              	.LFB3
 110:SSD1306.c     **** 
 111:SSD1306.c     **** void SSD1306_cmd(char c)
 112:SSD1306.c     **** {
  43              		.loc 1 112 0
  44              	.LVL2
  45 0064 3D00FCA0 		mov	__TMP0,#(3<<4)+13
  46 0068 0000FC5C 		call	#__LMM_PUSHM
  47              	.LCFI1
 113:SSD1306.c     ****   low(_DC);
  48              		.loc 1 113 0
  49 006c 00007C5C 		mvi	r14,#__DC
  49      00000000 
 112:SSD1306.c     **** {
  50              		.loc 1 112 0
  51 0074 0000BCA0 		mov	r13, r0
  52              		.loc 1 113 0
  53 0078 0000BC08 		rdlong	r0, r14
  54              	.LVL3
  55 007c 00007C5C 		lcall	#_low
  55      00000000 
 114:SSD1306.c     ****   SSD1306_write(c);
  56              		.loc 1 114 0
  57 0084 0000BCA0 		mov	r0, r13
  58 0088 00007C5C 		lcall	#_SSD1306_write
  58      00000000 
 115:SSD1306.c     ****   high(_DC);
  59              		.loc 1 115 0
  60 0090 0000BC08 		rdlong	r0, r14
  61 0094 00007C5C 		lcall	#_high
  61      00000000 
 116:SSD1306.c     **** }
  62              		.loc 1 116 0
  63 009c 3F00FCA0 		mov	__TMP0,#(3<<4)+15
  64 00a0 0000FC5C 		call	#__LMM_POPRET
  65              		'' never returns
  66              	.LFE3
  67              		.balign	4
  68              		.global	_SSD1306_invert
  69              	_SSD1306_invert
  70              	.LFB4
 117:SSD1306.c     **** 
 118:SSD1306.c     **** void SSD1306_invert(int i)
 119:SSD1306.c     **** {
  71              		.loc 1 119 0
  72              	.LVL4
  73 00a4 0400FC84 		sub	sp, #4
  74              	.LCFI2
  75 00a8 00003C08 		wrlong	lr, sp
  76              	.LCFI3
 120:SSD1306.c     ****   if (i)
  77              		.loc 1 120 0
  78 00ac 00007CC3 		cmps	r0, #0 wz,wc
 121:SSD1306.c     ****     SSD1306_cmd(SSD1306_INVERTDISPLAY);
  79              		.loc 1 121 0
  80 00b0 A700D4A0 		IF_NE mov	r0, #167
  81              	.LVL5
 122:SSD1306.c     ****   else
 123:SSD1306.c     ****     SSD1306_cmd(SSD1306_NORMALDISPLAY);
  82              		.loc 1 123 0
  83 00b4 A600E8A0 		IF_E  mov	r0, #166
  84 00b8 00007C5C 		lcall	#_SSD1306_cmd
  84      00000000 
 124:SSD1306.c     **** }
  85              		.loc 1 124 0
  86 00c0 0000BC08 		rdlong	lr, sp
  87 00c4 0400FC80 		add	sp, #4
  88 00c8 0000BCA0 		mov	pc,lr
  89              	.LFE4
  90              		.balign	4
  91              		.global	_SSD1306_auto
  92              	_SSD1306_auto
  93              	.LFB5
 125:SSD1306.c     **** 
 126:SSD1306.c     **** void SSD1306_auto(int a)
 127:SSD1306.c     **** {
  94              		.loc 1 127 0
  95              	.LVL6
 128:SSD1306.c     ****   _Auto = a;
  96              		.loc 1 128 0
  97 00cc 00007C5C 		mvi	r7,#__Auto
  97      00000000 
  98 00d4 00003C08 		wrlong	r0, r7
 129:SSD1306.c     **** }
  99              		.loc 1 129 0
 100 00d8 0000BCA0 		mov	pc,lr
 101              	.LFE5
 102              		.balign	4
 103              		.global	_SSD1306_update
 104              	_SSD1306_update
 105              	.LFB6
 130:SSD1306.c     **** 
 131:SSD1306.c     **** void SSD1306_update()
 132:SSD1306.c     **** {
 106              		.loc 1 132 0
 107 00dc 7900FCA0 		mov	__TMP0,#(7<<4)+9
 108 00e0 0000FC5C 		call	#__LMM_PUSHM
 109              	.LCFI4
 133:SSD1306.c     ****   int k;
 134:SSD1306.c     ****   
 135:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETLOWCOLUMN);
 110              		.loc 1 135 0
 111 00e4 0000FCA0 		mov	r0, #0
 112              	.LBB2
 136:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETHIGHCOLUMN);
 137:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETSTARTLINE);
 138:SSD1306.c     ****   
 139:SSD1306.c     ****   k = 0;
 140:SSD1306.c     ****   low(_CS);
 141:SSD1306.c     ****   for (int i=0;i<_Width;i++)
 113              		.loc 1 141 0
 114 00e8 0000FCA0 		mov	r12, #0
 139:SSD1306.c     ****   k = 0;
 115              		.loc 1 139 0
 116 00ec 0000FCA0 		mov	r13, #0
 117              		.loc 1 141 0
 118 00f0 00007C5C 		mvi	r10,#__Width
 118      00000000 
 119              	.LBE2
 135:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETLOWCOLUMN);
 120              		.loc 1 135 0
 121 00f8 00007C5C 		lcall	#_SSD1306_cmd
 121      00000000 
 136:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETHIGHCOLUMN);
 122              		.loc 1 136 0
 123 0100 1000FCA0 		mov	r0, #16
 124              	.LBB6
 125              	.LBB3
 142:SSD1306.c     ****   {
 143:SSD1306.c     ****     for (int j=0;j<_Height/8;j++)
 126              		.loc 1 143 0
 127 0104 00007C5C 		mvi	r11,#__Height
 127      00000000 
 128              	.LBE3
 129              	.LBE6
 136:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETHIGHCOLUMN);
 130              		.loc 1 136 0
 131 010c 00007C5C 		lcall	#_SSD1306_cmd
 131      00000000 
 137:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETSTARTLINE);
 132              		.loc 1 137 0
 133 0114 4000FCA0 		mov	r0, #64
 134 0118 00007C5C 		lcall	#_SSD1306_cmd
 134      00000000 
 135              	.LVL7
 140:SSD1306.c     ****   low(_CS);
 136              		.loc 1 140 0
 137 0120 00007C5C 		mvi	r7,#__CS
 137      00000000 
 138 0128 0000BC08 		rdlong	r0, r7
 139 012c 00007C5C 		lcall	#_low
 139      00000000 
 140              	.LVL8
 141              	.LBB7
 141:SSD1306.c     ****   for (int i=0;i<_Width;i++)
 142              		.loc 1 141 0
 143 0134 5C00FC80 		brs	#.L9
 144              	.LVL9
 145              	.L10
 146              	.LBB4
 144:SSD1306.c     ****       shift_out(_SDA, _SCL, MSBFIRST, 8, _Buffer[k++]);
 147              		.loc 1 144 0 discriminator 2
 148 0138 00007C5C 		mvi	r7,#__SCL
 148      00000000 
 149              	.LVL10
 150 0140 0100FCA0 		mov	r2, #1
 151 0144 0800FCA0 		mov	r3, #8
 152 0148 0100FC80 		add	r14, #1
 153              	.LVL11
 154 014c 0000BC08 		rdlong	r1, r7
 131:SSD1306.c     **** void SSD1306_update()
 155              		.loc 1 131 0 discriminator 2
 156 0150 00007C5C 		mvi	r7,#__Buffer
 156      00000000 
 157 0158 0000BC80 		add	r7, r6
 158              		.loc 1 144 0 discriminator 2
 159 015c 0000BC08 		rdlong	r0, r9
 160 0160 0000BC00 		rdbyte	r4, r7
 161 0164 00007C5C 		lcall	#_shift_out
 161      00000000 
 162              	.L12
 131:SSD1306.c     **** void SSD1306_update()
 163              		.loc 1 131 0 discriminator 1
 164 016c 0000BCA0 		mov	r7, r14
 143:SSD1306.c     ****     for (int j=0;j<_Height/8;j++)
 165              		.loc 1 143 0 discriminator 1
 166 0170 0800FCA0 		mov	r1, #8
 131:SSD1306.c     **** void SSD1306_update()
 167              		.loc 1 131 0 discriminator 1
 168 0174 0000BC84 		sub	r7, r13
 169 0178 0000BCA0 		mov	r6, r14
 170              	.LVL12
 143:SSD1306.c     ****     for (int j=0;j<_Height/8;j++)
 171              		.loc 1 143 0 discriminator 1
 172 017c 0000BC08 		rdlong	r0, r11
 173 0180 0000FC5C 		call	#__DIVSI
 174 0184 00003CC3 		cmps	r7, r0 wz,wc
 175 0188 5400F084 		IF_B 	brs	#.L10
 176              	.LVL13
 177              	.LBE4
 141:SSD1306.c     ****   for (int i=0;i<_Width;i++)
 178              		.loc 1 141 0
 179 018c 0100FC80 		add	r12, #1
 180              	.LVL14
 181 0190 0000BCA0 		mov	r13, r14
 182              	.LVL15
 183              	.L9
 141:SSD1306.c     ****   for (int i=0;i<_Width;i++)
 184              		.loc 1 141 0 is_stmt 0 discriminator 1
 185 0194 0000BC08 		rdlong	r7, r10
 186 0198 00003CC3 		cmps	r12, r7 wz,wc
 187 019c 1000CC80 		IF_AE	brs	#.L11
 188 01a0 0000BCA0 		mov	r14, r13
 189              	.LBB5
 190              		.loc 1 144 0 is_stmt 1 discriminator 1
 191 01a4 00007C5C 		mvi	r9,#__SDA
 191      00000000 
 192 01ac 4400FC84 		brs	#.L12
 193              	.L11
 194              	.LBE5
 195              	.LBE7
 145:SSD1306.c     ****   }
 146:SSD1306.c     ****   high(_CS);  
 196              		.loc 1 146 0
 197 01b0 00007C5C 		mvi	r7,#__CS
 197      00000000 
 198 01b8 0000BC08 		rdlong	r0, r7
 199 01bc 00007C5C 		lcall	#_high
 199      00000000 
 147:SSD1306.c     **** }
 200              		.loc 1 147 0
 201 01c4 7F00FCA0 		mov	__TMP0,#(7<<4)+15
 202 01c8 0000FC5C 		call	#__LMM_POPRET
 203              		'' never returns
 204              	.LFE6
 205              		.balign	4
 206              		.global	_SSD1306_cls
 207              	_SSD1306_cls
 208              	.LFB7
 148:SSD1306.c     ****   
 149:SSD1306.c     **** void SSD1306_cls()
 150:SSD1306.c     **** {
 209              		.loc 1 150 0
 210 01cc 0400FC84 		sub	sp, #4
 211              	.LCFI5
 212 01d0 00003C08 		wrlong	lr, sp
 213              	.LCFI6
 151:SSD1306.c     ****   memset(&_Buffer, 0, sizeof(_Buffer));
 214              		.loc 1 151 0
 215 01d4 0000FCA0 		mov	r1, #0
 216 01d8 00007C5C 		mvi	r2,#1024
 216      00040000 
 217 01e0 00007C5C 		mvi	r0,#__Buffer
 217      00000000 
 218 01e8 00007C5C 		lcall	#_memset
 218      00000000 
 152:SSD1306.c     ****   SSD1306_update();
 219              		.loc 1 152 0
 220 01f0 00007C5C 		lcall	#_SSD1306_update
 220      00000000 
 153:SSD1306.c     **** }
 221              		.loc 1 153 0
 222 01f8 0000BC08 		rdlong	lr, sp
 223 01fc 0400FC80 		add	sp, #4
 224 0200 0000BCA0 		mov	pc,lr
 225              	.LFE7
 226              		.balign	4
 227              		.global	_SSD1306_init
 228              	_SSD1306_init
 229              	.LFB1
  24:SSD1306.c     **** {
 230              		.loc 1 24 0
 231              	.LVL16
 232 0204 4C00FCA0 		mov	__TMP0,#(4<<4)+12
 233 0208 0000FC5C 		call	#__LMM_PUSHM
 234              	.LCFI7
  24:SSD1306.c     **** {
 235              		.loc 1 24 0
 236 020c 0000BCA0 		mov	r7, sp
 237 0210 1000FC80 		add	r7, #16
  30:SSD1306.c     ****   _Auto = 0;
 238              		.loc 1 30 0
 239 0214 0000FCA0 		mov	r6, #0
  24:SSD1306.c     **** {
 240              		.loc 1 24 0
 241 0218 0000BCA0 		mov	r14, r5
  46:SSD1306.c     ****   low(_RST);
 242              		.loc 1 46 0
 243 021c 00007C5C 		mvi	r12,#__RST
 243      00000000 
  24:SSD1306.c     **** {
 244              		.loc 1 24 0
 245 0224 0000BC08 		rdlong	r13, r7
  25:SSD1306.c     ****   _CS = cs;
 246              		.loc 1 25 0
 247 0228 00007C5C 		mvi	r7,#__CS
 247      00000000 
  32:SSD1306.c     ****   if (t == TYPE_128X32)
 248              		.loc 1 32 0
 249 0230 20007CC3 		cmps	r13, #32 wz,wc
  25:SSD1306.c     ****   _CS = cs;
 250              		.loc 1 25 0
 251 0234 00003C08 		wrlong	r0, r7
  26:SSD1306.c     ****   _DC = dc;
 252              		.loc 1 26 0
 253 0238 00007C5C 		mvi	r7,#__DC
 253      00000000 
  44:SSD1306.c     ****   high(_RST);
 254              		.loc 1 44 0
 255 0240 0000BCA0 		mov	r0, r4
 256              	.LVL17
  26:SSD1306.c     ****   _DC = dc;
 257              		.loc 1 26 0
 258 0244 00003C08 		wrlong	r1, r7
  27:SSD1306.c     ****   _SDA = sda;
 259              		.loc 1 27 0
 260 0248 00007C5C 		mvi	r7,#__SDA
 260      00000000 
 261 0250 00003C08 		wrlong	r2, r7
  28:SSD1306.c     ****   _SCL = scl;
 262              		.loc 1 28 0
 263 0254 00007C5C 		mvi	r7,#__SCL
 263      00000000 
 264 025c 00003C08 		wrlong	r3, r7
  29:SSD1306.c     ****   _RST = rst;
 265              		.loc 1 29 0
 266 0260 00007C5C 		mvi	r7,#__RST
 266      00000000 
 267 0268 00003C08 		wrlong	r4, r7
  30:SSD1306.c     ****   _Auto = 0;
 268              		.loc 1 30 0
 269 026c 00007C5C 		mvi	r7,#__Auto
 269      00000000 
 270 0274 00003C08 		wrlong	r6, r7
  34:SSD1306.c     ****     _Width = SSD1306_LCDWIDTH;
 271              		.loc 1 34 0
 272 0278 8000FCA0 		mov	r6, #128
 273 027c 00007C5C 		mvi	r7,#__Width
 273      00000000 
 274 0284 00003C08 		wrlong	r6, r7
  35:SSD1306.c     ****     _Height = SSD1306_LCDHEIGHT32;
 275              		.loc 1 35 0
 276 0288 2000E8A0 		IF_E  mov	r6, #32
  40:SSD1306.c     ****     _Height = SSD1306_LCDHEIGHT64;
 277              		.loc 1 40 0
 278 028c 4000D4A0 		IF_NE mov	r6, #64
  35:SSD1306.c     ****     _Height = SSD1306_LCDHEIGHT32;
 279              		.loc 1 35 0
 280 0290 00007C5C 		mvi	r7,#__Height
 280      00000000 
  40:SSD1306.c     ****     _Height = SSD1306_LCDHEIGHT64;
 281              		.loc 1 40 0
 282 0298 00003C08 		wrlong	r6, r7
  44:SSD1306.c     ****   high(_RST);
 283              		.loc 1 44 0
 284 029c 00007C5C 		lcall	#_high
 284      00000000 
 285              	.LVL18
  45:SSD1306.c     ****   pause(10);
 286              		.loc 1 45 0
 287 02a4 0A00FCA0 		mov	r0, #10
 288 02a8 00007C5C 		lcall	#_pause
 288      00000000 
  46:SSD1306.c     ****   low(_RST);
 289              		.loc 1 46 0
 290 02b0 0000BC08 		rdlong	r0, r12
 291 02b4 00007C5C 		lcall	#_low
 291      00000000 
  47:SSD1306.c     ****   pause(10);
 292              		.loc 1 47 0
 293 02bc 0A00FCA0 		mov	r0, #10
 294 02c0 00007C5C 		lcall	#_pause
 294      00000000 
  48:SSD1306.c     ****   high(_RST);
 295              		.loc 1 48 0
 296 02c8 0000BC08 		rdlong	r0, r12
 297 02cc 00007C5C 		lcall	#_high
 297      00000000 
  50:SSD1306.c     ****   SSD1306_cmd(SSD1306_DISPLAYOFF);
 298              		.loc 1 50 0
 299 02d4 AE00FCA0 		mov	r0, #174
 300 02d8 00007C5C 		lcall	#_SSD1306_cmd
 300      00000000 
  51:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETDISPLAYCLOCKDIV);
 301              		.loc 1 51 0
 302 02e0 D500FCA0 		mov	r0, #213
 303 02e4 00007C5C 		lcall	#_SSD1306_cmd
 303      00000000 
  52:SSD1306.c     ****   SSD1306_cmd(0x80);
 304              		.loc 1 52 0
 305 02ec 8000FCA0 		mov	r0, #128
 306 02f0 00007C5C 		lcall	#_SSD1306_cmd
 306      00000000 
  54:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETMULTIPLEX);
 307              		.loc 1 54 0
 308 02f8 A800FCA0 		mov	r0, #168
 309 02fc 00007C5C 		lcall	#_SSD1306_cmd
 309      00000000 
  55:SSD1306.c     ****   SSD1306_cmd(_Height - 1);
 310              		.loc 1 55 0
 311 0304 00007C5C 		mvi	r7,#__Height
 311      00000000 
 312 030c 0000BC08 		rdlong	r0, r7
 313 0310 0100FC84 		sub	r0, #1
 314 0314 FF00FC60 		and	r0,#255
 315 0318 00007C5C 		lcall	#_SSD1306_cmd
 315      00000000 
  57:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETDISPLAYOFFSET);
 316              		.loc 1 57 0
 317 0320 D300FCA0 		mov	r0, #211
 318 0324 00007C5C 		lcall	#_SSD1306_cmd
 318      00000000 
  58:SSD1306.c     ****   SSD1306_cmd(0x0);
 319              		.loc 1 58 0
 320 032c 0000FCA0 		mov	r0, #0
 321 0330 00007C5C 		lcall	#_SSD1306_cmd
 321      00000000 
  59:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETSTARTLINE);
 322              		.loc 1 59 0
 323 0338 4000FCA0 		mov	r0, #64
 324 033c 00007C5C 		lcall	#_SSD1306_cmd
 324      00000000 
  60:SSD1306.c     ****   SSD1306_cmd(SSD1306_CHARGEPUMP);
 325              		.loc 1 60 0
 326 0344 8D00FCA0 		mov	r0, #141
 327 0348 00007C5C 		lcall	#_SSD1306_cmd
 327      00000000 
  61:SSD1306.c     ****   if (s == SSD1306_EXTERNALVCC)
 328              		.loc 1 61 0
 329 0350 01007CC3 		cmps	r14, #1 wz,wc
  62:SSD1306.c     ****     SSD1306_cmd(0x10);
 330              		.loc 1 62 0
 331 0354 1000E8A0 		IF_E  mov	r0, #16
  64:SSD1306.c     ****     SSD1306_cmd(0x14);
 332              		.loc 1 64 0
 333 0358 1400D4A0 		IF_NE mov	r0, #20
 334 035c 00007C5C 		lcall	#_SSD1306_cmd
 334      00000000 
  65:SSD1306.c     ****   SSD1306_cmd(SSD1306_MEMORYMODE);
 335              		.loc 1 65 0
 336 0364 2000FCA0 		mov	r0, #32
 337 0368 00007C5C 		lcall	#_SSD1306_cmd
 337      00000000 
  66:SSD1306.c     ****   SSD1306_cmd(0x00);
 338              		.loc 1 66 0
 339 0370 0000FCA0 		mov	r0, #0
 340 0374 00007C5C 		lcall	#_SSD1306_cmd
 340      00000000 
  67:SSD1306.c     ****   SSD1306_cmd(SSD1306_SEGREMAP | 0x1);
 341              		.loc 1 67 0
 342 037c A100FCA0 		mov	r0, #161
 343 0380 00007C5C 		lcall	#_SSD1306_cmd
 343      00000000 
  68:SSD1306.c     ****   SSD1306_cmd(SSD1306_COMSCANDEC);
 344              		.loc 1 68 0
 345 0388 C800FCA0 		mov	r0, #200
 346 038c 00007C5C 		lcall	#_SSD1306_cmd
 346      00000000 
  70:SSD1306.c     ****   if (t == TYPE_128X32)
 347              		.loc 1 70 0
 348 0394 20007CC3 		cmps	r13, #32 wz,wc
 349 0398 2C00D480 		IF_NE	brs	#.L19
  72:SSD1306.c     ****     SSD1306_cmd(SSD1306_SETCOMPINS);
 350              		.loc 1 72 0
 351 039c DA00FCA0 		mov	r0, #218
 352 03a0 00007C5C 		lcall	#_SSD1306_cmd
 352      00000000 
  73:SSD1306.c     ****     SSD1306_cmd(0x02);
 353              		.loc 1 73 0
 354 03a8 0200FCA0 		mov	r0, #2
 355 03ac 00007C5C 		lcall	#_SSD1306_cmd
 355      00000000 
  74:SSD1306.c     ****     SSD1306_cmd(SSD1306_SETCONTRAST);
 356              		.loc 1 74 0
 357 03b4 8100FCA0 		mov	r0, #129
 358 03b8 00007C5C 		lcall	#_SSD1306_cmd
 358      00000000 
  75:SSD1306.c     ****     SSD1306_cmd(0x8F);
 359              		.loc 1 75 0
 360 03c0 8F00FCA0 		mov	r0, #143
 361 03c4 3800FC80 		brs	#.L26
 362              	.L19
  78:SSD1306.c     ****   if (t == TYPE_128X64)
 363              		.loc 1 78 0
 364 03c8 40007CC3 		cmps	r13, #64 wz,wc
 365 03cc 3800D480 		IF_NE	brs	#.L20
  80:SSD1306.c     ****     SSD1306_cmd(SSD1306_SETCOMPINS);
 366              		.loc 1 80 0
 367 03d0 DA00FCA0 		mov	r0, #218
 368 03d4 00007C5C 		lcall	#_SSD1306_cmd
 368      00000000 
  81:SSD1306.c     ****     SSD1306_cmd(0x12);
 369              		.loc 1 81 0
 370 03dc 1200FCA0 		mov	r0, #18
 371 03e0 00007C5C 		lcall	#_SSD1306_cmd
 371      00000000 
  82:SSD1306.c     ****     SSD1306_cmd(SSD1306_SETCONTRAST);
 372              		.loc 1 82 0
 373 03e8 8100FCA0 		mov	r0, #129
 374 03ec 00007C5C 		lcall	#_SSD1306_cmd
 374      00000000 
  83:SSD1306.c     ****     if (s == SSD1306_EXTERNALVCC)
 375              		.loc 1 83 0
 376 03f4 01007CC3 		cmps	r14, #1 wz,wc
  84:SSD1306.c     ****       SSD1306_cmd(0x9F);
 377              		.loc 1 84 0
 378 03f8 9F00E8A0 		IF_E  mov	r0, #159
  86:SSD1306.c     ****       SSD1306_cmd(0xCF);
 379              		.loc 1 86 0
 380 03fc CF00D4A0 		IF_NE mov	r0, #207
 381              	.L26
 382 0400 00007C5C 		lcall	#_SSD1306_cmd
 382      00000000 
 383              	.L20
  89:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETPRECHARGE);
 384              		.loc 1 89 0
 385 0408 D900FCA0 		mov	r0, #217
 386 040c 00007C5C 		lcall	#_SSD1306_cmd
 386      00000000 
  90:SSD1306.c     ****   if (s == SSD1306_EXTERNALVCC)
 387              		.loc 1 90 0
 388 0414 01007CC3 		cmps	r14, #1 wz,wc
  91:SSD1306.c     ****     SSD1306_cmd(0x22);
 389              		.loc 1 91 0
 390 0418 2200E8A0 		IF_E  mov	r0, #34
  93:SSD1306.c     ****     SSD1306_cmd(0xF1);
 391              		.loc 1 93 0
 392 041c F100D4A0 		IF_NE mov	r0, #241
 393 0420 00007C5C 		lcall	#_SSD1306_cmd
 393      00000000 
  94:SSD1306.c     ****   SSD1306_cmd(SSD1306_SETVCOMDETECT);
 394              		.loc 1 94 0
 395 0428 DB00FCA0 		mov	r0, #219
 396 042c 00007C5C 		lcall	#_SSD1306_cmd
 396      00000000 
  95:SSD1306.c     ****   SSD1306_cmd(0x40);
 397              		.loc 1 95 0
 398 0434 4000FCA0 		mov	r0, #64
 399 0438 00007C5C 		lcall	#_SSD1306_cmd
 399      00000000 
  96:SSD1306.c     ****   SSD1306_cmd(SSD1306_DISPLAYALLON_RESUME);
 400              		.loc 1 96 0
 401 0440 A400FCA0 		mov	r0, #164
 402 0444 00007C5C 		lcall	#_SSD1306_cmd
 402      00000000 
  97:SSD1306.c     ****   SSD1306_cmd(SSD1306_NORMALDISPLAY);
 403              		.loc 1 97 0
 404 044c A600FCA0 		mov	r0, #166
 405 0450 00007C5C 		lcall	#_SSD1306_cmd
 405      00000000 
  98:SSD1306.c     ****   SSD1306_cmd(SSD1306_DEACTIVATE_SCROLL);
 406              		.loc 1 98 0
 407 0458 2E00FCA0 		mov	r0, #46
 408 045c 00007C5C 		lcall	#_SSD1306_cmd
 408      00000000 
  99:SSD1306.c     ****   SSD1306_cmd(SSD1306_DISPLAYON);
 409              		.loc 1 99 0
 410 0464 AF00FCA0 		mov	r0, #175
 411 0468 00007C5C 		lcall	#_SSD1306_cmd
 411      00000000 
 100:SSD1306.c     ****   SSD1306_invert(0);
 412              		.loc 1 100 0
 413 0470 0000FCA0 		mov	r0, #0
 414 0474 00007C5C 		lcall	#_SSD1306_invert
 414      00000000 
 101:SSD1306.c     ****   SSD1306_cls();
 415              		.loc 1 101 0
 416 047c 00007C5C 		lcall	#_SSD1306_cls
 416      00000000 
 102:SSD1306.c     **** }
 417              		.loc 1 102 0
 418 0484 4F00FCA0 		mov	__TMP0,#(4<<4)+15
 419 0488 0000FC5C 		call	#__LMM_POPRET
 420              		'' never returns
 421              	.LFE1
 422              		.balign	4
 423              		.global	_SSD1306_getBuffer
 424              	_SSD1306_getBuffer
 425              	.LFB8
 154:SSD1306.c     **** 
 155:SSD1306.c     **** char* SSD1306_getBuffer()
 156:SSD1306.c     **** {
 426              		.loc 1 156 0
 157:SSD1306.c     ****   return _Buffer;
 158:SSD1306.c     **** }
 427              		.loc 1 158 0
 428 048c 00007C5C 		mvi	r0,#__Buffer
 428      00000000 
 429 0494 0000BCA0 		mov	pc,lr
 430              	.LFE8
 431              		.balign	4
 432              		.global	_SSD1306_scrollRight
 433              	_SSD1306_scrollRight
 434              	.LFB9
 159:SSD1306.c     **** 
 160:SSD1306.c     **** void SSD1306_scrollRight(char sp, char ep, char f)
 161:SSD1306.c     **** {
 435              		.loc 1 161 0
 436              	.LVL19
 437 0498 4C00FCA0 		mov	__TMP0,#(4<<4)+12
 438 049c 0000FC5C 		call	#__LMM_PUSHM
 439              	.LCFI8
 440              		.loc 1 161 0
 441 04a0 0000BCA0 		mov	r12, r0
 162:SSD1306.c     ****   SSD1306_cmd(SSD1306_DEACTIVATE_SCROLL);
 442              		.loc 1 162 0
 443 04a4 2E00FCA0 		mov	r0, #46
 444              	.LVL20
 161:SSD1306.c     **** {
 445              		.loc 1 161 0
 446 04a8 0000BCA0 		mov	r14, r1
 447 04ac 0000BCA0 		mov	r13, r2
 448              		.loc 1 162 0
 449 04b0 00007C5C 		lcall	#_SSD1306_cmd
 449      00000000 
 450              	.LVL21
 163:SSD1306.c     ****   SSD1306_cmd(SSD1306_RIGHT_HORIZ_SCROLL);
 451              		.loc 1 163 0
 452 04b8 2600FCA0 		mov	r0, #38
 453 04bc 00007C5C 		lcall	#_SSD1306_cmd
 453      00000000 
 164:SSD1306.c     ****   SSD1306_cmd(0x00); // Dummy
 454              		.loc 1 164 0
 455 04c4 0000FCA0 		mov	r0, #0
 456 04c8 00007C5C 		lcall	#_SSD1306_cmd
 456      00000000 
 165:SSD1306.c     ****   SSD1306_cmd(sp & 0x07);
 457              		.loc 1 165 0
 458 04d0 0000BCA0 		mov	r0, r12
 459 04d4 0700FC60 		and	r0, #7
 460 04d8 00007C5C 		lcall	#_SSD1306_cmd
 460      00000000 
 166:SSD1306.c     ****   SSD1306_cmd(f & 0x07);
 461              		.loc 1 166 0
 462 04e0 0000BCA0 		mov	r0, r13
 463 04e4 0700FC60 		and	r0, #7
 464 04e8 00007C5C 		lcall	#_SSD1306_cmd
 464      00000000 
 167:SSD1306.c     ****   SSD1306_cmd(ep & 0x07);
 465              		.loc 1 167 0
 466 04f0 0000BCA0 		mov	r0, r14
 467 04f4 0700FC60 		and	r0, #7
 468 04f8 00007C5C 		lcall	#_SSD1306_cmd
 468      00000000 
 168:SSD1306.c     ****   SSD1306_cmd(0x00);
 469              		.loc 1 168 0
 470 0500 0000FCA0 		mov	r0, #0
 471 0504 00007C5C 		lcall	#_SSD1306_cmd
 471      00000000 
 169:SSD1306.c     ****   SSD1306_cmd(0xFF);
 472              		.loc 1 169 0
 473 050c FF00FCA0 		mov	r0, #255
 474 0510 00007C5C 		lcall	#_SSD1306_cmd
 474      00000000 
 170:SSD1306.c     ****   SSD1306_cmd(SSD1306_ACTIVATE_SCROLL);
 475              		.loc 1 170 0
 476 0518 2F00FCA0 		mov	r0, #47
 477 051c 00007C5C 		lcall	#_SSD1306_cmd
 477      00000000 
 171:SSD1306.c     **** }
 478              		.loc 1 171 0
 479 0524 4F00FCA0 		mov	__TMP0,#(4<<4)+15
 480 0528 0000FC5C 		call	#__LMM_POPRET
 481              		'' never returns
 482              	.LFE9
 483              		.balign	4
 484              		.global	_SSD1306_scrollLeft
 485              	_SSD1306_scrollLeft
 486              	.LFB10
 172:SSD1306.c     **** 
 173:SSD1306.c     **** void SSD1306_scrollLeft(char sp, char ep, char f)
 174:SSD1306.c     **** {
 487              		.loc 1 174 0
 488              	.LVL22
 489 052c 4C00FCA0 		mov	__TMP0,#(4<<4)+12
 490 0530 0000FC5C 		call	#__LMM_PUSHM
 491              	.LCFI9
 492              		.loc 1 174 0
 493 0534 0000BCA0 		mov	r12, r0
 175:SSD1306.c     ****   SSD1306_cmd(SSD1306_DEACTIVATE_SCROLL);
 494              		.loc 1 175 0
 495 0538 2E00FCA0 		mov	r0, #46
 496              	.LVL23
 174:SSD1306.c     **** {
 497              		.loc 1 174 0
 498 053c 0000BCA0 		mov	r14, r1
 499 0540 0000BCA0 		mov	r13, r2
 500              		.loc 1 175 0
 501 0544 00007C5C 		lcall	#_SSD1306_cmd
 501      00000000 
 502              	.LVL24
 176:SSD1306.c     ****   SSD1306_cmd(SSD1306_LEFT_HORIZ_SCROLL);
 503              		.loc 1 176 0
 504 054c 2700FCA0 		mov	r0, #39
 505 0550 00007C5C 		lcall	#_SSD1306_cmd
 505      00000000 
 177:SSD1306.c     ****   SSD1306_cmd(0x00); // Dummy
 506              		.loc 1 177 0
 507 0558 0000FCA0 		mov	r0, #0
 508 055c 00007C5C 		lcall	#_SSD1306_cmd
 508      00000000 
 178:SSD1306.c     ****   SSD1306_cmd(sp & 0x07);
 509              		.loc 1 178 0
 510 0564 0000BCA0 		mov	r0, r12
 511 0568 0700FC60 		and	r0, #7
 512 056c 00007C5C 		lcall	#_SSD1306_cmd
 512      00000000 
 179:SSD1306.c     ****   SSD1306_cmd(f & 0x07);
 513              		.loc 1 179 0
 514 0574 0000BCA0 		mov	r0, r13
 515 0578 0700FC60 		and	r0, #7
 516 057c 00007C5C 		lcall	#_SSD1306_cmd
 516      00000000 
 180:SSD1306.c     ****   SSD1306_cmd(ep & 0x07);
 517              		.loc 1 180 0
 518 0584 0000BCA0 		mov	r0, r14
 519 0588 0700FC60 		and	r0, #7
 520 058c 00007C5C 		lcall	#_SSD1306_cmd
 520      00000000 
 181:SSD1306.c     ****   SSD1306_cmd(0x00);
 521              		.loc 1 181 0
 522 0594 0000FCA0 		mov	r0, #0
 523 0598 00007C5C 		lcall	#_SSD1306_cmd
 523      00000000 
 182:SSD1306.c     ****   SSD1306_cmd(0xFF);
 524              		.loc 1 182 0
 525 05a0 FF00FCA0 		mov	r0, #255
 526 05a4 00007C5C 		lcall	#_SSD1306_cmd
 526      00000000 
 183:SSD1306.c     ****   SSD1306_cmd(SSD1306_ACTIVATE_SCROLL);
 527              		.loc 1 183 0
 528 05ac 2F00FCA0 		mov	r0, #47
 529 05b0 00007C5C 		lcall	#_SSD1306_cmd
 529      00000000 
 184:SSD1306.c     **** }
 530              		.loc 1 184 0
 531 05b8 4F00FCA0 		mov	__TMP0,#(4<<4)+15
 532 05bc 0000FC5C 		call	#__LMM_POPRET
 533              		'' never returns
 534              	.LFE10
 535              		.balign	4
 536              		.global	_SSD1306_scrollDiagRight
 537              	_SSD1306_scrollDiagRight
 538              	.LFB11
 185:SSD1306.c     **** 
 186:SSD1306.c     **** void SSD1306_scrollDiagRight(char sp, char ep, char f)
 187:SSD1306.c     **** {
 539              		.loc 1 187 0
 540              	.LVL25
 541 05c0 4C00FCA0 		mov	__TMP0,#(4<<4)+12
 542 05c4 0000FC5C 		call	#__LMM_PUSHM
 543              	.LCFI10
 544              		.loc 1 187 0
 545 05c8 0000BCA0 		mov	r12, r0
 188:SSD1306.c     ****   SSD1306_cmd(SSD1306_DEACTIVATE_SCROLL);
 546              		.loc 1 188 0
 547 05cc 2E00FCA0 		mov	r0, #46
 548              	.LVL26
 187:SSD1306.c     **** {
 549              		.loc 1 187 0
 550 05d0 0000BCA0 		mov	r14, r1
 551 05d4 0000BCA0 		mov	r13, r2
 552              		.loc 1 188 0
 553 05d8 00007C5C 		lcall	#_SSD1306_cmd
 553      00000000 
 554              	.LVL27
 189:SSD1306.c     ****   SSD1306_cmd(SSD1306_VERTRIGHTHORIZSCROLL);
 555              		.loc 1 189 0
 556 05e0 2900FCA0 		mov	r0, #41
 557 05e4 00007C5C 		lcall	#_SSD1306_cmd
 557      00000000 
 190:SSD1306.c     ****   SSD1306_cmd(0x00); // Dummy
 558              		.loc 1 190 0
 559 05ec 0000FCA0 		mov	r0, #0
 560 05f0 00007C5C 		lcall	#_SSD1306_cmd
 560      00000000 
 191:SSD1306.c     ****   SSD1306_cmd(sp & 0x07);
 561              		.loc 1 191 0
 562 05f8 0000BCA0 		mov	r7, r12
 563 05fc 0700FC60 		and	r7, #7
 564 0600 0000BCA0 		mov	r0, r7
 565 0604 00007C5C 		lcall	#_SSD1306_cmd
 565      00000000 
 192:SSD1306.c     ****   SSD1306_cmd(f & 0x07);
 566              		.loc 1 192 0
 567 060c 0000BCA0 		mov	r2, r13
 568 0610 0700FC60 		and	r2, #7
 569 0614 0000BCA0 		mov	r0, r2
 570 0618 00007C5C 		lcall	#_SSD1306_cmd
 570      00000000 
 193:SSD1306.c     ****   SSD1306_cmd(ep);
 571              		.loc 1 193 0
 572 0620 0000BCA0 		mov	r0, r14
 573 0624 00007C5C 		lcall	#_SSD1306_cmd
 573      00000000 
 194:SSD1306.c     ****   SSD1306_cmd(0x01);
 574              		.loc 1 194 0
 575 062c 0100FCA0 		mov	r0, #1
 576 0630 00007C5C 		lcall	#_SSD1306_cmd
 576      00000000 
 195:SSD1306.c     ****   SSD1306_cmd(SSD1306_ACTIVATE_SCROLL);
 577              		.loc 1 195 0
 578 0638 2F00FCA0 		mov	r0, #47
 579 063c 00007C5C 		lcall	#_SSD1306_cmd
 579      00000000 
 196:SSD1306.c     **** }
 580              		.loc 1 196 0
 581 0644 4F00FCA0 		mov	__TMP0,#(4<<4)+15
 582 0648 0000FC5C 		call	#__LMM_POPRET
 583              		'' never returns
 584              	.LFE11
 585              		.balign	4
 586              		.global	_SSD1306_scrollDiagLeft
 587              	_SSD1306_scrollDiagLeft
 588              	.LFB12
 197:SSD1306.c     **** 
 198:SSD1306.c     **** void SSD1306_scrollDiagLeft(char sp, char ep, char f)
 199:SSD1306.c     **** {
 589              		.loc 1 199 0
 590              	.LVL28
 591 064c 4C00FCA0 		mov	__TMP0,#(4<<4)+12
 592 0650 0000FC5C 		call	#__LMM_PUSHM
 593              	.LCFI11
 594              		.loc 1 199 0
 595 0654 0000BCA0 		mov	r12, r0
 200:SSD1306.c     ****   SSD1306_cmd(SSD1306_DEACTIVATE_SCROLL);
 596              		.loc 1 200 0
 597 0658 2E00FCA0 		mov	r0, #46
 598              	.LVL29
 199:SSD1306.c     **** {
 599              		.loc 1 199 0
 600 065c 0000BCA0 		mov	r14, r1
 601 0660 0000BCA0 		mov	r13, r2
 602              		.loc 1 200 0
 603 0664 00007C5C 		lcall	#_SSD1306_cmd
 603      00000000 
 604              	.LVL30
 201:SSD1306.c     ****   SSD1306_cmd(SSD1306_VERTLEFTHORIZSCROLL);
 605              		.loc 1 201 0
 606 066c 2A00FCA0 		mov	r0, #42
 607 0670 00007C5C 		lcall	#_SSD1306_cmd
 607      00000000 
 202:SSD1306.c     ****   SSD1306_cmd(0x00); // Dummy
 608              		.loc 1 202 0
 609 0678 0000FCA0 		mov	r0, #0
 610 067c 00007C5C 		lcall	#_SSD1306_cmd
 610      00000000 
 203:SSD1306.c     ****   SSD1306_cmd(sp & 0x07);
 611              		.loc 1 203 0
 612 0684 0000BCA0 		mov	r0, r12
 613 0688 0700FC60 		and	r0, #7
 614 068c 00007C5C 		lcall	#_SSD1306_cmd
 614      00000000 
 204:SSD1306.c     ****   SSD1306_cmd(f & 0x07);
 615              		.loc 1 204 0
 616 0694 0000BCA0 		mov	r0, r13
 617 0698 0700FC60 		and	r0, #7
 618 069c 00007C5C 		lcall	#_SSD1306_cmd
 618      00000000 
 205:SSD1306.c     ****   SSD1306_cmd(ep & 0x07);
 619              		.loc 1 205 0
 620 06a4 0000BCA0 		mov	r0, r14
 621 06a8 0700FC60 		and	r0, #7
 622 06ac 00007C5C 		lcall	#_SSD1306_cmd
 622      00000000 
 206:SSD1306.c     ****   SSD1306_cmd(0x01);
 623              		.loc 1 206 0
 624 06b4 0100FCA0 		mov	r0, #1
 625 06b8 00007C5C 		lcall	#_SSD1306_cmd
 625      00000000 
 207:SSD1306.c     ****   SSD1306_cmd(SSD1306_ACTIVATE_SCROLL);
 626              		.loc 1 207 0
 627 06c0 2F00FCA0 		mov	r0, #47
 628 06c4 00007C5C 		lcall	#_SSD1306_cmd
 628      00000000 
 208:SSD1306.c     **** }
 629              		.loc 1 208 0
 630 06cc 4F00FCA0 		mov	__TMP0,#(4<<4)+15
 631 06d0 0000FC5C 		call	#__LMM_POPRET
 632              		'' never returns
 633              	.LFE12
 634              		.balign	4
 635              		.global	_SSD1306_scrollStop
 636              	_SSD1306_scrollStop
 637              	.LFB13
 209:SSD1306.c     **** 
 210:SSD1306.c     **** void SSD1306_scrollStop()
 211:SSD1306.c     **** {
 638              		.loc 1 211 0
 639 06d4 0400FC84 		sub	sp, #4
 640              	.LCFI12
 641 06d8 00003C08 		wrlong	lr, sp
 642              	.LCFI13
 212:SSD1306.c     ****   SSD1306_cmd(SSD1306_DEACTIVATE_SCROLL);
 643              		.loc 1 212 0
 644 06dc 2E00FCA0 		mov	r0, #46
 645 06e0 00007C5C 		lcall	#_SSD1306_cmd
 645      00000000 
 213:SSD1306.c     **** }
 646              		.loc 1 213 0
 647 06e8 0000BC08 		rdlong	lr, sp
 648 06ec 0400FC80 		add	sp, #4
 649 06f0 0000BCA0 		mov	pc,lr
 650              	.LFE13
 651              		.balign	4
 652              		.global	_SSD1306_setPoint
 653              	_SSD1306_setPoint
 654              	.LFB14
 214:SSD1306.c     **** 
 215:SSD1306.c     **** void SSD1306_setPoint(char x, char y)
 216:SSD1306.c     **** {
 655              		.loc 1 216 0
 656              	.LVL31
 217:SSD1306.c     ****   int i;
 218:SSD1306.c     ****   char r, p;
 219:SSD1306.c     ****   
 220:SSD1306.c     ****   i = y / 8 * 128;
 221:SSD1306.c     ****   r = y % 8;
 222:SSD1306.c     ****   r = 1 << r;
 657              		.loc 1 222 0
 658 06f4 0000BCA0 		mov	r6, r1
 659 06f8 0700FC60 		and	r6, #7
 660 06fc 0100FCA0 		mov	r7, #1
 220:SSD1306.c     ****   i = y / 8 * 128;
 661              		.loc 1 220 0
 662 0700 0300FC28 		shr	r1, #3
 663              	.LVL32
 664              		.loc 1 222 0
 665 0704 0000BC2C 		shl	r7, r6
 220:SSD1306.c     ****   i = y / 8 * 128;
 666              		.loc 1 220 0
 667 0708 0700FC2C 		shl	r1, #7
 668              		.loc 1 222 0
 669 070c 0000BCA0 		mov	r5, r7
 223:SSD1306.c     ****   p = _Buffer[i+x] & ~r;
 670              		.loc 1 223 0
 671 0710 0000BC80 		add	r1, r0
 224:SSD1306.c     ****   _Buffer[i+x] = p | r;
 672              		.loc 1 224 0
 673 0714 00007C5C 		mvi	r7,#__Buffer
 673      00000000 
 674 071c 0000BC80 		add	r7, r1
 222:SSD1306.c     ****   r = 1 << r;
 675              		.loc 1 222 0
 676 0720 FF00FC60 		and	r5,#255
 677              	.LVL33
 223:SSD1306.c     ****   p = _Buffer[i+x] & ~r;
 678              		.loc 1 223 0
 679 0724 0000BC00 		rdbyte	r6, r7
 680 0728 0000BC64 		andn	r6, r5
 681              		.loc 1 224 0
 682 072c 0000BC68 		or	r6, r5
 683 0730 00003C00 		wrbyte	r6, r7
 225:SSD1306.c     **** }
 684              		.loc 1 225 0
 685 0734 0000BCA0 		mov	pc,lr
 686              	.LFE14
 687              		.balign	4
 688              		.global	_SSD1306_clearPoint
 689              	_SSD1306_clearPoint
 690              	.LFB15
 226:SSD1306.c     **** 
 227:SSD1306.c     **** void SSD1306_clearPoint(char x, char y)
 228:SSD1306.c     **** {
 691              		.loc 1 228 0
 692              	.LVL34
 229:SSD1306.c     ****   int i;
 230:SSD1306.c     ****   char r, p;
 231:SSD1306.c     ****   
 232:SSD1306.c     ****   i = y / 8 * 128;
 233:SSD1306.c     ****   r = y % 8;
 234:SSD1306.c     ****   r = 1 << r;
 693              		.loc 1 234 0
 694 0738 0000BCA0 		mov	r6, r1
 695 073c 0700FC60 		and	r6, #7
 696 0740 0100FCA0 		mov	r7, #1
 232:SSD1306.c     ****   i = y / 8 * 128;
 697              		.loc 1 232 0
 698 0744 0300FC28 		shr	r1, #3
 699              	.LVL35
 700              		.loc 1 234 0
 701 0748 0000BC2C 		shl	r7, r6
 232:SSD1306.c     ****   i = y / 8 * 128;
 702              		.loc 1 232 0
 703 074c 0700FC2C 		shl	r1, #7
 704              		.loc 1 234 0
 705 0750 0000BCA0 		mov	r5, r7
 235:SSD1306.c     ****   p = _Buffer[i+x] & ~r;
 706              		.loc 1 235 0
 707 0754 0000BC80 		add	r1, r0
 236:SSD1306.c     ****   _Buffer[i+x] = p | r;
 708              		.loc 1 236 0
 709 0758 00007C5C 		mvi	r7,#__Buffer
 709      00000000 
 710 0760 0000BC80 		add	r7, r1
 234:SSD1306.c     ****   r = 1 << r;
 711              		.loc 1 234 0
 712 0764 FF00FC60 		and	r5,#255
 713              	.LVL36
 235:SSD1306.c     ****   p = _Buffer[i+x] & ~r;
 714              		.loc 1 235 0
 715 0768 0000BC00 		rdbyte	r6, r7
 716 076c 0000BC64 		andn	r6, r5
 717              		.loc 1 236 0
 718 0770 0000BC68 		or	r6, r5
 719 0774 00003C00 		wrbyte	r6, r7
 237:SSD1306.c     **** }
 720              		.loc 1 237 0
 721 0778 0000BCA0 		mov	pc,lr
 722              	.LFE15
 723              		.data
 724              		.balign	4
 725              	.LC0
 726 0000 2578200A 		.ascii "%x \12\0"
 726      00
 727 0005 000000   		.text
 728              		.balign	4
 729              		.global	_SSD1306_writeChar
 730              	_SSD1306_writeChar
 731              	.LFB16
 238:SSD1306.c     ****   
 239:SSD1306.c     **** void SSD1306_writeChar(char x, char y, char ch)
 240:SSD1306.c     **** {
 732              		.loc 1 240 0
 733              	.LVL37
 734 077c 8800FCA0 		mov	__TMP0,#(8<<4)+8
 735 0780 0000FC5C 		call	#__LMM_PUSHM
 736              	.LCFI14
 737 0784 1000FC84 		sub	sp, #16
 738              	.LCFI15
 739              	.LVL38
 241:SSD1306.c     ****   unsigned long *base;
 242:SSD1306.c     ****   int offset;
 243:SSD1306.c     ****   long v;
 244:SSD1306.c     ****   
 245:SSD1306.c     ****   offset = ch & 0xfe; // Two characters per location
 740              		.loc 1 245 0
 741 0788 0000BCA0 		mov	r7, r2
 742 078c FE00FC60 		and	r7, #254
 246:SSD1306.c     ****   *base = 0x8000 + (offset << 6); // jump to character position
 743              		.loc 1 246 0
 744 0790 00007C5C 		mvi	r6,#32768
 744      00800000 
 745 0798 0600FC2C 		shl	r7, #6
 746 079c 0000BC80 		add	r7, r6
 747 07a0 0000FCA0 		mov	r11, #0
 247:SSD1306.c     **** 
 248:SSD1306.c     ****   print("%x \n", *base);
 748              		.loc 1 248 0
 749 07a4 00007C5C 		mvi	r6,#.LC0
 749      00000000 
 750 07ac 0000BCA0 		mov	r12, sp
 751 07b0 0400FC80 		add	r12, #4
 240:SSD1306.c     **** {
 752              		.loc 1 240 0
 753 07b4 0000BCA0 		mov	r14, r2
 754 07b8 0000BCA0 		mov	r9, r0
 755 07bc 0000BCA0 		mov	r10, r1
 756              	.LBB8
 249:SSD1306.c     ****   offset = 0;
 250:SSD1306.c     ****   for (int i=0;i<32;i++)
 251:SSD1306.c     ****   {
 252:SSD1306.c     ****     v = base[offset++];
 253:SSD1306.c     ****     print("%x \n", v);
 254:SSD1306.c     ****     if (ch & 0x01)
 757              		.loc 1 254 0
 758 07c0 0000BCA0 		mov	r8, r14
 759              	.LBE8
 250:SSD1306.c     ****   for (int i=0;i<32;i++)
 760              		.loc 1 250 0
 761 07c4 0000FCA0 		mov	r13, #0
 762              	.LBB12
 763              		.loc 1 254 0
 764 07c8 0100FC60 		and	r8, #1
 765              	.LBE12
 246:SSD1306.c     ****   *base = 0x8000 + (offset << 6); // jump to character position
 766              		.loc 1 246 0
 767 07cc 00003C08 		wrlong	r7, r11
 248:SSD1306.c     ****   print("%x \n", *base);
 768              		.loc 1 248 0
 769 07d0 00003C08 		wrlong	r6, sp
 770 07d4 00003C08 		wrlong	r7, r12
 771 07d8 00007C5C 		lcall	#_print
 771      00000000 
 772              	.LVL39
 773              	.LBB13
 253:SSD1306.c     ****     print("%x \n", v);
 774              		.loc 1 253 0
 775 07e0 0800FCA0 		mov	r7, #8
 776 07e4 0000BC80 		add	r7, sp
 777 07e8 00003C08 		wrlong	r12, r7
 778              	.LVL40
 779              	.L40
 780 07ec 00007C5C 		mvi	r6,#.LC0
 780      00000000 
 781 07f4 0800FCA0 		mov	r7, #8
 782 07f8 0000BC80 		add	r7, sp
 783              	.LBE13
 250:SSD1306.c     ****   for (int i=0;i<32;i++)
 784              		.loc 1 250 0
 785 07fc 0000FCA0 		mov	r12, #0
 786              	.LBB14
 252:SSD1306.c     ****     v = base[offset++];
 787              		.loc 1 252 0
 788 0800 0000BC08 		rdlong	r14, r11
 789              	.LVL41
 253:SSD1306.c     ****     print("%x \n", v);
 790              		.loc 1 253 0
 791 0804 00003C08 		wrlong	r6, sp
 792 0808 0000BC08 		rdlong	r7, r7
 793 080c 00003C08 		wrlong	r14, r7
 794 0810 00007C5C 		lcall	#_print
 794      00000000 
 795              	.LVL42
 796              	.LBB9
 239:SSD1306.c     **** void SSD1306_writeChar(char x, char y, char ch)
 797              		.loc 1 239 0
 798 0818 0000BCA0 		mov	r6, r10
 799              	.LBE9
 800              		.loc 1 254 0
 801 081c 00007CC3 		cmps	r8, #0 wz,wc
 802              	.LBB10
 239:SSD1306.c     **** void SSD1306_writeChar(char x, char y, char ch)
 803              		.loc 1 239 0
 804 0820 0000BC80 		add	r6, r13
 805              	.LBE10
 255:SSD1306.c     ****       v = v >>1;
 806              		.loc 1 255 0
 807 0824 0100D438 		IF_NE sar	r14, #1
 808              	.LVL43
 809              	.LBB11
 256:SSD1306.c     ****   
 257:SSD1306.c     ****     for (int j=0;j<16;j++)
 258:SSD1306.c     ****     {
 259:SSD1306.c     ****       if (v & 0x01)
 260:SSD1306.c     ****         SSD1306_setPoint(x+j, y+i);
 810              		.loc 1 260 0
 811 0828 FF00FC60 		and	r6,#255
 812              	.LVL44
 813              	.L39
 259:SSD1306.c     ****       if (v & 0x01)
 814              		.loc 1 259 0
 815 082c 01007C62 		test	r14,#0x1 wz
 816 0830 3400E880 		IF_E 	brs	#.L38
 239:SSD1306.c     **** void SSD1306_writeChar(char x, char y, char ch)
 817              		.loc 1 239 0
 818 0834 0000BCA0 		mov	r7, r9
 819 0838 0000BC80 		add	r7, r12
 820              		.loc 1 260 0
 821 083c FF00FC60 		and	r7,#255
 822 0840 0000BCA0 		mov	r0, r7
 823 0844 0C00FCA0 		mov	r7, #12
 824 0848 0000BC80 		add	r7, sp
 825 084c 0000BCA0 		mov	r1, r6
 826 0850 00003C08 		wrlong	r6, r7
 827 0854 00007C5C 		lcall	#_SSD1306_setPoint
 827      00000000 
 828 085c 0C00FCA0 		mov	r7, #12
 829 0860 0000BC80 		add	r7, sp
 830 0864 0000BC08 		rdlong	r6, r7
 831              	.L38
 257:SSD1306.c     ****     for (int j=0;j<16;j++)
 832              		.loc 1 257 0
 833 0868 0100FC80 		add	r12, #1
 834 086c 10007CC3 		cmps	r12, #16 wz,wc
 261:SSD1306.c     ****       v = v >> 2;
 835              		.loc 1 261 0
 836 0870 0200FC38 		sar	r14, #2
 837              	.LVL45
 257:SSD1306.c     ****     for (int j=0;j<16;j++)
 838              		.loc 1 257 0
 839 0874 4C00D484 		IF_NE	brs	#.L39
 840              	.LBE11
 250:SSD1306.c     ****   for (int i=0;i<32;i++)
 841              		.loc 1 250 0
 842 0878 0100FC80 		add	r13, #1
 843              	.LVL46
 844 087c 20007CC3 		cmps	r13, #32 wz,wc
 845 0880 0400FC80 		add	r11, #4
 846 0884 9C00D484 		IF_NE	brs	#.L40
 847              	.LBE14
 262:SSD1306.c     ****     }
 263:SSD1306.c     ****   }    
 264:SSD1306.c     **** }
 848              		.loc 1 264 0
 849 0888 1000FC80 		add	sp, #16
 850 088c 8F00FCA0 		mov	__TMP0,#(8<<4)+15
 851 0890 0000FC5C 		call	#__LMM_POPRET
 852              		'' never returns
 853              	.LFE16
 854              		.comm	__Buffer,1024,4
 855              		.comm	__Height,4,4
 856              		.comm	__Width,4,4
 857              		.comm	__Auto,4,4
 858              		.comm	__RST,4,4
 859              		.comm	__SCL,4,4
 860              		.comm	__SDA,4,4
 861              		.comm	__DC,4,4
 862              		.comm	__CS,4,4
 1156              	.Letext0
 1157              		.file 2 "D:/Documents/SimpleIDE/Learn/Simple Libraries/TextDevices/libsimpletext/simpletext.h"
DEFINED SYMBOLS
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:5      .text:00000000 _SSD1306_write
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:10     .text:00000000 L0
                            *COM*:00000004 __CS
                            *COM*:00000004 __SDA
                            *COM*:00000004 __SCL
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:41     .text:00000064 _SSD1306_cmd
                            *COM*:00000004 __DC
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:69     .text:000000a4 _SSD1306_invert
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:92     .text:000000cc _SSD1306_auto
                            *COM*:00000004 __Auto
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:104    .text:000000dc _SSD1306_update
                            *COM*:00000004 __Width
                            *COM*:00000004 __Height
                            *COM*:00000400 __Buffer
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:207    .text:000001cc _SSD1306_cls
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:228    .text:00000204 _SSD1306_init
                            *COM*:00000004 __RST
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:424    .text:0000048c _SSD1306_getBuffer
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:433    .text:00000498 _SSD1306_scrollRight
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:485    .text:0000052c _SSD1306_scrollLeft
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:537    .text:000005c0 _SSD1306_scrollDiagRight
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:587    .text:0000064c _SSD1306_scrollDiagLeft
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:636    .text:000006d4 _SSD1306_scrollStop
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:653    .text:000006f4 _SSD1306_setPoint
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:689    .text:00000738 _SSD1306_clearPoint
C:\Users\mbmis006\AppData\Local\Temp\cckJNgaY.s:730    .text:0000077c _SSD1306_writeChar
                            .data:00000000 .LC0
                     .debug_frame:00000000 .Lframe0
                            .text:00000000 .LFB2
                            .text:00000064 .LFB3
                            .text:000000a4 .LFB4
                            .text:000000cc .LFB5
                            .text:000000dc .LFB6
                            .text:000001cc .LFB7
                            .text:00000204 .LFB1
                            .text:0000048c .LFB8
                            .text:00000498 .LFB9
                            .text:0000052c .LFB10
                            .text:000005c0 .LFB11
                            .text:0000064c .LFB12
                            .text:000006d4 .LFB13
                            .text:000006f4 .LFB14
                            .text:00000738 .LFB15
                            .text:0000077c .LFB16
                    .debug_abbrev:00000000 .Ldebug_abbrev0
                            .text:00000000 .Ltext0
                            .text:00000894 .Letext0
                      .debug_line:00000000 .Ldebug_line0
                            .text:00000064 .LFE2
                       .debug_loc:00000000 .LLST0
                       .debug_loc:00000020 .LLST1
                            .text:000000a4 .LFE3
                       .debug_loc:00000033 .LLST2
                       .debug_loc:00000053 .LLST3
                            .text:000000cc .LFE4
                       .debug_loc:00000066 .LLST4
                       .debug_loc:00000086 .LLST5
                            .text:000000dc .LFE5
                            .text:000001cc .LFE6
                       .debug_loc:00000099 .LLST6
                       .debug_loc:000000b9 .LLST7
                    .debug_ranges:00000000 .Ldebug_ranges0
                       .debug_loc:000000f9 .LLST8
                       .debug_loc:00000118 .LLST9
                            .text:00000204 .LFE7
                       .debug_loc:00000136 .LLST10
                            .text:0000048c .LFE1
                       .debug_loc:00000156 .LLST11
                       .debug_loc:00000176 .LLST12
                       .debug_loc:00000198 .LLST13
                       .debug_loc:000001ab .LLST14
                       .debug_loc:000001be .LLST15
                       .debug_loc:000001d1 .LLST16
                       .debug_loc:000001e4 .LLST17
                            .text:00000498 .LFE8
                            .text:0000052c .LFE9
                       .debug_loc:00000202 .LLST18
                       .debug_loc:00000222 .LLST19
                       .debug_loc:00000235 .LLST20
                       .debug_loc:00000248 .LLST21
                            .text:000005c0 .LFE10
                       .debug_loc:0000025b .LLST22
                       .debug_loc:0000027b .LLST23
                       .debug_loc:0000028e .LLST24
                       .debug_loc:000002a1 .LLST25
                            .text:0000064c .LFE11
                       .debug_loc:000002b4 .LLST26
                       .debug_loc:000002d4 .LLST27
                       .debug_loc:000002e7 .LLST28
                       .debug_loc:000002fa .LLST29
                            .text:000006d4 .LFE12
                       .debug_loc:0000030d .LLST30
                       .debug_loc:0000032d .LLST31
                       .debug_loc:00000340 .LLST32
                       .debug_loc:00000353 .LLST33
                            .text:000006f4 .LFE13
                       .debug_loc:00000366 .LLST34
                            .text:00000738 .LFE14
                       .debug_loc:00000386 .LLST35
                       .debug_loc:00000399 .LLST36
                       .debug_loc:000003b6 .LLST37
                            .text:0000077c .LFE15
                       .debug_loc:000003d8 .LLST38
                       .debug_loc:000003eb .LLST39
                       .debug_loc:00000408 .LLST40
                            .text:00000894 .LFE16
                       .debug_loc:0000042a .LLST41
                       .debug_loc:00000456 .LLST42
                       .debug_loc:00000469 .LLST43
                       .debug_loc:0000047c .LLST44
                       .debug_loc:0000048f .LLST45
                       .debug_loc:000004c3 .LLST46
                       .debug_loc:000004e2 .LLST47
                       .debug_loc:00000501 .LLST48
                      .debug_info:00000000 .Ldebug_info0

UNDEFINED SYMBOLS
__TMP0
__LMM_PUSHM
__LMM_PUSHM_ret
__LMM_MVI_r14
r13
r0
r14
__LMM_CALL
_low
__LMM_MVI_r7
__LMM_MVI_r6
r2
r3
r4
r7
r1
r6
_shift_out
_high
__LMM_POPRET
__LMM_POPRET_ret
sp
lr
pc
r12
__LMM_MVI_r10
__LMM_MVI_r11
r9
r11
__DIVSI
__DIVSI_ret
r10
__LMM_MVI_r9
__LMM_MVI_r2
__LMM_MVI_r0
_memset
r5
__LMM_MVI_r12
_pause
r8
_print
