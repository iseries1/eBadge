/*
 * @brief Make Badge LEDs work CharliePlex
 * @author Michael Burmeister
 * @date March 14, 2018
 * @version 1.0
 */

#define LT 0
#define LM 1
#define LB 2
#define RT 3
#define RM 4
#define RB 5

enum {
  BLACK=0,
  BLUE,
  GREEN,
  CYAN,
  RED,
  MAJENTA,
  YELLOW,
  WHITE,
} colors;

/*
 * brief Start CharliePlex cog
 * param blue1
 * param blue2
 * param blue3
 * param rgb1
 * param rgb2
 * param rgb3
 */
void Leds(int, int, int, int, int, int);

/*
 * brief Turn blue LED on
 * param LED
 */
void BlueOn(int l);

/*
 * brief Turn blue LED off
 * param LED
 */
void BlueOff(int l);

/*
 * brief Turn RGB Left Leds
 * param Color
 */
void RGBLeft(int c);

/*
 * brief Turn RGB Right Leds
 * param Color
 */
void RGBRight(int c);
