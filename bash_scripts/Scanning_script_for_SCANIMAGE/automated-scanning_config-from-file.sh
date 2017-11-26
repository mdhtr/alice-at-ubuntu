#!/bin/bash
#Ubuntu 16.04
#Automatization of "scanimage" to create sequentially numbered output.

# Default options
x=213.8
y=300
ext="pnm"
mode="Color"
options=""
basicoptions="--resolution 300"
lineartoptions="--disable-dynamic-lineart=yes"

#START
printf "WELCOME TO AUTOMATED SCANIMAGE\n"
printf "Please type in the config file name or press enter for defaults"
echo -n "config: "; read config
if [[ $config != "" ]]; then
  while read line; do
  	if [[ ${line:0:1} != '#' ]]; then
	    eval $line
	  fi
  done < $config
fi

#make it failsafe:
if [[ $x>213.8 || $x = "" ]]; then x="213.8"; fi
if [[ $y>300 || $y = "" ]]; then y="300"; fi
if [[ $mode == [Ll] || $mode == "Lineart" ]]; then 
  mode="Lineart"
  options="$lineartoptions $basicoptions $options"
  if [[ $ext != "pnm" || $ext != "pbm" ]]; then
    ext="pnm"; 
  fi
elif [[ $mode == [Gg] || $mode == "Gray" || $mode == "Grey" || $mode == "Grayscale" ]]; then 
  mode="Gray" 
  options="$basicoptions $options"
  if [[ $ext != "pnm" ]]; then 
    ext="pnm"; 
  fi
else 
  mode="Color" 
  options="$basicoptions $options" 
  if [[ $ext != "pnm" ]]; then 
    ext="pnm"; 
  fi
fi

printf "Scan area will be: $x x $y mm\n"
printf "File extension will be $ext\n"
printf "Scan mode will be $mode\n"
printf "Scan options will be $options\n"

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
		scanimage -x $x -y $y --mode $mode $options > $date.$ext
	else break
	fi
done

echo "Finished scanning. Thank you for using this script :-*"

