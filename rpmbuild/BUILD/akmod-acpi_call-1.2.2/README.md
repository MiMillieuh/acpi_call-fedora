# acpi\_call
This is a fork of [acpi_call](https://github.com/mkottman/acpi_call) maintained by the NixOS community.
Patches also for non-NixOS related fixes are welcome!

A simple kernel module that allows one to call ACPI methods by writing the
method name followed by its arguments to `/proc/acpi/call`.

## Notes on dkms and Secure Boot

If that is the way you want to install this module, you can follow 
[this guide](https://web.archive.org/web/20210215173902/https://gist.github.com/dop3j0e/2a9e2dddca982c4f679552fc1ebb18df) ([mirror](https://gist.github.com/s-h-a-d-o-w/53c2215e955c3326c6ec8f812a0d2f27))
to have dkms automatically sign the module after building.

## Usage

    echo '<call>' | sudo tee /proc/acpi/call

You can then retrieve the result of the call by checking your dmesg or:

    sudo cat /proc/acpi/call

An example to turn off the discrete graphics card in a dual graphics
environment (like NVIDIA Optimus):

    # turn off discrete graphics card
    echo '\_SB.PCI0.PEG1.GFX0.DOFF' > /proc/acpi/call
    # turn it back on
    echo '\_SB.PCI0.PEG1.GFX0.DON' > /proc/acpi/call

These work on my ASUS K52J notebook, but may not work for you. For a list of
methods to try, see http://linux-hybrid-graphics.blogspot.com/ or try running
the provided script `examples/turn_off_gpu.sh`

It SHOULD be ok to test all of the methods, until you see a drop in battery
drain rate (`grep rate /proc/acpi/battery/BAT0/state`), however it comes
with NO WARRANTY - it may hang your computer/laptop, fail to work, etc.

You can pass parameters to `acpi_call` by writing them after the method,
separated by single space. Currently, you can pass the following parameter
types:

* ACPI_INTEGER - by writing NNN or 0xNNN, where NNN is an integer/hex
* ACPI_STRING - by enclosing the string in quotes: "hello, world"
* ACPI_BUFFER - by writing bXXXX, where XXXX is a hex string without spaces,
                or by writing { b1, b2, b3, b4 }, where b1-4 are integers

The status after a call can be read back from `/proc/acpi/call`:

* 'not called' - nothing to report
* 'Error: <description>' - the call failed
* '0xNN' - the call succeeded, and returned an integer
* '"..."' - the call succeeded, and returned a string
* '{0xNN, ...}' - the call succeeded, and returned a buffer
* '[...]' - the call succeeded, and returned a package which may contain the
   above types (integer, string and buffer) and other package types


## GUI Alternatives

Found this too difficult? Try to use these programs provided by Marco Dalla Libera and do it via graphic interface. **Note that they is not suitable for arbitrary 
APCI calls but intended for turning off discrete graphics only**.

* [acpi_call_GUI (Ubuntu and his derivates)](https://github.com/marcoDallas/acpi_call_GUI)
* [acpi_call_GUI_systemd (all linux distros that support systemd: Ubuntu 16.04+, Fedora, Arch, Mandriva etc.)](https://github.com/marcoDallas/acpi_call_GUI_systemd)

***

Copyright (c) 2010: Michal Kottman

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
