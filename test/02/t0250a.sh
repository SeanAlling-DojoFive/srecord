#!/bin/sh
#
# srecord - Manipulate EPROM load files
# Copyright (C) 2013 Peter Miller
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

TEST_SUBJECT="read logisim"
. test_prelude.sh

cat > test.in << 'fubar'
v2.0 raw

02
03
00
14
ff
123*8F
fubar
if test $? -ne 0; then no_result; fi

cat > test.ok << 'fubar'
00000000: 02 03 00 14 FF 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F  #................
00000010: 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F  #................
00000020: 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F  #................
00000030: 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F  #................
00000040: 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F  #................
00000050: 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F  #................
00000060: 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F  #................
00000070: 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F 8F  #................
fubar
if test $? -ne 0; then no_result; fi

 valgrind --leak-check=yes srec_cat test.in -logi -o test.out -hexdump
if test $? -ne 0; then fail; fi

diff test.ok test.out
if test $? -ne 0; then fail; fi

#
# The things tested here, worked.
# No other guarantees are made.
#
pass
