alias grep='grep --color=auto'

abbr --add iapp 'sudo pacman -S'

abbr --add gstat 'git status'
abbr --add ga 'git add'
abbr --add gc --set-cursor 'git commit -m "%"'
abbr --add gac --set-cursor 'git add . && git commit -m "%"'
abbr --add gp 'git push'
abbr --add gpull 'git pull'

alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
