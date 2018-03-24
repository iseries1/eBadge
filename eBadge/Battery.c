/*
 * @brief Get battery charge level
 * @author Michael Burmeister
 * @date March 14, 2018
 * @version 1.0
 */

#include "simpletools.h"
#include "Battery.h"

int getBattery(char p)
{
  int i;
  
  CTRB = 0;
  FRQB = 1;
  
  low(p);
  pause(1);
  CTRB = (12 << 26) | p;
  input(p);
  PHSB = 0;
  while (get_state(p) == 0);
  pause(1);
  i = 665 - PHSB * 1684 / 800000;
  return i;
}
  