#aliases for Tmux
alias tmux='tmux -2'
alias ta='tmux attach -t'
alias tnew='tmux new -s'
alias tls='tmux ls'
alias tkill='tmux kill-session -t'

# convenience aliases for editing configs
alias ev='vim ~/.vimrc'
alias et='vim ~/.tmux.conf'
alias ez='vim ~/.zshrc'

# xclip aliases
alias cs='xclip -selection clipboard'

# docker remove exited containers
alias docrme='docker rm -v $(docker ps -qa -f status=exited)'

# docker pause and remove 
alias docsr='docker rm $(docker stop $(docker ps -q))'
