/*
 * @brief MMA7660 accelerometer driver
 * @author Michael Burmeister
 * @date March 14, 2018
 * @version 1.0
 */

#include "simpletools.h"
#include "MMA7660.h"
#include "MMA7660Reg.h"

i2c *_acc;
void writeByte(char , char , char );
unsigned char readByte(char , char);
void readBytes(char , char , char , char *);


int MMA7660_open(char clk, char sda)
{
  _acc = i2c_open(_acc, clk, sda, 0);
  if (_acc < 0)
    return -1;
  MMA7660_setMode(0x00);
  MMA7660_setInt(0x00);
  MMA7660_setSamples(AMPD);
  MMA7660_setMode(0x01);
}


void MMA7660_setMode(char m)
{
  writeByte(ADDR, MODE, m);
}

char MMA7660_getMode()
{
  return readByte(ADDR, MODE);
}

void MMA7660_accel(short *x, short *y, short *z)
{
  *x = readByte(ADDR, XOUT);
  *y = readByte(ADDR, YOUT);
  *z = readByte(ADDR, ZOUT);
  if (*x & 0x20)
  {
    *x = *x | 0xffe0;
  }
  if (*y & 0x20)
  {
    *y = *y  | 0xffe0;
  }
  if (*z & 0x20)
  {
    *z = *z | 0xffe0;
  }
}

void MMA7660_setInt(char i)
{
  writeByte(ADDR, INTSU, i);
}

char MMA7660_getInt()
{
  return readByte(ADDR, INTSU);
}

void MMA7660_setSamples(char s)
{
  writeByte(ADDR, SR, s);
}

char MMA7660_getSamples()
{
  return readByte(ADDR, SR);
}
      
  
/**
 * @detail I2C read write routines
 * @param open connection
 * @param address of device
 * @param register address
 * @param data to write
*/
void writeByte(char address, char subAddress, char data)
{
  i2c_out(_acc, address, subAddress, 1, &data, 1);
}

/**
 * @detail I2C read routine
 * @param open connection
 * @param address of device
 * @param register address
 * @return byte value
*/
uint8_t readByte(char address, char subAddress)
{
  uint8_t data;
  i2c_in(_acc, address, subAddress, 1, &data, 1);
  return data;
}

/**
 * @detail I2C read routine
 * @param open connection
 * @param address of device
 * @param register address
 * @return array of byte values
*/
void readBytes(char address, char subAddress, char cnt, char *dest)
{
  i2c_in(_acc, address, subAddress, 1, dest, cnt);
}
