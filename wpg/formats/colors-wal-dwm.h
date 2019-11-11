static const char norm_fg[] = "#f2fdff";
static const char norm_bg[] = "#10180a";
static const char norm_border[] = "#223415";

static const char sel_fg[] = "#f2fdff";
static const char sel_bg[] = "#8899AC";
static const char sel_border[] = "#f2fdff";

static const char urg_fg[] = "#f2fdff";
static const char urg_bg[] = "#99AEC6";
static const char urg_border[] = "#99AEC6";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
