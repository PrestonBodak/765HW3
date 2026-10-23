# Setup

Follow the installation steps from Task 0 in the lab manual AND the instructions under "Fake Protected File" in Task 1. This file will be needed to run Task 1.

# Modifying legacy_log_parser.c:

Since changes to the source code impact the arrangement of memory, a change must also be followed by an adjustment to the buffer overflow attack to properly call the win function. After making a source code change related to Task 1, please take the following steps to ensure the attack is still functional:

1. Build the program and load it into gdb.
2. Within gdb, run `info address win` to find the new address of the function.
3. Exit gdb and run `truncate -s -8 buf.txt` to delete the last 8 bytes (the return address) of the file.
4. Append the new address with `echo -en [ADDRESS] >> buf.txt`. Note that the address must be entered in reverse-endian-ness to which it appears in gdb, so a win address of `0x401256` would be appended with the command `echo -en '\x56\x12\x40\x00\x00\x00\x00\x00' >> buf.txt`. The address must be padded to a length of 8 bytes.

If the overflow is still unsuccessful, check that the value of `$rbp` is same before and after the call to `memcpy()` in `vulnerable_copy()`; it should be intentionally overwritten with its initial original value in buf.txt since it lies inbetween the buffer and the return address `$rip`. In gdb, the value can be checked with `x/gx $rbp`.