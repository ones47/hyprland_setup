#!/bin/bash

shutdown="󰐥  Shutdown"
#!/bin/bash

shutdown="󰐥  Shutdown"
reboot="󰜉  Reboot"
logout="󰍃  Logout"
suspend="󰤄  Suspend"
lock="󰌾  Lock"

chosen=$(printf "%s\n%s\n%s\n%s\n%s" "$shutdown" "$reboot" "$logout" "$suspend" "$lock" | rofi -dmenu -p "Power")

case "$chosen" in
	*Shutdown*)
		systemctl poweroff ;;
	*Reboot*)
		systemctl reboot ;;
	*Logout*)
		killall Hyprland ;;
	*Suspend*)
		echo "suspend not configured" ;;
	*Lock*)
		echo "lock not configured" ;;
esac
