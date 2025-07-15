#!/bin/sh

folder="$HOME/valley of riches/Notes/"
SSHPASSWORD="$(pass ssh/butterfly)"

scrDir="$(dirname "$(realpath "$0")")"
. "${scrDir}/globalcontrol.sh"

roconf="${confDir}/rofi/styles/style_2.rasi"
[ -f "$roconf" ] || roconf="$(find "${confDir}/rofi/styles" -type f -name "style_*.rasi" | sort -t '_' -k 2 -n | head -1)"

[[ "${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=10

wind_border=$(( hypr_border * 3 ))
[ "$hypr_border" -eq 0 ] && elem_border="10" || elem_border=$(( hypr_border * 2 ))
r_override="window { border: ${hypr_width}px; border-radius: ${wind_border}px; } element { border-radius: ${elem_border}px; }"
r_scale="configuration { font: \"JetBrainsMono Nerd Font ${rofiScale}\"; }"
i_override=$(gsettings get org.gnome.desktop.interface icon-theme | sed "s/'//g")
i_override="configuration { icon-theme: \"${i_override}\"; }"

rofiprompt() {
    rofi -dmenu \
         -theme-str "$r_scale" \
         -theme-str "$r_override" \
         -theme-str "$i_override" \
         -config "$roconf" \
         -p "$1"
}

newnote() {
    name=$(rofiprompt "Name: ")
    [ -z "$name" ] && name=$(date +%F_%T | tr ':' '-')
    setsid -f wezterm start -- nvim "$folder/$name".md >/dev/null 2>&1
}

sync() {
    sshpass -p $SSHPASSWORD rsync -rtu "$HOME/valley of riches/" butterfly:/mnt/HD/HD_a2/butterfly/valley\ of\ riches/ && \
    sshpass -p $SSHPASSWORD rsync -rtu butterfly:/mnt/HD/HD_a2/butterfly/valley\ of\ riches/ "$HOME/valley of riches/" && \
    notify-send "Notes sync with butterfly completed."
}

selected() {
    choice=$(printf "󰎞 NEW NOTE\n SYNC TO BUTTERFLY\n%s" "$(ls -t1 "$folder")" | rofiprompt "Notes menu:")
    case $choice in
        " SYNC TO BUTTERFLY") sync ;;
        "󰎞 NEW NOTE") newnote ;;
        *.md) setsid -f wezterm start -- nvim "$folder/$choice" >/dev/null 2>&1 ;;
        *) exit ;;
    esac
}

selected
