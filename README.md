# dotfiles

Personal configuration files for waifu-destroyer (EndeavourOS/Arch Linux)

## System Info

- OS: EndeavourOS (Arch Linux)
- WM: Sway (swayfx)
- Bar: Waybar
- Terminal: Kitty
- File Manager: Yazi
- System Monitor: btop
- Fetch: fastfetch

## Structure

```
dotfiles/
├── .config/           # Application configs
│   ├── sway/         # Sway window manager
│   ├── waybar/       # Status bar
│   ├── kitty/        # Terminal emulator
│   ├── yazi/         # File manager
│   ├── btop/         # System monitor
│   └── fastfetch/    # System info fetch
├── scripts/          # All scripts from ~/.local/bin/
├── home/             # Home directory dotfiles
│   ├── .bashrc
│   ├── .gitconfig
│   └── .gtkrc-2.0
└── README.md
```

## Installation

### Quick Install (Fresh System)

```bash
# Clone this repo
git clone git@github.com:tyrant-svg/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Backup existing configs (optional)
mkdir -p ~/.config-backup
cp -r ~/.config/* ~/.config-backup/

# Install configs
cp -r .config/* ~/.config/
cp home/.bashrc ~/.bashrc
cp home/.gitconfig ~/.gitconfig
cp home/.gtkrc-2.0 ~/.gtkrc-2.0

# Install scripts
mkdir -p ~/.local/bin
cp scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

# Reload configs
swaymsg reload  # or restart Sway
```

### Manual Installation

Pick and choose what you want:

```bash
# Just Sway config
cp .config/sway/* ~/.config/sway/

# Just Waybar config
cp .config/waybar/* ~/.config/waybar/

# Just specific scripts
cp scripts/script-name ~/.local/bin/
```

## Requirements

### Packages

```bash
# Window manager
sudo pacman -S sway swaybg swaylock swayidle

# Bar and widgets
sudo pacman -S waybar

# Terminal and tools
sudo pacman -S kitty yazi btop fastfetch

# Additional dependencies
sudo pacman -S grim slurp wl-clipboard wofi
```

### AUR Packages

```bash
yay -S swayfx          # Enhanced Sway with blur/shadows
yay -S yazi            # Modern file manager
```

## Key Features

- Cyberpunk purple/cyan color scheme
- Three-monitor setup optimized
- Gaming-optimized window rules
- NVIDIA GPU performance scripts
- Tailscale VPN integration
- Custom keybindings for efficiency

## Notes

- Sway config includes NVIDIA-specific settings
- Scripts assume EndeavourOS/Arch package names
- Some scripts require sudo access (configured with NOPASSWD)
- Modify paths in scripts if your setup differs

## Updating Dotfiles

```bash
cd ~/dotfiles
./setup-dotfiles.sh    # Re-sync from system
git add .
git commit -m "Update configs"
git push
```

## Credits

- Sway/Waybar configs: Custom
- Color scheme: Cyberpunk inspired
- Scripts: Self-written automation

## License

MIT - Do whatever you want with these configs
