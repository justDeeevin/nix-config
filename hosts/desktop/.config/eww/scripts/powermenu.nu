let selected_option = echo "logout
sleep
reboot
shutdown" | rofi -dmenu -i -p "Powermenu"

match $selected_option {
  "logout" => {
    hyprctl dispatch exit
  },
  "sleep" => {
    systemctl suspend
  },
  "reboot" => {
    systemctl reboot
  },
  "shutdown" => {
    systemctl poweroff
  },
}
