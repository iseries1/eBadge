/*
 * @brief SSD1306 Display driver
 * @author Michael Burmeister
 * @date March 14, 2018
 * @version 1.0
 */

// Display in use
//#define SSD1306_128_64
//#define SSD1306_128_32
#include "SSD1306cmd.h"

/*
 * @brief Initalize display
 * @param CS chip select
 * @param DC data command select
 * @param SDA data line
 * @param SCL clock line
 * @param RST reset display select
 * @param S vcc state
 * @param T display type
 */
int SSD1306_init(int, int, int, int, int, int, int);

/*
 * @brief Send data to display
 * @param byte to send
 */
void SSD1306_write(char);

/*
 * @brief Send command to display
 * @param command to send
 */
void SSD1306_cmd(char);

/*
 * @brief Invert display
 * @param true or false
 */
void SSD1306_invert(int);

/*
 * @brief AutoUpdate
 * @param on or off
 */
void SSD1306_auto(int);

/*
 * @brief Update display with buffer
 * @param none
 */
void SSD1306_update(void);

/*
 * @brief Clear screen buffer and screen
 */
void SSD1306_cls(void);

/*
 * @brief Return pointer to buffer
 * @return _Buffer
 */
char* SSD1306_getBuffer(void);

/*
 * @brief Scroll right
 * @param starting page
 * @param ending page
 * @param frame speed
 */
void SSD1306_scrollRight(char, char, char);

/*
 * @brief Scroll left
 * @param starting page
 * @param ending page
 * @param frame speed
 */
void SSD1306_scrollLeft(char, char, char);

/*
 * @brief Scroll diagonal right
 * @param starting page
 * @param ending page
 */
void SSD1306_scrollDiagRight(char, char, char);

/*
 * @brief Scroll diagonal left
 * @param starting page
 * @param ending page
 */
void SSD1306_scrollDiagLeft(char, char, char);

/*
 * @brief Scroll stop
 */
void SSD1306_scrollStop(void);

/*
 * @brief plot a poiint
 * @param x offset
 * @param y offset
 * @param on/off
 */
void SSD1306_plot(short, short, char);

/*
 * @brief write char
 * @param x offset
 * @param y offset
 * @param char
 */
void SSD1306_writeChar(char, char, char);

/*
 * @brief write string
 * @param x offset
 * @param y offset
 * @param string
 */
void SSD1306_writeStr(char, char, char*);

/*
 * @brief write small char
 * @param x offset
 * @param y offset
 * @param char
 */
void SSD1306_writeSChar(char, char, char);

/*
 * @brief write small string
 * @param x offset
 * @param y offset
 * @param char
 */
void SSD1306_writeSStr(char, char, char*);

/*
 * @brief Bresenham's line algorithm
 * @param x start point
 * @param y start point
 * @param x1 end point
 * @param y1 end point
 */
void SSD1306_drawLine(short, short, short, short);

/*
 * @brief draw a box
 * @param x start point
 * @param y start point
 * @param x1 end point
 * @param y1 end point
 */
void SSD1306_drawBox(short, short, short, short);

/*
 * @brief set Contrast
 * @param value
 */
void SSD1306_setContrast(short);
