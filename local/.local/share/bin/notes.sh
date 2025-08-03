#!/bin/sh

schoolfolder="$HOME/valley of riches/My Notes/"
personalfolder="$HOME/valley of riches/Notes/"
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

schoolnewnote() {
    name=$(rofiprompt "Name: ")
    [ -z "$name" ] && name=$(date +%F_%T | tr ':' '-')
    setsid -f wezterm start -- nvim "$schoolfolder/$name".md >/dev/null 2>&1
}

personalnewnote() {
    name=$(rofiprompt "Name: ")
    [ -z "$name" ] && name=$(date +%F_%T | tr ':' '-')
    setsid -f wezterm start -- nvim "$personalfolder/$name".md >/dev/null 2>&1
}

sync() {
    sshpass -p "$SSHPASSWORD" rsync -rtu "$HOME/valley of riches/" butterfly:/mnt/HD/HD_a2/butterfly/valley\ of\ riches/ && \
    sshpass -p "$SSHPASSWORD" rsync -rtu butterfly:/mnt/HD/HD_a2/butterfly/valley\ of\ riches/ "$HOME/valley of riches/" && \
    notify-send "Finished sync with butterfly!"
}

search_school() {
    local choice=$(find "$schoolfolder" -name "*.md" -type f | sed "s|^${schoolfolder}||" | rofiprompt "Search School Notes:")

    if [ -n "$choice" ]; then
        setsid -f wezterm start -- nvim "${schoolfolder}${choice}" >/dev/null 2>&1
    fi
}

search_personal() {
    local choice=$(find "$personalfolder" -name "*.md" -type f | sed "s|^${personalfolder}||" | rofiprompt "Search Personal Notes:")
    if [ -n "$choice" ]; then
        setsid -f wezterm start -- nvim "${personalfolder}${choice}" >/dev/null 2>&1
    fi
}


selected() {
    allnotes=$( (ls -t1 "$personalfolder"; ls -t1 "$schoolfolder") | sort -r | uniq )
    choice=$(printf "󰎞 NEW SCHOOL NOTE\n󰎞 NEW PERSONAL NOTE\n SEARCH PERSONAL NOTES\n SEARCH SCHOOL NOTES\n SYNC TO BUTTERFLY\n%s\n" | rofiprompt "Notes menu:")

    case $choice in
        " SYNC TO BUTTERFLY") sync ;;
        "󰎞 NEW SCHOOL NOTE") schoolnewnote ;;
        "󰎞 NEW PERSONAL NOTE") personalnewnote ;;
        " SEARCH PERSONAL NOTES") search_personal ;;
        " SEARCH SCHOOL NOTES") search_school ;;
        *.md)
            if [ -f "$personalfolder/$choice" ]; then
                setsid -f wezterm start -- nvim "$personalfolder/$choice" >/dev/null 2>&1
            elif [ -f "$schoolfolder/$choice" ]; then
                setsid -f wezterm start -- nvim "$schoolfolder/$choice" >/dev/null 2>&1
            fi
            ;;
        *) exit ;;
    esac
}

selected
