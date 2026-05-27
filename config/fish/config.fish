if not status is-interactive
    exit
end

# Executables
alias playit='/mnt/Software/Linux/Playit/playit-linux-amd64'

# NVM
if test -d ~/.nvm
    nvm use latest --silent
end

# Themes
set -gx LS_COLORS (vivid generate catppuccin-mocha)

# DE
set QT_QPA_PLATFORMTHEME qt6ct
export QT_QPA_PLATFORM=wayland
set XDG_CURRENT_DESKTOP sway
set XDG_SESSION_DESKTOP sway
export XDG_CURRENT_SESSION_TYPE=wayland

set export GTK_IM_MODULE fcitx
set export QT_IM_MODULE fcitx
set SDL_IM_MODULE fcitx
export XMODIFIERS='@im=fcitx'

# Editor
set EDITOR nvim

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# WLR
set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx WLR_DRM_DEVICES /dev/dri/card0:/dev/dri/card1

#Go
set PATH "$PATH:$HOME/go/bin"

# Android SDK
set -gx ANDROID_HOME /mnt/Software/android_sdk
set -gx ANDROID_SDK_ROOT /mnt/software/android_sdk
set -gx PATH $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $PATH

# Cargo
set PATH "$PATH:$HOME/.cargo/bin"
