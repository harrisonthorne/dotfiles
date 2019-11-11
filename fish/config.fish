if status is-interactive
    cat ~/.config/wpg/sequences
end

bash /etc/profile

alias system-upgrade="sudo emerge -vuUND --autounmask-write --keep-going --with-bdeps=y --backtrack=1000 @world"
alias imv="imv -e Monospace:13"

set fish_greeting ""
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git --ignore node_modules -g ""'
set -gx GOPATH $HOME/go
set -gx WINEPREFIX $HOME/.wine/
set -gx PATH $GOPATH/bin $PATH $HOME/.local/bin
set -gx BROWSER /bin/brave
set -gx EDITOR /bin/nvim
set -gx GDK_BACKEND x11
set -gx QT_QPA_PLATFORMTHEME gtk2
set -gx ANDROID_EMULATOR_USE_SYSTEM_LIBS 1
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx LEDGER_FILE $HOME/Notebook/hledger/hledger.journal
set -gx SXHKD_SHELL '/bin/sh'
set -gx W3MIMGDISPLAY_PATH /usr/libexec/w3m/w3mimgdisplay
set -gx EIX_LIMIT 0

# Start desktop at login
if status is-login
    if test -z "$DISPLAY" # -a $XDG_VTNR = 1
        startx -- -keeptty > ~/startx.log
    end
else
    eval (keychain -q --agents ssh --eval id_rsa_github id_rsa_bitbucket)
end

# if status is-interactive; and not set -q TMUX
#     test $TERM != "screen"; and exec tmux
# end

function fish_prompt --description 'Write out the prompt'
    set -l color_cwd
    set -l suffix
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '$'
    end

    echo -n -s (set_color $color_cwd) (prompt_pwd) (set_color normal) ' ' "$suffix "
end

function nohup
    command nohup $argv </dev/null >/dev/null 2>&1 & disown
end
