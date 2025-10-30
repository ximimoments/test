#!/usr/bin/env bash
# katifetch_kalloween.sh - Katifetch Kalloween Edition (Linux-only)
# by kati dev (github.com/ximimoments)
# Purpose: Halloween-themed Katifetch for Linux terminals
# Features: ASCII pumpkin logo, spooky phrases, colors (orange/red/purple)
# Usage: bash katifetch_kalloween.sh [--install] [--no-logo] [--no-color]

set -u

PROGNAME="katifetch_kalloween"
VERSION="1.0"
INSTALL_PATH="/usr/local/bin/$PROGNAME"

# Flags
SHOW_LOGO=1
USE_COLOR=1

# Colors (correct Bash escapes)
ORANGE=$'\033[0;33m'
RED=$'\033[0;31m'
PURPLE=$'\033[0;35m'
BOLD=$'\033[1m'
RESET=$'\033[0m'

# Auto width detection
auto_detect_tty_width() {
  if [ -n "${COLUMNS:-}" ]; then
    echo "$COLUMNS"
  else
    tput cols 2>/dev/null || echo 80
  fi
}

# System info helpers
get_distro() {
  if command -v lsb_release >/dev/null 2>&1; then
    lsb_release -ds | tr -d '"'
  elif [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "${PRETTY_NAME:-$NAME $VERSION_ID}"
  else
    echo "Unknown Linux"
  fi
}

get_kernel() { uname -srmo 2>/dev/null || uname -sr 2>/dev/null; }
get_uptime() {
  if [ -r /proc/uptime ]; then
    awk '{printf "%d days, %02d:%02d", $1/86400, ($1%86400)/3600, ($1%3600)/60}' /proc/uptime
  else
    uptime -p 2>/dev/null || echo "unknown"
  fi
}
get_shell() { echo "${SHELL:-$(basename "$(ps -p $$ -o comm=)")}" ; }
get_terminal() { echo "${TERM:-unknown}" ; }
get_packages() {
  if command -v dpkg >/dev/null 2>&1; then
    dpkg --list | wc -l
  elif command -v rpm >/dev/null 2>&1; then
    rpm -qa | wc -l
  else
    echo "n/a"
  fi
}
get_cpu() {
  awk -F: '/model name/{print $2; exit}' /proc/cpuinfo 2>/dev/null | sed 's/^ *//'
}
get_mem() {
  free -h | awk '/^Mem:/{print $3 " / " $2; exit}'
}
get_disk() {
  df -h --output=size,used,avail / 2>/dev/null | sed -n '2p'
}

# Spooky phrases
PHRASES=(
  "Your system awakens from the digital grave..."
  "Haunted by ghost processes..."
  "Running on pure nightmare fuel..."
  "Beware: spooky cronjobs nearby..."
  "The kernel whispers in the dark..."
  "Patch the crypt — update your packages..."
  "A ghost in /var/log laughs softly..."
)
random_phrase() {
  local i=$((RANDOM % ${#PHRASES[@]}))
  echo "${PHRASES[$i]}"
}

# ASCII pumpkin
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

center_text() {
  local text="$1" width="$2"
  local len=${#text}
  if (( len >= width )); then
    echo "$text"
  else
    local pad=$(( (width - len) / 2 ))
    printf "%*s%s\n" "$pad" "" "$text"
  fi
}

print_info() {
  local width
  width=$(auto_detect_tty_width)

  local distro kernel uptime shell term pkgs cpu mem disk
  distro="$(get_distro)"
  kernel="$(get_kernel)"
  uptime="$(get_uptime)"
  shell="$(get_shell)"
  term="$(get_terminal)"
  pkgs="$(get_packages)"
  cpu="$(get_cpu)"
  mem="$(get_mem)"
  disk="$(get_disk)"

  local info_lines=(
    "${BOLD}KATIFETCH KALLOWEEN EDITION${RESET}"
    ""
    "${BOLD}Distro:${RESET} $distro"
    "${BOLD}Kernel:${RESET} $kernel"
    "${BOLD}Uptime:${RESET} $uptime"
    "${BOLD}Shell:${RESET} $shell"
    "${BOLD}Terminal:${RESET} $term"
    "${BOLD}Packages:${RESET} $pkgs"
    "${BOLD}CPU:${RESET} $cpu"
    "${BOLD}Memory:${RESET} $mem"
    "${BOLD}Disk:${RESET} $disk"
  )

  local max_lines=${#PUMPKIN[@]}
  (( ${#info_lines[@]} > max_lines )) && max_lines=${#info_lines[@]}

  for ((i=0; i<max_lines; i++)); do
    local left="${PUMPKIN[$i]}"
    local right="${info_lines[$i]}"
    [ -z "$left" ] && left=""
    [ -z "$right" ] && right=""
    printf "${ORANGE}%s${RESET}   %s\n" "$left" "$right"
  done
  echo
  echo "${PURPLE}${BOLD}$(random_phrase)${RESET}"
}

main() {
  clear
  print_info
}

main
