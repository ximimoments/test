#!/usr/bin/env bash
# katifetchkallowen.sh - Katifetch Kallowen Edition (Linux-only)
# by kati dev (github.com/ximimoments)
# Purpose: Single-file Halloween-themed katifetch for Linux terminals.
# Features: ASCII pumpkin logo, spooky phrases, basic system detection,
# colors (orange/red/purple), --install to copy to /usr/local/bin
# Usage: bash katifetchkallowen.sh [--install] [--no-logo] [--no-color]
set u
PROGNAME="katifetchkallowen"
VERSION="1.0"
INSTALL_PATH="/usr/local/bin/$PROGNAME"
# Default flags
SHOW_LOGO=1
USE_COLOR=1
# auto_detect_tty_width() {
  local w
  if [ -n "${COLUMNS:-}" ]; then
    w=$COLUMNS
   else
    w=$(tput cols 2>/dev/null || echo 80)
   fi
   echo $w
 }

# Colors
if [ "$USE_COLOR" -eq 1 ] 2>/dev/null; then
   :
fi

ORANGE='\033[0;33m' # yellow/orange-ish
RED='\033[0;31m'
PURPLE='\033[0;35m'
BOLD='\033[1m'
RESET='\033[0m'

# Parse args
for arg in "$@"; do
  case "$arg" in
    --no-logo) SHOW_LOGO=0 ;;
    --no-color) USE_COLOR=0 ;;
    --install)
    #Self-install
    if [ "$($id -u)" -ne 0]; then
    echo "Running installer: requesting sudo to install to $INSTALL_PATH"
    if command -v sudo >/dev/null 2>1; then
     sudo cp "0" "$INSTALL_PATH" && chmod +x "$INSTALL_PATH" && echo "Installed to $INSTALL_PATH" || echo "Install failed"
   fi
   exit 0
   ;;
  --help|-h)
  cat <<EOF
$PROGNAME $VERSION - Katifetch Kalloween Edition
Usage: bash $PROGNAME.sh [--install] [--no-logo] [--no-color] [--help]
   --install  Install $PROGNAME to $INSTALL_PATH (requires root)
   --no-logo  Hide the Halloween ASCII logo
   --no-color  Disable colored output
EOF
   exit 0
   ;;
  *) : ;;
  esac
 Done

# If user passed --no-color earlier, override color variables
if ["$USE_COLOR" -eq 0]; then
  ORANGE=''; RED=''; PURPLE=''; BOLD=''; RESET=''
fi

#Helpers to fetch system info (robust across distros)
get_distro () {
    if command -v lsb_release >/dev/null 2>1; then
     lsb_release -ds | tr -d '"'
     elif [-f /etc/os-release ]; then
     . /etc/os-release
     echo "${PRETTY_NAME:-$NAME ${VERSION_ID:-}}
     elif [-f /etc/lsb-release ]; then
     . /etc/lsb/release
     echo "${DISTRIB_DESCRIPTION:-$DISTRIB_ID $DISTRIB_RELEASE}"
    else
     echo "Unknown Linux"
    fi
   }

get_kernel() { unamme -srmo 2>/dev/null || uname -sr 2>/dev/null; }
get_uptime() {
   if [ -r /proc/uptime ]; then
    awk '{printf "%d days, %02d:%02d", $1/86400, ($1/86400)/3600, ($1%3600)/60}' /proc/uptime
   else
    uptime  -p 2>/dev/null || echo "unknown"
   fi
  }
  get_shell() {echo ${Shell:-$(basename "$(ps -p $$ -o comm=)")}}
  get_terminal() { echo ${SHELL:-unknown}; }
  get_packages() {
    if cpmmand -v dpkg >/dev/null 2>&1; then
     dpkg --list >/dev/null | wc -1
    elif command -v rpm >/dev/null 2>&1; then
     rpm -qa 2 >/dev/null | wc -1
    else
     echo "n/a"
    fi
}
get_cpu() {
if [ -f /proc/cpuinfo ]; then
awk -F: '/model name/{print $2; exit}' /proc/cpuinfo | sed 's/^ *//'
else
lscpu 2>/dev/null | awk -F: '/Model name/{print $2; exit}' | sed 's/^ *//'
fi
}
get_mem() {
 if command -v free >/dev/null 2>&1; then
  free -h | awk '/^Mem:/{print $3  "  /  " $2; exit}'
  elif [ -r /Proc/meminfo ]; then
  awk '/Memtotal/{my=$2}/MemAvailable/{ma=$2}END{if(mt && ma)printf("%s  /  %s", mt/1024 " KiB", ma/1024 " KiB");}' /proc/meminfo
 else
  echo "n/a"
 fi
}
get_disk() {
  df -h--output=source,size,used,avail,taget -x tmpfs -x devtmpfs 2>/dev/null | sed -n '2p' || df -h | sed -n  '2p' || echo "n/a"
}

