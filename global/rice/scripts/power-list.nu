let selection = echo "Shut Down\nReboot\nSleep" | fuzzel -d

match $selection {
  "Shut Down" => {systemctl poweroff},
  "Reboot" => {reboot},
  "Sleep" => {systemctl suspend}
}
