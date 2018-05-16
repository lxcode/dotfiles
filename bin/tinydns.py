#!/usr/local/bin/python


# Reads log files from tinydns and/or dnscache and prints them out in
# human-readable form.  Logs can be supplied on stdin, or listed on
# the command line:

# cat @*.s | parse_djbdns_log
# parse_djbdns_log @*.s
# tail -f current | parse_djbdns_log

# Pipes each log file through tai64nlocal, which must be on your path.

# Requirements:
# * tai64nlocal on the path
# * Python 2.2 or greater

# Acknowledgments:

# * The log format descriptions by Rob Mayoff were invaluable:
#   http://dqd.com/~mayoff/notes/djbdns/tinydns-log.html
#   http://dqd.com/~mayoff/notes/djbdns/dnscache-log.html

# * Faried Nawaz's dnscache log parser was the original inspiration:
#    http://www.hungry.com/~fn/dnscache-log.pl.txt

# Written by Greg Ward <gward@python.net> 2001/12/13.

# Modified to handle IPv6 addresses (as logged by djbdns with the patch at
# http://www.fefe.de/dns/), 2003/05/03-04, prodded and tested by Jakob
# Hirsch <jh@plonk.de>.

# Modified to handle dnscache's AXFR request log lines by Malte Tancred
# (http://tancred.com/malte.html), 2005/12/20.
# """

import sys
import re
from popen2 import popen2
from time import strftime, gmtime
from struct import pack

# common components of line-matching regexes
timestamp_pat = r'[\d-]+ [\d:\.]+'      # output of tai64nlocal
hex4_pat = r'[0-9a-f]{4}'
ip_pat = r'[0-9a-f]{8,32}'              # IPv4 or IPv6 addresses in hex

# discriminate between dnscache and tinydns log lines
tinydns_log_re = re.compile(
    r'(%s) (%s):(%s):(%s) ([\+\-IC/]) (%s) (.*)'
    % (timestamp_pat, ip_pat, hex4_pat, hex4_pat, hex4_pat))
dnscache_log_re = re.compile(r'(%s) (\w+)(.*)' % timestamp_pat)

query_type = {
      1: "a",
      2: "ns",
      5: "cname",
      6: "soa",
      12: "ptr",
      13: "hinfo",
      15: "mx",
      16: "txt",
      17: "rp",
      24: "sig",
      25: "key",
      28: "aaaa",
      38: "a6",
      252: "axfr",
      255: "any",
}

# for tinydns only
query_drop_reason = {
    "-": "no authority",
    "I": "invalid query",
    "C": "invalid class",
    }


def warn(filename, msg):
    sys.stderr.write("warning: %s: %s\n" % (filename, msg))


def convert_ip(ip):
    """Convert a hex string representing an IP address to conventional
    human-readable form, ie. dotted-quad decimal for IPv4, and
    8 colon-separated hex shorts for IPv6.
    """
    if len(ip) == 8:
        # IPv4, eg. "7f000001" -> "127.0.0.1"
        return "%d.%d.%d.%d" % tuple(map(ord, pack(">L", long(ip, 16))))
    elif len(ip) == 32:
        # IPv6 is actually simpler -- it's just a string-slicing operation,
        # eg. "00000000000000000000ffff7f000001" ->
        # "0000:0000:0000:0000:0000:ffff:7f00:0001"
        return ":".join([ip[(4*i) : (4*i+4)] for i in range(8)])


def _cvt_ip(match):
    return convert_ip(match.group(1))


def _cvt_port(match):
    return ":" + str(int(match.group(1), 16))


def decode_client(words, i):
    chunks = words[i].split(":")
    if len(chunks) == 2:                # ip:port
        words[i] = "%s:%d" % (convert_ip(chunks[0]), int(chunks[1], 16))
    elif len(chunks) == 3:
        words[i] = "%s:%d (id %d)" % (convert_ip(chunks[0]),
                                      int(chunks[1], 16),
                                      int(chunks[2], 16))


def decode_ip(words, i):
    words[i] = convert_ip(words[i])


def decode_ttl(words, i):
    words[i] = "TTL=%s" % words[i]


