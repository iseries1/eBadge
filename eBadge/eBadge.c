/**
 * @brief Default Test Program for eBadge
 * @author Michael Burmeister
 * @date March 13, 2018
 * @version 1.0
 * 
*/

/*
 *  Terms of Use: MIT License

  Permission is hereby granted, free of charge, to any person obtaining a copy of this
  software and associated documentation files (the "Software"), to deal in the Software
  without restriction, including without limitation the rights to use, copy, modify,
  merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to the following
  conditions:

  The above copyright notice and this permission notice shall be included in all copies
  or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
  PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#include "simpletools.h"
#include "Leds.h"
#include "Pads.h"
#include "SSD1306.h"
#include "MMA7660.h"
#include "Battery.h"
#include "eBadge.h"


void Setup(void);
void Buttons(void);
void LEDS(void);
void Accel(void);
void EEProm(void);
void Ir();

#define IR_FREQ 36000

#define SCL 28
#define SDA 29
#define BLU_CP2 8
#define BLU_CP1 7
#define BLU_CP0 6
#define RGB_CP2 3
#define RGB_CP1 2
#define RGB_CP0 1
#define BAT_MON 0
#define BTN_0 27
#define BTN_1 26
#define BTN_2 25
#define BTN_3 15
#define BTN_4 16
#define BTN_5 17
#define BTN_OS 5
#define OLED_DAT 22
#define OLED_CLK 21
#define OLED_DC 20
#define OLED_RST 19
#define OLED_CS 18
#define IR_OUT 24
#define IR_IN 23


char Btns[] = {BTN_OS, BTN_5, BTN_4, BTN_3, BTN_2, BTN_1, BTN_0, -1};

char Msg[][17] = {"PARALLAX eBADGE ",
                  "LEDS            ",
                  "BUTTONS %0000000",
                  "ACCEL   - ?     ",
                  "EEPROM  - ??K   ",
                  "IR      - ?     "};
char Buf[25];


int main()
{
  int r;
  char *b;
  
  // start things up
  Setup();
  pause(500);
  
  // put up open source logo
  b = SSD1306_getBuffer();
  memcpy(b, OS_Logo, sizeof(OS_Logo));
  SSD1306_update();
  pause(3000);

  // put up beanie logo
  b = SSD1306_getBuffer();
  memcpy(b, Beanie, sizeof(Beanie));
  SSD1306_update();
  pause(3000);

  // put up badge message
  print("Parallax eBadge Test\n");
  SSD1306_cls();
  SSD1306_writeStr(0, 0, Msg[0]);
  SSD1306_update();
  pause(5000);
  
  // check touch switches

  Buttons();

  // check LED's
  
  LEDS();
  
  // check accelerometer
  
  Accel();
  
  // check eeprom
  
  EEProm();
  
  // check IR
  
  Ir();
  
  SSD1306_cls();
  while (1)
  {
    r = getBattery(BAT_MON);
    sprint(Buf, "Bat:%d", r);
    SSD1306_writeStr(0,16, Buf);
    SSD1306_update();
    pause(500);
  }
}

void Setup()
{
  // Start LED driver
  Leds(BLU_CP2, BLU_CP1, BLU_CP0, RGB_CP2, RGB_CP1, RGB_CP0);
  Pads(Btns);
  SSD1306_init(OLED_CS, OLED_DC, OLED_DAT, OLED_CLK, OLED_RST, SSD1306_SWITCHCAPVCC, TYPE_128X64);
  MMA7660_open(SCL, SDA);
}

void Buttons()
{
  int p, i;
  char *x = &Msg[2][9];
  int b = 0;
  
  print("2) Verifying Buttons\n");
  SSD1306_cls();
  SSD1306_writeStr(0, 0, Msg[2]);
  SSD1306_update();
  
  while (b < 127)
  {
    p = getPads();
    b = b | p;
    i = 0;
    while (i < 7)
    {
      if ((b & (1 << i)) != 0)
        x[i] = '1';
        i++;
    }
    SSD1306_writeStr(0, 0, Msg[2]);
    SSD1306_update();
  }    
}

void LEDS()
{
  
  print("1) Verifying LEDs\n");
  SSD1306_cls();
  SSD1306_writeStr(0, 0, Msg[1]);
  SSD1306_update();

  while (getPads() != 0);
  
  while (getPads() == 0)
  {
    BlueOn(RT);
    BlueOn(LT);
    RGBLeft(RED);
    RGBRight(RED);
    pause(300);
    BlueOff(RT);
    BlueOff(LT);
    BlueOn(RM);
    BlueOn(LM);
    RGBLeft(GREEN);
    RGBRight(GREEN);
    pause(300);
    BlueOff(RM);
    BlueOff(LM);
    BlueOn(RB);
    BlueOn(LB);
    RGBLeft(BLUE);
    RGBRight(BLUE);
    pause(300);
    BlueOff(RB);
    BlueOff(LB);
    RGBLeft(BLACK);
    RGBRight(BLACK);
    pause(300);
  }    
}

void Accel()
{
  short x, y, z;
  
  print("3) Verifying Accelerometer\n");
  SSD1306_cls();
  SSD1306_writeStr(0, 0, Msg[3]);
  SSD1306_update();
  
  while (getPads() != 0);
  
  pause(2000);
  SSD1306_cls();
  
  while (getPads() == 0)
  {
    MMA7660_accel(&x, &y, &z);
    sprint(Buf, "X: %3d", x);
    SSD1306_writeSStr(32, 8, Buf);
    sprint(Buf, "Y: %3d", y);
    SSD1306_writeSStr(32, 16, Buf);
    sprint(Buf, "Z: %3d", z);
    SSD1306_writeSStr(32, 24, Buf);
    SSD1306_update();
  }
      
}

void EEProm()
{
  int v, x;
  
  print("4) Checking EEPROM Size\n");
  SSD1306_cls();
  SSD1306_writeStr(0, 0, Msg[4]);
  SSD1306_update();
  
  while (getPads() != 0);
  
  v = ee_getByte(0);
  x = ee_getByte(0x8000);
  if (v != x)
  {
    memcpy(&Msg[4][8], "- 64K", 5);
  }
  else
  {
    ee_putByte(255, 0x8000);
    x = ee_getByte(0x00);
    if (x == v)
    {
      ee_putByte(v, 0x8000);
      memcpy(&Msg[4][8], "- 32K", 5);
    }
  }
  
  SSD1306_writeStr(0, 0, Msg[4]);
  SSD1306_update();
  
  while (getPads() == 0);
}

void Ir()
{
  int i;
  
  print("5) Testing IR\n");
  SSD1306_cls();
  SSD1306_writeStr(0, 0, Msg[5]);
  SSD1306_update();
  
  i = input(IR_IN);
  if (i == 0)
  {
    memcpy(&Msg[5][8], "- Fail", 6);
    SSD1306_writeStr(0, 0, Msg[5]);
    SSD1306_update();
    return;
  }
  
  while (getPads() != 0);
  
  square_wave(IR_OUT, 0, IR_FREQ);
  
  while (getPads() == 0)
  {
    i = input(IR_IN);
    if (i == 0)
    {
      memcpy(&Msg[5][8], "- Yes", 5);
      SSD1306_writeStr(0, 0, Msg[5]);
    }
    else
    {
      memcpy(&Msg[5][8], "- No ", 5);
      SSD1306_writeStr(0, 0, Msg[5]);
    }
    SSD1306_update();
    pause(250);
  }
  square_wave_stop();                
}
   