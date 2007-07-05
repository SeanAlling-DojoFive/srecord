#!/bin/sh
#
#       srecord - manipulate eprom load files
#       Copyright (C) 2001, 2006, 2007 Peter Miller
#
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 3 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program. If not, see
#       <http://www.gnu.org/licenses/>.
#
# MANIFEST: Test the Fast Load functionality
#
here=`pwd`
if test $? -ne 0 ; then exit 2; fi
work=${TMP_DIR-/tmp}/$$

pass()
{
        cd $here
        rm -rf $work
        echo PASSED
        exit 0
}

fail()
{
        cd $here
        rm -rf $work
        echo 'FAILED test of the Fast Load functionality'
        exit 1
}

no_result()
{
        cd $here
        rm -rf $work
        echo 'NO RESULT for test of the Fast Load functionality'
        exit 2
}

trap "no_result" 1 2 3 15

bin=$here/${1-.}/bin
mkdir $work
if test $? -ne 0; then no_result; fi
cd $work
if test $? -ne 0; then no_result; fi

#
# Test the Fast Load format
#
cat > test.in << 'fubar'
S00600004844521B
S123000067C6697351FF4AEC29CDBAABF2FBE3467CC254F81BE8E78D765A2E63339FC99A45
S123002066320DB73158A35A255D051758E95ED4ABB2CDC69BB454110E827441213DDC871F
S123004070E93EA141E1FC673E017E97EADC6B968F385C2AECB03BFB32AF3C54EC18DB5CF9
S1230060021AFE43FBFAAA3AFB29D1E6053C7C9475D8BE6189F95CBBA8990F95B1EBF1B3F0
S123008005EFF700E9A13AE5CA0BCBD0484764BD1F231EA81C7B64C514735AC55E4B7963B5
S12300A03B706424119E09DCAAD4ACF21B10AF3B33CDE3504847155CBB6F2219BA9B7DF5E5
S12300C00BE11A1C7F23F829F8A41B13B5CA4EE8983238E0794D3D34BC5F4E77FACB6C0589
S12300E0AC86212BAA1A55A2BE70B5733B045CD33694B3AFE2F0E49E4F321549FD824EA92A
S104010008F2
S12301052954489A0ABCD50E18A844AC5BF38E4CD72D9B0942E506C433AFCDA3847F2DAD2E
S1230125D47647DE321CEC4AC430F62023856CFBB20704F4EC0BB920BA86C33E05F1ECD92D
S12301456733B79950A3E314D3D934F75EA0F210A8F6059401BEB4BC4478FA4969E623D044
S12301651ADA696A7E4C7E5125B34884533A94FB319990325744EE9BBCE9E525CF08F5E942
S1230185E25E5360AAD2B2D085FA54D835E8D466826498D9A8877565705A8A3F6280294421
S12301A5DE7CA5894E5759D351ADAC869580EC17E485F18C0C66F17CC07CBB22FCE466DA97
S12301C5610B63AF62BC83B4692F3AFFAF271693AC071FB86D11342D8DEF4F89D4B6633514
S12301E5C1C7E4248367D8ED9612EC453902D8E50AF89D7709D1A596C1F41F95AA82CA6CF0
S123020549AE90CD1668BAAC7AA6F2B4A8CA99B2C2372ACB08CF61C9C3805E6E0328DA4CCB
S1230225D76A19EDD2D3994C798B0022569AD418D1FEE4D9CD45A391C601FFC92AD9150168
S1230245432FEE150287617C13629E69FC7281CD7165A63E000000000000000000000000C8
S1230265000000000000000000000000000000000000000000000000000000000000000075
S1230285000000000000000000000000000000000000000000000000000000000000000055
S12302A500000000000000000000000000000000000000000000007097DE0C56891A2B21FF
S12302C51B01070DD8FD8B16C2A1A4E3CFD292D2984B3561D555D16C33DDC2BCF7EDDE133D
S12302E5EFE520C7E2ABDDA44D81881C531AEEEB66244C3B791EA8ACFB6A68F358460647CD
S12303052B260E0DD2EBB21F6C3A3BC0542AABBA4EF8F6C7169E731108DB0460220AA74DB4
S123032531B55B03A00D220D475DCD9B877856D5704C9C86EA0F98F2EB9C530DA7FA5AD843
S1230345B0B5DB50C2FD5D095A2AA5E2A3FBB71347549A316332234ECE765B7571B64D2157
S12303656B28712E25CF3780F9DC629CD719B01E6D4A4FD17C731F4AE97BC05A310D7B9C04
S123038536EDCA5BBC02DBB5DE3D52B65702D4C44C2495C897B5128030D2DB61E056FD1678
S12303A543C871FFCA4DB5A88A075EE10933A655573B1DEEF02F6E20024981E2A07FF8E34C
S12303C54769E311B698B9419F1822A84BC8FDA2041A90F449FE154B48962DE81525CB5C58
S11E03E58FAE6D45462786E53FA98D8A718A2C75A4BC6AEEBA7F39021567EA05
S5030021DB
S9030000FC
fubar
if test $? -ne 0; then no_result; fi

