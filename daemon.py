#!/usr/bin/env python3
import os, signal, sys, time

args = sys.argv[1:]
if not args:
    print("Usage: ./daemon.py <command>")
    sys.exit(1)

pid = None
def handle_stop(signum, stackframe):
    if pid is None:
        print()
        sys.exit(0)
    else:
        # While a child is open, the wrapper itself will only be killed if
        # using `kill` or `htop`. It should not be killed by Ctrl+C in most
        # shells. So, of this happens, pretend the user killed the child.
        os.kill(pid, signum)

signal.signal(signal.SIGINT, handle_stop)
signal.signal(signal.SIGTERM, handle_stop)
signal.signal(signal.SIGTTOU, signal.SIG_IGN)

while True:
    # Fork & exec
    pid = os.fork()
    if pid == 0:
        os.execvp(args[0], args)

    # Backup frontend process group
    old_fg = os.tcgetpgrp(sys.stdin.fileno())
    # Set process group
    os.setpgid(pid, pid)
    os.tcsetpgrp(sys.stdin.fileno(), pid)

    # Wait for exit or suspension
    while True:
        _, exit = os.waitpid(-pid, os.WUNTRACED)
        if os.WIFSTOPPED(exit):
            # If child is stopped, stop self and restart child when woken up.
            os.kill(os.getpid(), signal.SIGSTOP)
            os.kill(-pid, signal.SIGCONT)
        else:
            break
    pid = None

    # Restore process group
    os.tcsetpgrp(sys.stdin.fileno(), old_fg)

    if os.WIFSIGNALED(exit):
        signum = os.WTERMSIG(exit)
        signum = signal.Signals(signum)
        print("\nKilled by " + signum.name + ", exiting")
        break

    # Countdown
    print()
    for i in range(3, 0, -1):
        print("\rRestarting in " + str(i) + "...", end="", flush=True)
        time.sleep(1)
    print("\x1b[2K\x1b[GRestarting because of non-signal exit.")
