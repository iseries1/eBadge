/*
 * @brief Read Finger Touch Pads
 * @author Michael Burmeister
 * @date March 14, 2018
 * @version 1.0
 */

#include "simpletools.h"
#include "Pads.h"

void doPadScan(void *);

int *_pcog;

char *_P;
int _T;

void Pads(char *p)
{
  _P = p;
  _pcog = cog_run(&doPadScan, 50);
}

void doPadScan(void *par)
{
  int i, p;
  
  FRQA = 1;
  _T=0;
  
  i = 0;
  while (1)
  {
    if (_P[i] > 30)
      i = 0;
    p = _P[i];
    high(p);
    pause(1);
    CTRA = 8 << 26 | p;
    input(p);
    PHSA = 0;
    pause(80);
    if (PHSA/80000 < 50)
      _T |= 1 << i;
    else
      _T = _T & ~(1 << i);
    if (++i > 30)
      i = 0;
  }
}      

int getPads(void)
{
  return _T;
}