cat > test.ok << 'fubar'
/AAAA
Z8Zpc1H.Suwpzbqr8vvjRnzCVPgb6OeNdlouYzOfyZpmMg23MVijWiVdBRdY6V7Uq7LNxpu0VBEOgnRB
IT3ch3DpPqFB4fxnPgF,l,rca5aPOFwq7LA7,zKvPFTsGNtcAhr,Q.v6qjr7KdHmBTx8lHXYvmGJ,Vy7
qJkPlbHr8bMF7.cA6aE65coLy9BIR2S9HyMeqBx7ZMUUc1rFXkt5YztwZCQRngncqtSs8hsQrzszzeNQ
SEcVXLtvIhm6m331C,EaHH8j,Cn4pBsTtcpO6JgyOOB5TT00vF9Od.rLbAWshiErqhpV/CHGL/KAA
or5wtXM7BFzTNpSzr,Lw5J5PMhVJ.YJO/BCp/BAI/AAEF
KVRImgq81Q4YqESsW.OOTNctmwlC5QbEM6.No4R.La3UdkfeMhzsSsQw9iAjhWz7sgcE9OwLuSC6hsM,
BfHs2Wczt5lQo,MU09k0916g8hCo9gWUAb60vER4,klp5iPQGtppan5MflEls0iEUzqU,zGZkDJXRO6b
vOnlJc8I9eniXlNgqtKy0IX6VNg16NRmgmSY2aiHdWVwWoo.YoApRN58pYlOV1nTUa2shpWA7BfkhfGM
DGbxfMB8uyL85GbaYQtjr2K8g7RpLzr.rycW/CHhe/KAA
k6wHH7htETQtje9PidS2YzXBx,Qkg2fY7ZYS7EU5AtjlCviddwnRpZbB9B,VqoLKbEmukM0WaLqseqby
tKjKmbLCNyrLCM9hycOAXm4DKNpM12oZ7dLTmUx5iwAiVprUGNH,5NnNRaORxgH.ySrZFQFDL,4VAodh
fBNinmn8coHNcWWmPgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/CESc/KAA
AHCX3gxWiRorIRsBBw3Y.YsWwqGk48.SktKYSzVh1VXRbDPdwrz37d4T7,Ugx,Kr3aRNgYgcUxru62Yk
TDt5Hqis,2po81hGBkcrJg4N0uuyH2w6O8BUKqu6Tvj2xxaecxEI2wRgIgqnTTG1WwOgDSINR13Nm4d4
VtVwTJyG6g,Y8uucUw2n,lrYsLXbUML9XQlaKqXio.u3E0dUmjFjMiNOznZbdXG2TSFrKHEuJc83gPnc
YpzXGbAebUpP0XxzH0rpe8BaMQ17nDbtylu8Atu13j1StlcC1MRMJJXIl7USgDDS22Hg/CG7n/KAA
Vv0WQ8hx.8pNtaiKB17hCTOmVVc7He7wL24gAkmB4qB.,ONHaeMRtpi5QZ8YIqhLyP2iBBqQ9En,FUtI
li3oFSXLXI,ubUVGJ4blP6mNinGKLHWkvGruun85AhVn/BDq/CC0B/AAAA/EAA
fubar
if test $? -ne 0; then no_result; fi

$bin/srec_cat test.in -o test.out -fastload
if test $? -ne 0; then fail; fi

$bin/srec_cmp test.in test.out -fastload
if test $? -ne 0; then fail; fi

diff test.ok test.out
if test $? -ne 0; then fail; fi

#
# The things tested here, worked.
# No other guarantees are made.
#
pass
