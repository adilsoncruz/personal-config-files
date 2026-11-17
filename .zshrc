# =========================================
# ZSH - macOS Development Environment
# =========================================

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# Zsh
setopt AUTO_CD
setopt CORRECT
setopt INTERACTIVE_COMMENTS

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# =========================================
# Aliases
# =========================================

alias c='clear'
alias ll='ls -lah'
alias la='ls -A'

alias ..='cd ..'
alias ...='cd ../..'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gch='git checkout'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'

# GitHub
alias ghpr='gh pr'
alias ghi='gh issue'

# Node
alias ni='npm install'
alias nr='npm run'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'

# Python
alias py='python3'

# Go
alias gor='go run'
alias gob='go build'
alias got='go test'

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'

# Colima
alias colima-start='colima start'
alias colima-stop='colima stop'
alias colima-status='colima status'

# Ollama
alias oi='ollama list'
alias or='ollama run'
alias op='ollama ps'

# =========================================
# Mise
# =========================================

command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

# =========================================
# Starship
# =========================================

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# =========================================
# OmniRoute + codex-cli
# =========================================

codex-auto() {
  if ! curl -s --max-time 1 http://localhost:20128/health >/dev/null 2>&1; then
    echo "🚀 Iniciando OmniRoute..."
    omniroute serve --daemon
  fi

  echo "⏳ Verificando OmniRoute..."

  for i in {1..20}; do
    if curl -s --max-time 1 http://localhost:20128/health >/dev/null 2>&1; then
      echo "✅ OmniRoute está pronto."
      omniroute launch-codex --model codex-fallback-free
      return
    fi

    sleep 0.5
  done

  echo "❌ OmniRoute não ficou disponível."
  return 1
}

local-ai() {
  echo "🧠 Preparando ambiente de IA local..."

  # 1. Colima
  if ! colima status 2>&1 | grep -q "is running"; then
    echo "🚀 Iniciando Colima..."
    colima start

    if [ $? -ne 0 ]; then
      echo "❌ Falha ao iniciar o Colima."
      return 1
    fi
  else
    echo "✅ Colima já está rodando."
  fi

  # 2. Ollama
  if ! curl -s --max-time 2 http://localhost:11434/api/tags >/dev/null 2>&1; then
    echo "🚀 Iniciando Ollama..."
    ollama serve >/tmp/ollama.log 2>&1 &

    echo "⏳ Aguardando Ollama..."

    for i in {1..20}; do
      if curl -s --max-time 1 http://localhost:11434/api/tags >/dev/null 2>&1; then
        break
      fi
      sleep 0.5
    done
  else
    echo "✅ Ollama já está rodando."
  fi

  # 3. Verifica se o modelo existe
  if ! ollama list | grep -q "devstral-32k"; then
    echo "❌ Modelo devstral-32k não encontrado."
    return 1
  fi

  # 4. Pré-carrega o modelo
  echo "🔥 Carregando Devstral 32k..."

  curl -s http://localhost:11434/api/generate \
    -H 'Content-Type: application/json' \
    -d '{
      "model": "devstral-32k:latest",
      "prompt": "OK",
      "stream": false,
      "keep_alive": "30m"
    }' >/dev/null

  echo "✅ Devstral 32k pronto."
  ollama ps
}

# Unity CLI (if installed)
[ -f "$HOME/.unity/env" ] && . "$HOME/.unity/env"

# Local machine secrets (API keys, tokens — never committed to git)
[ -f "$HOME/.zshrc.local" ] && . "$HOME/.zshrc.local"