#Spooky phrases
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
local i n
n=${#PHRASES[@]}
i=$((RANDOM % n))
echo "${PHRASES[$i]}"
}

#My favorite season, the ascii art
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
                                              
# Center utility (simple)
 center text
  local text="$1"
  local width=$2
  local len=$(echo -n "$text" | wc -c)
  if ["$len"-ge "width" ]; then
   echo "$text"
  else
   local pad=$(( (width - len) / 2 ))
   printf "%*s%s\n" "$pad" "" "$text"
  fi
}

# print info block
print_info () {
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

  # Left
 local logo_w=22
 local info_w=$(( width - logo_w - 4 ))
 if [ "info_w" -lt 30]; then info_w30; fi

# Build info lines
local lines=()
lines+=("${BOLD}KATIFETCH KALLOWEN${RESET}")
lines+=("")
lines+=("${BOLD}Distro:${RESET} ${distro}")
lines+=("${BOLD}Kernel:${RESET} ${kernel}")
lines+=(("${BOLD}Uptime:${RESET} ${uptime}"))
lines+=("${BOLD}Shell:${RESET} ${shell}")
lines+=("${BOLD}Terminal:${RESET} ${term}")
lines+=("${BOLD}Packages:${RESET} ${pkgs}")
lines+=("${BOLD}CPU:${RESET} ${cpu}")
lines+=("${BOLD}Memory:${RESET} ${mem}")
lines+=("${BOLD}Disk:${RESET} ${disk}")


# Compose and print, line by line, aligning logo left and info centered-ish
  local max_lines=${#PUMPKIN[@]}
  if [ ${#lines[@]} -gt $max_lines ]; then max_lines=${#lines[@]}; fi


  for i in $(seq 0 $((max_lines-1))); do
   local lleft=""
   local lright=""
   if [ $i -lt ${#PUMPKIN[@]} ]; then
   lleft="${PUMPKIN[$i]}"
 else
  lleft=""
  fi
  if [ $i -lt ${#lines[@]} ]; then
  lright="${lines[$i]}"
  else
  lright=""
  fi


# Color the logo lines with orange/purple gradient
   if [ "$USE_COLOR" -eq 1 ]; then
    if [ $i -le 2 ]; then
     printf "%s" "${ORANGE}${lleft}${RESET}"
   elif [ $i -le 5 ]; then
    printf "%s" "${PURPLE}${lleft}${RESET}"
  else
   printf "%s" "${RED}${lleft}${RESET}"
  fi
  else
    printf "%s" "$lleft"
  fi

   # Spacer
   printf " "

   # Info (center within info_w)
   if [ -n "$lright ]; then
     #center the right part loosely
     local centered
     centered=$(center_text "$lright" $info_w) 
     printf "%s\n" "$centered"
  else
    printf "\n"
   fi
  Done

  # Header / minimal greeting
 print_header() {
  local w
  w=$(auto_detect_tty_width)
  if [ "$USE_COLOR" -eq 1]; then
   center_text "${BOLD}${ORANGE}KATIFETCH KALLOWEEN EDITION ${RESET}${PURPLE}v$VERSION${RESET}" $w
   else
    center_text "KATIFETCH KALLOWEEN EDITION v$VERSION" $w
    fi
    printf "\n"
   }

   # Main
   Main() {
    print_header
    if [ "$SHOW_LOGO" -eq 1 ]; then
      print_info
    else
      # Just print info bloc without logo, simpler
      local distro kernel uptime shell term pkgs cpu mem disk
      distro="$(get_distro)"
      kernel="$(get_kernel)"
      uptime="$(get_uptime)"
      shell="$(get_shell)"
      term=$(get_terminal)"
      pkgs=$(get_packages)"
      cpu=$(get_cpu)"
      mem=$(get_mem)"
      disk=$(get_disk)"

      echo "Distro: $distro"
      echo "Kernel: $kernel"
      echo "Uptime: $uptime"
      echo "Shell: $shell"
      echo "Terminal: $term"
      echo "Packages: $pkgs"
      echo "CPU: $cpu"
      echo "Memory: $mem"
      echo "Disk: $disk"
      echo
      echo "$(random_phrase)"
    fi
  }

Main

#End of file...