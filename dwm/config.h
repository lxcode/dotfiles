/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "-*-fixed-medium-r-normal-*-12-*-*-*-*-*-*-*";
static const char normbordercolor[] = "#404040";
static const char normbgcolor[]     = "#282828";
static const char normfgcolor[]     = "#ffffff";
static const char selbordercolor[]  = "#f000ff";
static const char selbgcolor[]      = "#666666";
static const char selfgcolor[]      = "#ffffff";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     	NULL,       NULL,     0,         	True,       -1 },
	{ "MPlayer",    NULL,       NULL,       	0,      True,       -1 },
	{ "Firefox",  	NULL,       NULL,       	1 << 2, False,      -1 },
	{ "Opera",  	NULL,       NULL,       	1 << 2, False,      -1 },
	{ "vimprobable",  	NULL,       NULL,       	1 << 2, False,      -1 },
	{ "xombrero",  	NULL,       NULL,       	1 << 2, False,      -1 },
	{ "rdesktop",  	NULL,       NULL,      		0,      True,       -1 },
	{ "feh",		NULL,       NULL,      		0,      True,       -1 },
	{ NULL,  		NULL,   	"Buddy List", 	1 << 8,	False,      -1 },
	{ NULL,  		NULL,   	"Chromium", 	1 << 2,	False,      -1 },
	{ NULL,  		NULL,   	"Page(s) Unresponsive", 	1 << 2,	False,      -1 },
	{ "Workrave",	NULL,     	NULL,      		1 << 8, True,       -1 },
	{ "pinentry",	NULL,     	NULL,      		0,      True,       -1 },
};

#include "gaplessgrid.c"
/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "+++",      gaplessgrid },
	{ "|||",      col },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-i", "-m", dmenumon, "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "urxvtc", NULL };
static const char *lockcmd[]  = { "metalock", "-F", normbordercolor, "-w", "1", "-P", "-f", font, NULL };
static const char *cmusplaypause[]  = { "cmus-remote", "-u", NULL };

//#include "tilemovemouse.c"
#include "focusurgent.c"
#include "shiftview.c"
#include "movestack.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY, 						XK_u, 	   focusurgent,    {0} },
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
    { MODKEY,                       XK_x,      spawn,          {.v = lockcmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_c,      spawn,          {.v = cmusplaypause } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_i,      zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_w,      killclient,     {0} },
    { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
    { MODKEY,                       XK_g,      setlayout,      {.v = &layouts[3]} },
    { MODKEY,                       XK_n,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY|ControlMask,           XK_k,      focusmon,       {.i = -1 } },
	{ MODKEY|ControlMask,           XK_j,      focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_l,      tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_h,      tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
    { MODKEY,                       XK_a,      incnmaster,     {.i = +1 } },
    { MODKEY,                       XK_z,      incnmaster,     {.i = -1 } },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

