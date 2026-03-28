#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Fastfetch system info on terminal startup

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/gh0st/.lmstudio/bin"
# End of LM Studio CLI section

export PATH="$HOME/.local/bin:$PATH"

# ============================================================================
# WORKFLOW OPTIMIZATION - Enhanced Configuration
# ============================================================================

# ----------------------------------------------------------------------------
# Color Definitions (matching Sway aesthetic)
# ----------------------------------------------------------------------------
COLOR_RESET='\[\033[0m\]'
COLOR_PURPLE='\[\033[38;2;172;130;233m\]'  # #AC82E9
COLOR_BEIGE='\[\033[38;2;216;202;184m\]'    # #d8cab8
COLOR_LAVENDER='\[\033[38;2;143;86;225m\]'  # #8f56e1
COLOR_GREEN='\[\033[38;2;196;232;129m\]'    # #c4e881

# ----------------------------------------------------------------------------
# Git-Aware Prompt
# ----------------------------------------------------------------------------
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="${COLOR_PURPLE}[\u@\h${COLOR_RESET} ${COLOR_BEIGE}\W${COLOR_RESET}${COLOR_LAVENDER}\$(parse_git_branch)${COLOR_RESET}${COLOR_PURPLE}]${COLOR_RESET}\$ "

# ----------------------------------------------------------------------------
# Python Environment
# ----------------------------------------------------------------------------
export PYTHONDONTWRITEBYTECODE=1
export PYTHONPATH="$HOME/python-projects:$PYTHONPATH"

# Create and activate Python virtual environment
pyenv() {
    python -m venv .venv
    source .venv/bin/activate
    pip install --upgrade pip
}

# Activate existing virtual environment
pyact() {
    source .venv/bin/activate 2>/dev/null || source venv/bin/activate 2>/dev/null || echo "No venv found"
}

# ----------------------------------------------------------------------------
# Rust Environment
# ----------------------------------------------------------------------------
export CARGO_TARGET_DIR="$HOME/.cargo/target"
export RUSTFLAGS="-C target-cpu=native"

# ----------------------------------------------------------------------------
# Git Shortcuts
# ----------------------------------------------------------------------------
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gst='git status -sb'
alias lg='lazygit'

# Git commit with timestamp
gcnow() {
    git add .
    git commit -m "${*:-Update $(date +'%Y-%m-%d %H:%M')}"
}

# ----------------------------------------------------------------------------
# Modern CLI Tool Replacements
# ----------------------------------------------------------------------------
# Uncomment these if you install the tools (see plan Phase 9)
# alias cat='bat'
# alias ls='exa --icons --git'
# alias ll='exa -lah --icons --git'
# alias tree='exa --tree --icons'
# alias grep='rg'
# alias find='fd'
# alias ps='procs'
# alias man='tldr'

# ----------------------------------------------------------------------------
# Workflow Shortcuts
# ----------------------------------------------------------------------------
alias obs='obsidian "$HOME/University of Idaho" &'
alias vault='cd "$HOME/University of Idaho"'
alias rsilv='rstudio "$HOME/University of Idaho/Programming Examples/silviculture_stand_density.R" &'

# Gaming mode shortcuts
alias game-on='gaming-mode on'
alias game-off='gaming-mode off'

# Documentation and help
alias docs='zeal &'
alias doc='zeal --query'

# System backup shortcuts
alias backup-dots='backup-dotfiles'
alias sync='sync-vault'

# ----------------------------------------------------------------------------
# Cargo Shortcuts
# ----------------------------------------------------------------------------
alias cb='cargo build'
alias cr='cargo run'
alias ct='cargo test'
alias cc='cargo clippy'
alias cu='cargo update'

# Quick Rust project with common dependencies
cnew() {
    local name="$1"
    if [ -z "$name" ]; then
        echo "Usage: cnew <project-name>"
        return 1
    fi
    cargo new "$name"
    cd "$name" || return
    cargo add anyhow thiserror clap --features derive
    cargo add serde --features derive
    echo "Rust project '$name' created with common dependencies"
}

