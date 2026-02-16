#!/bin/bash
set -e

echo "Setting up dotfiles structure..."

# Create directory structure
mkdir -p .config/{sway,waybar,kitty,yazi,btop,fastfetch}
mkdir -p scripts
mkdir -p home

# Copy configs
echo "Copying configs..."
cp -r ~/.config/sway/* .config/sway/
cp -r ~/.config/waybar/* .config/waybar/
cp -r ~/.config/kitty/* .config/kitty/
cp -r ~/.config/yazi/* .config/yazi/
cp -r ~/.config/btop/* .config/btop/
cp -r ~/.config/fastfetch/* .config/fastfetch/

# Copy scripts (all of them)
echo "Copying scripts..."
cp ~/.local/bin/* scripts/ 2>/dev/null || true

# Copy home dotfiles
echo "Copying home dotfiles..."
cp ~/.bashrc home/
cp ~/.gitconfig home/
cp ~/.gtkrc-2.0 home/

echo "Done! Structure created."
