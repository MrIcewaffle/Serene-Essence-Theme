#!/usr/bin/env bash

#systemctl or loginctl
if [ -x "$(command -v systemctl)"]; then
	SEATCTL='systemctl'
elif [ -x "$(command -v loginctl)"]; then
	SEATCTL='loginctl'
else
	echo "failed"
fi

ROFI="rofi"
#options should use 'icon' or 'icon | option-name'
A='Reload' B='Logout' C='Reboot' D='Shutdown'
MENU="$(printf "${A}\n${B}\n${C}\n${D}" | ${ROFI} -dmenu -p "Options" -selected-row 0)"

case "$MENU" in
	"$A") exec bspc wm -r
	;;
	"$B") exec bspc quit
	;;
	"$C") exec $SEATCTL reboot
	;;
	"$D") exec $SEATCTL poweroff
	;;
esac

#TODO:shell out to new script
#YES="Yes"
#NO="No"
#PROMPT="$(printf "${YES}\n${NO}" | ${ROFI} -p "Confirm ${OP}" -dmenu -selected-row 1)"
#
#case "$PROMPT" in 
#   	"$YES") exec "${SEATCTL} ${COMMAND}"
#	;;
#	"$NO") echo "${OP} via rofi was decline"
#	;;
#esac

exit ${?}
