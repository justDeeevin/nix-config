let selection = echo "Shut Down\nReboot\nSleep" | tofi

match $selection {
  "Shut Down" => {systemctl poweroff},
  "Reboot" => {reboot},
  "Sleep" => {systemctl suspend}
}
