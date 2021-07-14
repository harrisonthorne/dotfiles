fenv source /etc/profile
fenv source ~/.bashrc

if [ -f $HOME/.config/fish/colors.fish ]
    source $HOME/.config/fish/colors.fish
end > /dev/null

if [ -f $HOME/.config/fish/private.fish ]
    source $HOME/.config/fish/private.fish
end > /dev/null

alias btrfs-csum-errors="sudo dmesg | grep 'checksum error at' | cut -d\  -f27- | sed 's/.\$//' | sort | uniq"
alias btrfs-du="sudo btrfs fi du --si $argv | tee du_full.txt | cut -b 11- | sort -h | tee du_sorted.txt | tail -n3000 | tee du.txt"
alias config='git --git-dir=$HOME/.dots.git/ --work-tree=$HOME'
alias gentoo-system-upgrade="sudo emerge -vuUND --autounmask-write --keep-going --with-bdeps=y --backtrack=1000 @world"
alias notebook='git --git-dir=$HOME/.notebook.git/ --work-tree=$HOME/notebook'
alias pandoc-preview="~/.config/nvim/pandocPreview.sh"

alias c="config"
alias g="git"
alias n="nvim"
alias q="exit"
alias r="ranger"
alias s="env XDG_CURRENT_DESKTOP=sway XDG_SESSION_TYPE=wayland sway"
# alias s="env XDG_CURRENT_DESKTOP=sway XDG_SESSION_TYPE=wayland dbus-run-session sway"

alias nb="notebook"

set fish_greeting ""
set -gx ANDROID_EMULATOR_USE_SYSTEM_LIBS 1
set -gx BAT_THEME base16
set -gx BEMENU_BACKEND wayland
set -gx BROWSER firefox
set -gx EDITOR nvim
set -gx EIX_LIMIT 0
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git --ignore node_modules -g ""'
set -gx GOPATH $HOME/go
set -gx GPG_TTY (tty)
set -gx GTK_THEME "Arc-Dark"
set -gx LEDGER_FILE $HOME/Notebook/ledger/main.sfox
set -gx NODE_BIN $HOME/.npm-global/bin $HOME/.npm-packages/bin
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx RUSTBIN $HOME/.cargo/bin
set -gx SUDO_ASKPASS ksshaskpass
set -gx SXHKD_SHELL /bin/sh
set -gx TEXLIVE_PATH /opt/texlive/2021/bin/x86_64-linux/
set -gx WINEPREFIX $HOME/.wine/
set -gx XBPS_DISTDIR $HOME/code/void/packages

# path. you know it, you love it
set -gx PATH $GOPATH/bin $RUSTBIN $PATH $HOME/.local/bin $NODE_BIN /usr/lib $HOME/bin $TEXLIVE_PATH

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

function encrypt-folder
    set folder (string replace -r '/$' '' $argv[1])
    tar --zstd -cvf $folder.tar.zst $folder
    and gpg -c $folder.tar.zst
    and rm -rf $folder.tar.zst $folder
end

function decrypt-folder
    set folder (string replace -r '/$' '' $argv[1])
    gpg --decrypt-files $folder.tar.zst.gpg
    and tar --same-owner -xpvf $folder.tar.zst
    and rm $folder.tar.zst.gpg $folder.tar.zst
end

function sleep-timer
    set seconds (math "$argv[1] * 60")
    for i in (seq $seconds)
        set left (math $seconds - $i)
        echo -n -e "\r\033[Kgoing to sleep in $left seconds"
        sleep 1
    end
    echo -e "\r\033[Ksweet dreams :)"
    sudo zzz
    echo -e "\r\033[Kgood morning!"
end

function qr
    set file (mktemp)
    qrencode $argv -o $file
    imv $file
end

function unlock-keychain
    eval (keychain -q --gpg2 --agents "gpg,ssh" --eval id_rsa_github id_rsa_bitbucket id_ed25519 4B21310A52B15162) 2> /dev/null
end

function btrfs-du
    sudo btrfs fi du --si $argv | tee du_full.txt | sort -h | tee du_sorted.txt | tail -n3000 | tee du.txt
end

if ! status is-login && status is-interactive
    unlock-keychain
end