# ----------------------------------------------------------------------------
# R Shortcuts
# ----------------------------------------------------------------------------
# R package management helper
rinstall() {
    R -e "install.packages('$1', repos='https://cloud.r-project.org')"
}

# Quick R REPL with tidyverse preloaded
alias rt='R --quiet --no-save -e "library(tidyverse)"'

# ----------------------------------------------------------------------------
# SQL Shortcuts
# ----------------------------------------------------------------------------
alias sqlc='litecli'
alias pgc='pgcli'

# ----------------------------------------------------------------------------
# Navigation Helpers
# ----------------------------------------------------------------------------
# Quick cd to course directory
course() {
    local course_name="$1"
    if [ -z "$course_name" ]; then
        echo "Usage: course <COURSE_CODE>"
        echo "Available courses in: $HOME/University of Idaho/"
        ls "$HOME/University of Idaho/" | grep -E '^[A-Z]{3}[0-9]{4}'
        return 1
    fi
    cd "$HOME/University of Idaho/$course_name" 2>/dev/null || cd "$HOME/University of Idaho" || echo "Course not found"
}

# Quick note to Obsidian
note() {
    local title="$*"
    if [ -z "$title" ]; then
        title="Quick Note $(date +'%Y-%m-%d %H:%M')"
    fi
    obsidian "obsidian://new?vault=University%20of%20Idaho&name=${title// /%20}" &
}

# ----------------------------------------------------------------------------
# System Information
# ----------------------------------------------------------------------------
sysinfo() {
    echo "━━━ System Information ━━━"
    echo "Uptime: $(uptime -p)"
    echo "CPU: $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
    echo "RAM: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    if command -v nvidia-smi &> /dev/null; then
        echo "GPU: $(nvidia-smi --query-gpu=name --format=csv,noheader)"
    fi
    echo ""
    echo "Display Server: Wayland (Sway)"
    echo "Shell: $(basename $SHELL)"
}

# ----------------------------------------------------------------------------
# Safe System Update Workflow
# ----------------------------------------------------------------------------
safe-update() {
    echo "=== EndeavourOS Safe Update Workflow ==="
    echo ""

    # 1. Backup configs
    echo "Step 1: Backing up dotfiles..."
    if command -v backup-dotfiles &> /dev/null; then
        backup-dotfiles
    else
        echo "Warning: backup-dotfiles script not found (will create in Phase 7)"
    fi

    # 2. Check for news
    echo ""
    echo "Step 2: Checking Arch news..."
    echo "Visit: https://archlinux.org/news/"
    read -p "Any manual interventions needed? (y/N): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo "Handle manual interventions first, then re-run safe-update"
        return 1
    fi

    # 3. Create snapshot
    echo ""
    echo "Step 3: Creating Timeshift snapshot..."
    if command -v timeshift &> /dev/null; then
        sudo timeshift --create --comments "Pre-update $(date +%Y-%m-%d)"
    else
        echo "Warning: Timeshift not installed. Consider installing for safety."
        read -p "Continue without snapshot? (y/N): " response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            return 1
        fi
    fi

    # 4. Update mirrors (optional)
    echo ""
    read -p "Update mirrors for faster downloads? (y/N): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        sudo reflector --country US --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
    fi

    # 5. Perform update
    echo ""
    echo "Step 4: Updating system..."
    sudo pacman -Syu

    # 6. Check for orphans
    echo ""
    echo "Step 5: Checking for orphaned packages..."
    ORPHANS=$(pacman -Qdtq)
    if [ -n "$ORPHANS" ]; then
        echo "Orphaned packages found:"
        echo "$ORPHANS"
        read -p "Remove orphans? (y/N): " response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            pacman -Qdtq | sudo pacman -Rns -
        fi
    else
        echo "No orphans found"
    fi

    # 7. Check for .pacnew files
    echo ""
    echo "Step 6: Checking for .pacnew files..."
    PACNEW=$(find /etc -name "*.pacnew" 2>/dev/null)
    if [ -n "$PACNEW" ]; then
        echo "Found .pacnew files:"
        echo "$PACNEW"
        echo "Review with: sudo nvim /path/to/file.pacnew"
    fi

    echo ""
    echo "=== Update Complete ==="
    echo "Reboot if kernel was updated"
    echo "If issues occur: sudo timeshift --restore"
}

