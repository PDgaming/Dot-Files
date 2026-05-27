if not status is-interactive
    exit
end

# Executables
alias playit='/mnt/Software/Linux/Playit/playit-linux-amd64'
alias reBl="sudo systemctl restart bluetooth.service"
# NVM
if test -d ~/.nvm
    nvm use latest --silent
end

# Themes
set -gx LS_COLORS (vivid generate catppuccin-mocha)

# Editor
set -x EDITOR nvim

# bun
set -x BUN_INSTALL "$HOME/.bun"
set -x PATH $BUN_INSTALL/bin $PATH

#Go
set -x PATH "$PATH:$HOME/go/bin"

# Android SDK
set -gx ANDROID_HOME /mnt/Software/android_sdk
set -gx ANDROID_SDK_ROOT /mnt/software/android_sdk
set -gx PATH $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $PATH

# Cargo
set -x PATH "$PATH:$HOME/.cargo/bin"
