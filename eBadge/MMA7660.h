/*
 * @brief MMA7660 accelerometer driver
 * @author Michael Burmeister
 * @date March 14, 2018
 * @version 1.0
 */

/*
 * @brief MMA7660 open connection
 * @param scl clock pin
 * @param sda data pin
 * @return connection state
 */
int MMA7660_open(char, char);

/*
 * @brief set mode
 * @param mode
 */
void MMA7660_setMode(char);

/*
 * @brief get mode
 * @return mode
 */
char MMA7660_getMode(void);

/*
 * @brief get accelerometer values
 * @param *x
 * @param *y
 * @param *z
 */
void MMA7660_accel(short *, short *, short *);

/*
 * @brief set interuptes
 * @param interupts
 */
void MMA7660_setInt(char);

/*
 * @brief set samples per second
 * @param samples
 */
void MMA7660_setSamples(char);

/*
 * @brief get sample rate
 * @return rate
 */
char MMA7660_getSamples(void);
