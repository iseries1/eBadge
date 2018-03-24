/*
 * @brief MMA7660 accelerometer driver
 * @author Michael Burmeister
 * @date March 14, 2018
 * @version 1.0
 */

#define ADDR 0x4c
#define XOUT 0x00
#define YOUT 0x01
#define ZOUT 0x02
#define TILT 0x03
#define SRST 0x04
#define SPCNT 0x05
#define INTSU 0x06
#define MODE 0x07
#define SR 0x08
#define PDET 0x09
#define PD 0x0a

enum {
  AMPD = 0,
  AM65,
  AM32,
  AM16,
  AM8,
  AM4,
  AM2,
  AM1
} modes;

enum {
  AW32 = 0,
  AW16,
  AW8,
  AW1
} Wakes;
  