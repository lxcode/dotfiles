# dvtm version
VERSION = 0.14

# Customize below to fit your system

PREFIX ?= /usr/local
MANPREFIX = ${PREFIX}/share/man
# specify your systems terminfo directory
# leave empty to install into your home folder
TERMINFO := ${DESTDIR}${PREFIX}/share/terminfo

INCS = -I.
LIBS = -lc -lutil -lncurses
# NetBSD
#LIBS = -lc -lutil -lcurses
# AIX
#LIBS = -lc -lncursesw
# Solaris
#INCS = -I/usr/include/ncurses
#LIBS = -lc -lncursesw
# Cygwin
#INCS = -I/usr/include/ncurses

CPPFLAGS = -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -D_XOPEN_SOURCE_EXTENDED -D_DARWIN_C_SOURCE
CFLAGS += -std=c99 ${INCS} -DVERSION=\"${VERSION}\" -DNDEBUG ${CPPFLAGS}
LDFLAGS += ${LIBS}

DEBUG_CFLAGS = ${CFLAGS} -UNDEBUG -O0 -g -ggdb -Wall -Wextra -Wno-unused-parameter

CC ?= cc
STRIP ?= strip
