#!/usr/bin/env python3

import curses, signal, subprocess, sys

ALL_SERVICES = list(map(
    lambda s: s.split(' ')[0],
    subprocess.run(["systemctl", "list-unit-files", "openvpn-*", "-t", "service"], capture_output=True, text=True)
        .stdout.splitlines()
))

def reconnect(endpoint):
    subprocess.run(["sudo", "systemctl", "stop", "openvpn-*.service"])
    subprocess.run(["sudo", "systemctl", "start", endpoint])
    pass

signal.signal(signal.SIGINT, lambda signum, stackframe: sys.exit())

def main_curses(s):
    query = ""

    s.keypad(True)
    curses.curs_set(0)

    max_y, max_x = s.getmaxyx()

    while True:
        units = list(filter(lambda s: s.startswith("openvpn-" + query), ALL_SERVICES))

        s.clear()
        s.addstr(0, 0, "> openvpn-" + query)
        for i, unit in enumerate(units):
            if 1+i >= max_y:
                break
            s.addstr(1+i, 0, unit, curses.A_BOLD if i == 0 else 0)
        s.refresh()

        key = s.get_wch()
        if key in ['\x7f', '\b', curses.KEY_BACKSPACE]:
            query = query[:-1]
        elif key in ['\n', curses.KEY_ENTER]:
            return units[0] if len(units) > 0 else None
        elif isinstance(key, str) and key:
            query += key
        else:
            s.addstr(1, 0, str(key))

endpoint = curses.wrapper(main_curses)
if endpoint is not None:
    reconnect(endpoint)
