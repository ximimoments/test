#!/usr/bin/env bash

# install.sh - Installer for Katifetch
set -e

# --- Detect Haiku ---
IS_HAIKU=false
if uname | grep -qi "haiku"; then
  IS_HAIKU=true
fi

# --- Define installation directories depending on OS ---
if [ "$IS_HAIKU" = true ]; then
  # Haiku uses non-packaged paths for local software
  INSTALL_DIR="/boot/home/config/non-packaged/bin"
  SHARE_DIR="/boot/home/config/non-packaged/katifetch"
  echo "[Haiku detected] Installing in Haiku paths..."
else
  # Linux default
  INSTALL_DIR="/usr/local/bin"
  SHARE_DIR="/usr/local/share/katifetch"
fi

THEME_DIR="$SHARE_DIR/themes"
LOGO_DIR="$SHARE_DIR/logos"

# Create directories
echo "Creating directories..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$THEME_DIR"
mkdir -p "$LOGO_DIR"

# Copy main script
echo "Installing katifetch..."
cp katifetch.sh "$INSTALL_DIR/katifetch"
chmod +x "$INSTALL_DIR/katifetch"

# Copy themes and logos
echo "Copying themes and logos..."
cp -r themes/* "$THEME_DIR"
cp -r logos/* "$LOGO_DIR"

# Copy or create default config
if [ ! -f "$HOME/.katifetchrc" ]; then
  echo "Installing default configuration to ~/.katifetchrc..."

  if [ -f ".katifetchrc" ]; then
    cp .katifetchrc "$HOME/.katifetchrc"
  else
    cat > "$HOME/.katifetchrc" <<EOF
# Katifetch default configuration
theme=default
show_logo=yes
show_colors=yes
EOF
  fi
fi

echo "Installation complete! Run 'katifetch' to test it."

echo ""
cat << "EOF"
      ___           ___                                                    ___                         ___           ___     
     /  /\         /  /\          ___            ___         ___          /  /\          ___          /  /\         /  /\    
    /  /:/        /  /::\        /__/\          /__/\       /  /\        /  /::\        /__/\        /  /::\       /  /:/    
   /  /:/        /  /:/\:\       \  \:\         \__\:\     /  /::\      /  /:/\:\       \  \:\      /  /:/\:\     /  /:/     
  /  /::\____   /  /::\ \:\       \__\:\        /  /::\   /  /:/\:\    /  /::\ \:\       \__\:\    /  /:/  \:\   /  /::\ ___ 
 /__/:/\:::::\ /__/:/\:\_\:\      /  /::\    __/  /:/\/  /  /::\ \:\  /__/:/\:\ \:\      /  /::\  /__/:/ \  \:\ /__/:/\:\  /\
 \__\/~|:|~~~~ \__\/  \:\/:/     /  /:/\:\  /__/\/:/~~  /__/:/\:\ \:\ \  \:\ \:\_\/     /  /:/\:\ \  \:\  \__\/ \__\/  \:\/:/
    |  |:|          \__\::/     /  /:/__\/  \  \::/     \__\/  \:\_\/  \  \:\ \:\      /  /:/__\/  \  \:\            \__\::/ 
    |  |:|          /  /:/     /__/:/        \  \:\          \  \:\     \  \:\_\/     /__/:/        \  \:\           /  /:/  
    |__|:|         /__/:/      \__\/          \__\/           \__\/      \  \:\       \__\/          \  \:\         /__/:/   
     \__\|         \__\/                                                  \__\/                       \__\/         \__\/    
     Katifetch for Linux / Haiku
EOF
echo ""
