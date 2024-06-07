source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
# export PATH="/usr/local/Cellar/gcc/13.2.0/bin/gcc-13:$PATH"
# ln -sf /usr/local/Cellar/gcc@12/12.3.0/bin/x86_64-apple-darwin23-gcc-12  /usr/local/bin/gcc
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

alias cdbmake="compiledb make"
lima_run(){
    limactl shell default $*
}
alias l="lima_run $@"


alias v="fd --type f --hidden --exclude .git --exclude venv | fzf-tmux -p | xargs nvim"

alias vo="fd --type f --hidden --exclude .git --exclude venv | fzf-tmux -p | xargs open"

alias vp="fd --type f --extension pdf --hidden --exclude .git --exclude venv | fzf-tmux -p | xargs open"

alias tn="tmux new -s"


function fzf_rg(){
    if [ -z "$TMUX" ]; then
        rg --color=always --line-number --no-heading --smart-case "${*:-}" |
          fzf-tmux -p --ansi \
              --color "hl:-1:underline,hl+:-1:underline:reverse" \
              --delimiter : \
              --preview 'bat --color=always {1} --highlight-line {2}' \
              --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
              --bind 'enter:become(nvim {1} +{2})'
    else
        rg --color=always --line-number --no-heading --smart-case "${*:-}" |
          fzf --ansi \
              --color "hl:-1:underline,hl+:-1:underline:reverse" \
              --delimiter : \
              --preview 'bat --color=always {1} --highlight-line {2}' \
              --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
              --bind 'enter:become(nvim {1} +{2})'
    fi
}

alias vt="fzf_rg"



function tmux_session(){
    if [ -z "$TMUX" ]; then
        tmux a -t $(tmux ls -F '#{session_name}' | fzf)
    else
         tmux ls -F '#{session_name}' | fzf-tmux -p | xargs tmux switch -t
    fi
}

alias t="tmux_session"
