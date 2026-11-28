# ==============================================================================
# Modern Developer & Cloud Aliases (macOS / Kiri / Git / AI)
# ==============================================================================

# Git Shortcuts
alias g="git"
alias gst="git status"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gaa="git add -A"
alias gcm="git commit -m"
alias glog="git log --oneline --decorate --graph -n 15"
alias gdiff="git diff"
alias gpull="git pull"
alias gpush="git push"

# Kiri & Container Operations (replaces Colima / Docker commands)
alias dps="kiri ps"
alias dimg="kiri images"
alias dstop="kiri stop \$(kiri ps -q) 2>/dev/null || true"
alias dclean="kiri rm \$(kiri ps -qa -f status=exited) 2>/dev/null || true"

# Orca & AI Tooling
alias oshare="orca-share"
alias osand="orca-sandbox"
alias ask="ask"

# macOS Native Clipboard & Convenience
alias copy="pbcopy"
alias paste="pbpaste"
alias ez="code ~/.zshrc || nano ~/.zshrc"
alias reload="source ~/.zshrc && echo '✓ zshrc reloaded'"