# Alias for traditional pacman update (with reminder)
alias pacupdate='echo "Tip: Use safe-update for safer system updates" && sudo pacman -Syu'

# ----------------------------------------------------------------------------
# FZF Configuration (if installed)
# ----------------------------------------------------------------------------
if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_DEFAULT_OPTS="
        --color=bg:#16130b,bg+:#221f17,fg:#e9e2d4,fg+:#e9e2d4
        --color=hl:#ddc66e,hl+:#ddc66e,info:#4b4739,marker:#aad0b2
        --color=prompt:#ddc66e,spinner:#cec7ac,pointer:#ddc66e
        --color=header:#4b4739,border:#4b4739,label:#cec7ac
        --layout=reverse --border
    "

    # Source FZF keybindings if available
    [ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
    [ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
fi

# ----------------------------------------------------------------------------
# Zoxide (smart cd) - if installed
# ----------------------------------------------------------------------------
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
    alias cd='z'
fi

# ----------------------------------------------------------------------------
# Starship Prompt (alternative to custom PS1, if installed)
# ----------------------------------------------------------------------------
# Uncomment if you prefer Starship prompt over the custom one above
# if command -v starship &> /dev/null; then
#     eval "$(starship init bash)"
# fi

# ============================================================================
# END OF WORKFLOW OPTIMIZATION
# ============================================================================
# ============================================================================
# TERMINAL FUN & ANIMATIONS - Added by Claude
# ============================================================================

# ----------------------------------------------------------------------------
# Terminal startup — animated GIF then system info
# ----------------------------------------------------------------------------
if command -v fastfetch &> /dev/null; then
    _gif=$(find ~/Pictures/gifs -maxdepth 1 -type f -name "*.gif" 2>/dev/null | shuf -n1)
    if [[ -n "$_gif" ]]; then
        kitten icat --loop 0 --place 38x22@1x1 "$_gif" 2>/dev/null
    fi
    fastfetch 2>/dev/null
    printf '\033[0m'
    unset _gif
fi
# ----------------------------------------------------------------------------
# Fun Terminal Aliases
# ----------------------------------------------------------------------------
# Matrix screensaver (purple theme!)
alias matrix='cmatrix -C magenta -u 8 -b'
alias matrix-green='cmatrix -C green -u 8 -b'

# Growing bonsai tree
alias bonsai='cbonsai -l -t 0.5 -m "Press Ctrl+C to exit"'
alias bonsai-fast='cbonsai -l -t 0.1'

# Animated pipes screensaver
alias pipes='pipes.sh -p 5 -R -r 0'
alias pipes-crazy='pipes.sh -p 10 -R -r 10000'

# Audio visualizer
alias visualizer='cava'
alias viz='cava'

# Cowsay removed - pure cyberpunk vibes only 🔥

# Display random anime image (if you have images in ~/Pictures/anime/)
alias anime='chafa $(ls ~/Pictures/anime/*.{png,jpg,gif} 2>/dev/null | shuf -n1) --size 80x40 2>/dev/null || echo "Add anime images to ~/Pictures/anime/"'

# ============================================================================
# END OF TERMINAL FUN
# ============================================================================

# ═══════════════════════════════════════════════════════════════════
# PURPLE CYBERPUNK TERMINAL SETUP
# ═══════════════════════════════════════════════════════════════════

# Starship prompt
eval "$(starship init bash)"


# Better CLI tools (colorful replacements)
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias lt='eza --tree --icons'
alias cat='bat'
alias top='btop'

# Quick cava launcher
alias musik='cava -p ~/.config/cava/config'

# ═══════════════════════════════════════════════════════════════════

export EDITOR="code --wait"

# Tmux — attach to 'main' session or create it
alias t='tmux new-session -A -s main'

# Vault navigation shortcuts
source ~/.bashrc_vault_shortcuts

# Quick temp readout in Fahrenheit
alias temps='sensors -f | grep -E "Tctl|Tccd|CPUTIN|SYSTIN|fan" '
