# Aliases

## Configurar aliases
alias aliasconf='nvim ~/.bash_aliases'
alias aliassource='source ~/.bash_aliases'
alias aliascat='cat ~/.bash_aliases'

## Configurar tmux
alias tsource='tmux source ~/.config/tmux/tmux.conf'
alias tconf='nvim ~/.config/tmux/tmux.conf'

## Comandos do bash
alias ..='cd ..'
alias ~='cd ~'
alias nf='neofetch'
alias wttr='curl http://wttr.in'
alias omp='oh-my-posh'

## git
alias status='git status'
alias pull='git pull'
alias push='git push'
alias commit='git commit'
alias checkout='git checkout'
alias add='git add'
alias restore='git restore'
alias branch='git branch'

## Configurar neovim
alias nvconf=
alias log='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit -10'

# Comandos da Bem
## pnpm
alias pi='rm -rfv node_modules && rm -fv pnpm-lock.yaml && pnpm i'
alias pb='pnpm build'
alias ps='pnpm start'
alias proot='cd ~/projetos/arquitetura/mfe-root-web && tomaster && pi && pb && ps'
alias pe='pnpm test:e2e'

## git
alias tomaster='git checkout master && git reset --hard origin/master && git pull origin master'