def decode_serial(words, i):
    serial = int(words[i])
    words[i] = "#%d" % serial


def decode_type(words, i):
    qt = words[i]
    words[i] = query_type.get(int(qt), qt)


def handle_dnscache_log(line, match):
    (timestamp, event, data) = match.groups()

    words = data.split()
    if event == "cached":
        if words[0] not in ("cname", "ns", "nxdomain"):
            decode_type(words, 0)

    elif event == "drop":
        decode_serial(words, 0)

    elif event == "lame":
        decode_ip(words, 0)

    elif event == "nodata":
        decode_ip(words, 0)
        decode_ttl(words, 1)
        decode_type(words, 2)

    elif event == "nxdomain":
        decode_ip(words, 0)
        decode_ttl(words, 1)

    elif event == "query":
        decode_serial(words, 0)
        decode_client(words, 1)
        decode_type(words, 2)

    elif event == "rr":
        decode_ip(words, 0)
        decode_ttl(words, 1)
        if words[2] not in ("cname", "mx", "ns", "ptr", "soa"):
            decode_type(words, 2)
            if words[2] == "a":         # decode answer to an A query
                decode_ip(words, 4)
            if words[2] == "txt":       # text record
                response = words[4]
                if response.endswith("..."):
                    ellipsis = "..."
                    response = response[0:-3]
                else:
                    ellipsis = ""
                length = int(response[0:2], 16)
                chars = []
                for i in range(1, len(response)/2):
                    chars.append(chr(int(response[2*i : (2*i)+2], 16)))
                words[4] = "%d:\"%s%s\"" % (length, "".join(chars), ellipsis)

    elif event == "sent":
        decode_serial(words, 0)

    elif event == "stats":
        words[0] = "count=%s" % words[0]
        words[1] = "motion=%s" % words[1]
        words[2] = "udp-active=%s" % words[2]
        words[3] = "tcp-active=%s" % words[3]

    elif event == "tx":
        words[0] = "g=%s" % words[0]
        decode_type(words, 1)
        # words[2] = name
        # words[3] = control (domain for which these servers are believed
        #            to be authoritative)
        for i in range(4, len(words)):
            decode_ip(words, i)

    elif event in ("tcpopen", "tcpclose"):
        decode_client(words, 0)

    print timestamp, event, " ".join(words)


def handle_tinydns_log(line, match):
    (timestamp, ip, port, id, code, type, name) = match.groups()
    ip = convert_ip(ip)
    port = int(port, 16)
    id = int(id, 16)
    type = int(type, 16)                # "001c" -> 28
    type = query_type.get(type, type)   # 28 -> "aaaa"

    print timestamp,

    if code == "+":
        print("sent response to %s:%s (id %s): %s %s"
               % (ip, port, id, type, name))
    elif code in ("-", "I", "C"):
        reason = query_drop_reason[code]
        print("dropped query (%s) from %s:%s (id %s): %s %s"
               % (reason, ip, port, id, type, name))
    elif code == "/":
        print("dropped query (couldn't parse) from %s:%s"
               % (ip, port))
    else:
        print("%s from %s:%s (id %s): %s %s"
               % (code, ip, port, id, type, name))


def parse_logfile(file, filename):
    # Open pipe to tai64nlocal: we will write lines of our input (the
    # raw log file) to it, and read log lines with readable timestamps
    # from it.
    (tai_stdout, tai_stdin) = popen2("tai64nlocal", 0)

    for line in file:
        tai_stdin.write(line)
        line = tai_stdout.readline()

        match = tinydns_log_re.match(line)
        if match:
            handle_tinydns_log(line, match)
            continue

        match = dnscache_log_re.match(line)
        if match:
            handle_dnscache_log(line, match)
            continue

        sys.stdout.write(line)

# parse_logfile ()


def main():

    if len(sys.argv) > 1:
        for filename in sys.argv[1:]:
            if filename == "-":
                parse_logfile(sys.stdin, "(stdin)")
            else:
                file = open(filename)
                parse_logfile(file, filename)
                file.close()
    else:
        parse_logfile(sys.stdin, "(stdin)")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit("interrupted")

