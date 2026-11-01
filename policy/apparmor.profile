#include <tunables/global>

# Task 4 profile for the intentionally vulnerable HW3 parser.
# This profile is deliberately tied to the absolute parser path used by this
# checkout. Update all /home/ubuntu/Desktop/765HW3 paths if the checkout moves.
profile legacy_log_parser /home/ubuntu/Desktop/765HW3/src/legacy_log_parser {
    # Basic runtime support for a dynamically linked C program.
    # No program-execution rule is granted, so unrelated programs and shells
    # remain denied by default.
    /home/ubuntu/Desktop/765HW3/src/legacy_log_parser r,
    /lib64/ld-linux-x86-64.so.2 mr,
    /lib/x86_64-linux-gnu/libc.so.6 mr,
    /usr/lib/x86_64-linux-gnu/libc.so.6 mr,
    /etc/ld.so.cache r,
    /etc/ld.so.preload r,

    # The selected payload is the only input file allowed by this profile.
    /home/ubuntu/Desktop/765HW3/inbox/ret2win_payload.bin r,

    # win() may create or update marker files, but only under markers/.
    /home/ubuntu/Desktop/765HW3/markers/ rw,
    /home/ubuntu/Desktop/765HW3/markers/** rw,

    # The fake protected secret must remain inaccessible and must be logged.
    audit deny /opt/agentsec/decoy.txt rwklx,

    # Explicitly log attempts to execute common shells or command interpreters.
    audit deny /bin/sh x,
    audit deny /bin/bash x,
    audit deny /usr/bin/dash x,
    audit deny /usr/bin/env x,

    # Permit normal process termination and standard output/error devices.
    /dev/null rw,
    /dev/tty rw,
}
