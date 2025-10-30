#!/usr/bin/env bash
# Katifetch Kalloween Edition 🎃
# by kati dev (github.com/ximimoments)

PROGNAME="katifetchkalloween"
VERSION="1.0"
INSTALL_PATH="/usr/local/bin/$PROGNAME"

# === ASCII LOGO ===
PUMPKIN=(
"                  ***                         "
"                  *****                       "
"                    ****                      "
"                     ****                     "
"           ==========****==========           "
"       ================================       "
"     ====================================     "
"    ======================================    "
"   ========================================   "
"  ==========================================  "
"  ============%================%============  "
" ===========%%%%==============%%%%=========== "
" ==========%%%%%%============%%%%%%%========= "
" ====================+%%%==================== "
" ===================*%%%%%=================== "
"  ===============+=====+==========+=========  "
"  =========*%%%%%%%%%%%%%%%%%%%%%%==========  "
"   =========%%%%%%%%%%%%%%%%%%%%%%=========   "
"    =========%%%#%%%%%*=%%%%%=%%%=========    "
"      ==================================      "
"        ==============================        "
"           ========================           "
"                   ========                   "
)

# === RANDOM HALLOWEEN PHRASES ===
PHRASES=(
  "🕯️  Happy Halloween from Kati Dev!"
  "💀 Your system awakens from the digital grave..."
  "🎃 Stay spooky and hack responsibly."
  "👻 Beware of ghost processes in /var/run..."
  "🦇 Night falls, and the kernel stirs..."
  "🕸️  Creeping updates detected..."
  "⚰️  Something dark lurks in /tmp..."
  "🧛 Your CPU thirsts... for power..."
  "🪦 Memory leaks are rising from the dead..."
  "🧙 Summoning bash magic..."
)

random_phrase() {
  local i=$((RANDOM % ${#PHRASES[@]}))
  echo "${PHRASES[$i]}"
}

# === BASIC INFO ===
print_logo() {
  if [ "$NO_LOGO" != "1" ]; then
    for line in "${PUMPKIN[@]}"; do
      echo "$line"
    done
  fi
}

print_info() {
  echo
  echo "KATIFETCH KALLOWEEN EDITION v$VERSION"
  echo "-----------------------------------------------"
  echo "User:      $USER"
  echo "Host:      $(hostname)"
  echo "OS:        $(uname -s)"
  echo "Kernel:    $(uname -r)"
  echo "Shell:     $SHELL"
  echo "Terminal:  $TERM"
  echo "-----------------------------------------------"
  echo
  random_phrase
}

# === HELP / INSTALLER ===
show_help() {
  echo "$PROGNAME $VERSION - Katifetch Kalloween Edition 🎃"
  echo
  echo "Usage: bash $PROGNAME.sh [--install] [--uninstall] [--no-logo] [--help]"
  echo
  echo "  --install     Install $PROGNAME to $INSTALL_PATH (requires root)"
  echo "  --uninstall   Remove $PROGNAME from the system"
  echo "  --no-logo     Hide the Halloween ASCII pumpkin"
  echo "  --help        Show this help message"
}

install_script() {
  echo "Installing $PROGNAME to $INSTALL_PATH..."
  sudo cp "$0" "$INSTALL_PATH"
  sudo chmod +x "$INSTALL_PATH"
  echo "✅ Installed successfully! You can now run: $PROGNAME"
}

uninstall_script() {
  if [ -f "$INSTALL_PATH" ]; then
    echo "Removing $INSTALL_PATH..."
    sudo rm -f "$INSTALL_PATH"
    echo "🗑️  Uninstalled successfully."
  else
    echo "⚠️  $PROGNAME is not installed."
  fi
}

# === ARGUMENT HANDLING ===
for arg in "$@"; do
  case $arg in
    --install) INSTALL=1 ;;
    --uninstall) UNINSTALL=1 ;;
    --no-logo) NO_LOGO=1 ;;
    --help) HELP=1 ;;
    *) ;;
  esac
done

if [ "$HELP" == "1" ]; then
  show_help
  exit 0
fi

if [ "$INSTALL" == "1" ]; then
  install_script
  exit 0
fi

if [ "$UNINSTALL" == "1" ]; then
  uninstall_script
  exit 0
fi

# === MAIN EXECUTION ===
print_logo
print_info
