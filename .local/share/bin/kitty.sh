#!/bin/bash

kitty --title "kitty" -e bash --rcfile <(cat <<'EOF'

echo -ne "\033]0;kitty\007"

trap 'echo -ne "\033]0;kitty - $BASH_COMMAND\007"' DEBUG

PROMPT_COMMAND='echo -ne "\033]0;kitty\007"'
EOF
)

