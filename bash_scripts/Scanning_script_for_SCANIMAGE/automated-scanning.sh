#!/bin/bash
#Ubuntu 10.04 Lucid Lynx

#Automatization of "scanimage" to create sequentially numbered output.

#START
echo "WELCOME TO AUTOMATED SCANIMAGE"
echo ""

echo "Please give me the size of scan area in mm"
echo -n "width: "; read x
echo -n "height: "; read y
#make it failsafe:
if [[ $x>213.8 || $x = "" ]]; then x="213.8"; fi
if [[ $y>300 || $y = "" ]]; then y="300"; fi

echo "Scan area will be: $x x $y mm"
echo ""

echo "Please choose scan mode: L for Lineart, G for Gray. Press enter for Color."; read mode
#make it failsafe:
if [[ $mode == [Ll] ]]; then mode="Lineart" && ext="pbm"
elif [[ $mode == [Gg] ]]; then mode="Gray" && ext="pnm"
else  mode="Color" && ext="pnm"
fi

echo "Scan mode will be $mode"

#print "to start printing press enter to quit press escape"
#scan and save
#go back to enter or escape
date=1
while true; do
	echo -n "Press 'enter' to scan; anything else to quit' "; read scan;
	if [[ $scan = "" ]]; then
		let "date =`date +%Y%m%d%H%M%S`"
		echo "Scanning will progress with the following parameters:"
		echo "size: $x x $y, mode $mode, filename: $date.$ext"
		scanimage -x $x -y $y --mode $mode > $date.$ext
	else break
	fi
done

echo "Finished scanning. Thank you for using this script :-*"

