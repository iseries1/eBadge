/*
 * @brief Make Badge LEDs work CharliePlex
 * @author Michael Burmeister
 * @date March 14, 2018
 * @version 1.0
 */
#include "simpletools.h"
#include "Leds.h"

void doLed(int);
void doRGB(int);
void doLeds(void *par);

unsigned char Cp[] = {0b000000, 0b011001, 0b011010, 0b110100,  // 0 1 2 3
                      0b110010, 0b101100, 0b101001};  // 4 5 6

unsigned char CCp[] = {0b000000, 0b101001, 0b011001, 0b110100, // None, Blue, Green, Red
                       0b101100, 0b011010, 0b110010}; // Blue, Green Red

unsigned char volatile _Blue = 0;
unsigned char volatile _RGB = 0;
unsigned char  _B1, _B2, _B3;
unsigned char  _C1, _C2, _C3;
int *_lcog, *_ccog;

/*
 * @brief Set Blue LED's
 */
void doLed(int l)
{
  int v = Cp[l];
  
  if ((v & 0b100000) != 0)
  {
    if ((v & 0b100) != 0)
      high(_B1);
    else
      low(_B1);
  }
  else
    input(_B1);

  if ((v & 0b10000) != 0)
  {
    if ((v & 0b010) != 0)
      high(_B2);
    else
      low(_B2);
  }
  else
    input(_B2);

  if ((v & 0b001000) != 0)
  {
    if ((v & 0b001) != 0)
      high(_B3);
    else
      low(_B3);
  }
  else
    input(_B3);
}

void Leds(int a, int b, int c, int d, int e, int f)
{
  _B1 = a;
  _B2 = b;
  _B3 = c;
  _C1 = d;
  _C2 = e;
  _C3 = f;
  _lcog = cog_run(&doLeds, 50);
}  

void BlueOn(int l)
{
  int i;
  
  i = 1 << l;
  _Blue = _Blue | i;
}

void BlueOff(int l)
{
  int i;

  i = 1 << l;
  i = ~i;
  i = i & 0b111111;
  
  _Blue = _Blue & i;
}

void doLeds(void *par)
{
  int i, j;
  
  _Blue = 0;
  _RGB = 0;
  
  i = 1;
  j = 1;
  
  while (1)
  {
    if ((_Blue & j) != 0)
      doLed(i);
    if ((_RGB & j) != 0)
      doRGB(i);
    j = j << 1;
    if (++i > 6)
    {
      i = 1;
      j = 1;
      if (_Blue == 0)
        doLed(0);
      if (_RGB == 0)
        doRGB(0);
    }
    pause(1);
  }
}

/*
 * @brief Set Color on
 */
void doRGB(int l)
{
  int v = CCp[l];
  
  if ((v & 0b100000) != 0)
  {
    if ((v & 0b100) != 0)
      high(_C1);
    else
      low(_C1);
  }
  else
    input(_C1);

  if ((v & 0b10000) != 0)
  {
    if ((v & 0b010) != 0)
      high(_C2);
    else
      low(_C2);
  }
  else
    input(_C2);

  if ((v & 0b001000))
  {
    if ((v & 0b001))
      high(_C3);
    else
      low(_C3);
  }
  else
    input(_C3);
}

void RGBLeft(int c)
{
  
  _RGB = _RGB & 0b111000;
  _RGB = _RGB | c;
}

void RGBRight(int c)
{
  
  c = c << 3;
  _RGB = _RGB & 0b000111;
  _RGB = _RGB | c;
}
    