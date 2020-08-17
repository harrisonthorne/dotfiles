if status is-interactive
   cat ~/.config/wpg/sequences
end

bash /etc/profile
bash ~/.bashrc

alias system-upgrade="sudo emerge -vuUND --autounmask-write --keep-going --with-bdeps=y --backtrack=1000 @world"
# alias imv="imv -e Monospace:13"
alias btrfs-csum-errors="sudo dmesg | grep 'checksum error at' | cut -d\  -f27- | sed 's/.\$//' | sort | uniq"

set fish_greeting ""
set -gx ANDROID_EMULATOR_USE_SYSTEM_LIBS 1
set -gx BROWSER /bin/firefox
set -gx EDITOR /bin/nvim
set -gx EIX_LIMIT 0
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git --ignore node_modules -g ""'
set -gx GPG_TTY (tty)
set -gx GOPATH $HOME/go
set -gx LEDGER_FILE $HOME/Notebook/ledger/main.mvelopes
set -gx QT_QPA_PLATFORMTHEME gtk
set -gx RUSTBIN $HOME/.cargo/bin
set -gx SXHKD_SHELL '/bin/sh'
set -gx WINEPREFIX $HOME/.wine/
set -gx _JAVA_AWT_WM_NONREPARENTING 1

set -gx PATH $GOPATH/bin $RUSTBIN $PATH $HOME/.local/bin

# Start desktop at login
if status is-login
    # removing; sway is started at boot via systemd service for the time being
    #    if test -z "$DISPLAY"
        # startx -- -keeptty > ~/startx.log
        # sway > sway.log ^ sway.err
    # end
else
    eval (keychain -q --gpg2 --agents "gpg,ssh" --eval id_rsa_github id_rsa_bitbucket 4B21310A52B15162)
end

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

function encrypt
    gpg -c $argv[1] && rm $argv[1]
end

# ??? TODO
# function decrypt
#     gpg -d $argv[1] && rm $argv[1]
# end

function crypt-edit
    if count $argv > /dev/null
        # set temp file
        set temp (mktemp)

        if test -e $argv[1]
            # decrypt the file
            echo "decrypting file..."
            gpg --yes -o $temp -d $argv[1]
        else
            echo "$argv[1] doesn't exist, but we'll create it"
        end

        # edit it, if successful
        and begin
            $EDITOR $temp

            # re-encrypt the file
            echo "encrypting file..."
            gpg --yes -o $argv[1] -c $temp
        end

        # or, don't
        or begin
            echo "file wasn't decrypted successfully, quitting"
            return 1
        end

        # remove decrypted file
        rm -f $temp

        echo "all done!"
    else
        echo "no file given."
    end
end
