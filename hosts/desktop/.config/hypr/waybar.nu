if ((ps | find waybar).pid != []) {
  kill (ps | find waybar).pid.0
}

bash -c "waybar &"
