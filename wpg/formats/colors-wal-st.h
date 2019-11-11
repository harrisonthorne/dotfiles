const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#10180a", /* black   */
  [1] = "#99AEC6", /* red     */
  [2] = "#8899AC", /* green   */
  [3] = "#979088", /* yellow  */
  [4] = "#748CA3", /* blue    */
  [5] = "#93A5B9", /* magenta */
  [6] = "#7698C4", /* cyan    */
  [7] = "#cad3de", /* white   */

  /* 8 bright colors */
  [8]  = "#223415",  /* black   */
  [9]  = "#b0e0ff",  /* red     */
  [10] = "#9cc5f3", /* green   */
  [11] = "#d6bc9e", /* yellow  */
  [12] = "#84b6e5", /* blue    */
  [13] = "#a9d5ff", /* magenta */
  [14] = "#85c2ff", /* cyan    */
  [15] = "#f2fdff", /* white   */

  /* special colors */
  [256] = "#10180a", /* background */
  [257] = "#f2fdff", /* foreground */
  [258] = "#f2fdff",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
