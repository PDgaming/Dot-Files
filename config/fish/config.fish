alias cursor='/mnt/Software/Linux/Cursor/Cursor.AppImage'
alias playit='/mnt/Software/Linux/Playit/playit-linux-amd64'
alias scrcpy='/mnt/Software/Linux/Scrcpy/scrcpy'

if test -d ~/.nvm
    nvm use latest --silent
end

export QT_QPA_PLATFORMTHEME="qt6ct"

export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_SESSION_TYPE=wayland

export EDITOR=nvim

export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx WLR_DRM_DEVICES /dev/dri/card0:/dev/dri/card1
