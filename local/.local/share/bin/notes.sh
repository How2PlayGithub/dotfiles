#!/bin/sh

# --- CONFIGURATION ---
# The root of your new vault structure
mainvault="$HOME/valley of riches/"

personalfolder="${mainvault}/Notes/"
knowledgefolder="${mainvault}/02 - Knowledge/"

SSHPASSWORD="$(pass ssh/butterfly)"

# --- SCRIPT SETUP ---
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

# --- HELPER FUNCTIONS ---
rofiprompt() {
    rofi -dmenu \
         -theme-str "$r_scale" \
         -theme-str "$r_override" \
         -theme-str "$i_override" \
         -config "$roconf" \
         -p "$1"
}

# --- CORE FUNCTIONS ---
knowledgenewnote() {
    local subjects=$(find "$knowledgefolder" -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
    local subject_choice=$(printf "%s" "$subjects" | rofiprompt "Subject: ")

    [ -z "$subject_choice" ] && exit 0

    local subject_path="${knowledgefolder}/${subject_choice}"

    local name=$(rofiprompt "Name: ")
    [ -z "$name" ] && name=$(date +%F_%T | tr ':' '-')

    setsid -f wezterm start -- nvim "${subject_path}/${name}.md" >/dev/null 2>&1
}

personalnewnote() {
    local name=$(rofiprompt "Name: ")
    [ -z "$name" ] && name=$(date +%F_%T | tr ':' '-')
    setsid -f wezterm start -- nvim "$personalfolder/$name".md >/dev/null 2>&1
}

sync() {
    sshpass -p "$SSHPASSWORD" rsync -rtu "$mainvault" butterfly:/mnt/HD/HD_a2/butterfly/valley\ of\ riches/ && \
    sshpass -p "$SSHPASSWORD" rsync -rtu butterfly:/mnt/HD/HD_a2/butterfly/valley\ of\ riches/ "$mainvault" && \
    notify-send "Finished sync with butterfly!"
}

search_knowledge() {
    local choice=$(find "$knowledgefolder" -name "*.md" -type f | sed "s|^${knowledgefolder}||" | rofiprompt "Search Knowledge:")

    if [ -n "$choice" ]; then
        setsid -f wezterm start -- nvim "${knowledgefolder}${choice}" >/dev/null 2>&1
    fi
}

search_personal() {
    local choice=$(find "$personalfolder" -name "*.md" -type f | sed "s|^${personalfolder}||" | rofiprompt "Search Personal Notes:")
    if [ -n "$choice" ]; then
        setsid -f wezterm start -- nvim "${personalfolder}${choice}" >/dev/null 2>&1
    fi
}

# --- MAIN MENU ---
selected() {
    local choice=$(printf "󰎞 NEW KNOWLEDGE NOTE\n󰎞 NEW PERSONAL NOTE\n SEARCH KNOWLEDGE NOTES\n SEARCH PERSONAL NOTES\n SYNC TO BUTTERFLY\n" | rofiprompt "Notes menu:")

    case $choice in
        " SYNC TO BUTTERFLY") sync ;;
        "󰎞 NEW KNOWLEDGE NOTE") knowledgenewnote ;;
        "󰎞 NEW PERSONAL NOTE") personalnewnote ;;
        " SEARCH KNOWLEDGE NOTES") search_knowledge ;;
        " SEARCH PERSONAL NOTES") search_personal ;;
        *) exit ;;
    esac
}

selected
