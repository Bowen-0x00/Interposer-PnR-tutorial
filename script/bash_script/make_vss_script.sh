#!/bin/sh

## Set variables.
#mkdir ./script/PDN_script/
scr=./script/PDN_script/add_vss_mesh.scr
h_length=1750.00
h_width=40.00
v_length=1750.00
v_width=40.00

vdd_metal=M4

v_start_pt=-875
h_start_pt=875

h_spt=875
h_ept=-835
h_count=`expr \( $h_spt \- $h_ept \) / 90 `

v_spt=-875
v_ept=835
v_count=`expr \( $v_ept \- $v_spt \) / 90 `

## Generate script file.
echo -e "## Allegro VSS mesh script." > $scr
echo -e "## generated by JKIM." >> $scr
echo -e "\n" >> $scr
echo -e "version 17.2" >> $scr
echo -e "\n" >> $scr
echo -e "setwindow pcb" >> $scr
echo -e "trapsize 2620" >> $scr
echo -e "\n" >> $scr
echo -e "## Set VSS layer" >> $scr
echo -e "generaledit" >> $scr
echo -e "\n" >> $scr
echo -e "## Set metal layer for VSS" >> $scr
echo -e "generaledit" >> $scr
echo -e "setwindow form.mini" >> $scr
echo -e "FORM mini subclass $vdd_metal " >> $scr
echo -e "setwindow pcb" >> $scr
echo -e "\n" >> $scr
echo -e "## Add rect." >> $scr
echo -e "generaledit" >> $scr
echo -e "add rect " >> $scr
echo -e "\n" >> $scr
## Horizontal.
echo -e "## Horizontal VSS" >> $scr
echo -e "setwindow form.mini" >> $scr
echo -e "FORM mini rec_place YES " >> $scr
echo -e "FORM mini rec_width $h_length " >> $scr
echo -e "FORM mini rec_height $h_width " >> $scr
echo -e "setwindow pcb" >> $scr
echo -e "\n" >> $scr
echo -e "# Pick" >> $scr
echo -e "\n" >> $scr

for i in $(seq 0 $h_count)
do
	h_tmp=`expr $h_spt \- \( $i \* 90 \)`
	echo -e "pick grid\t$v_start_pt\t$h_tmp" >> $scr
	echo -e "fillin\t\t\"Vss\"" >> $scr
done

echo -e "\n" >> $scr
## Vertical.
echo -e "## Vertial VSS" >> $scr
echo -e "setwindow form.mini" >> $scr
echo -e "FORM mini rec_width $v_width " >> $scr
echo -e "FORM mini rec_height $v_length " >> $scr
echo -e "setwindow pcb" >> $scr
echo -e "\n" >> $scr

for i in $(seq 0 $v_count)
do
	v_tmp=`expr $v_spt \+ \( $i \* 90 \)`
	echo -e "pick grid\t$v_tmp\t$h_start_pt" >> $scr
	echo -e "fillin\t\t\"Vss\"" >> $scr
done

echo -e "done" >> $scr
