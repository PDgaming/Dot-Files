fish_add_path /opt/nvim-linux-x86_64/bin
fish_add_path /usr/local/go/bin
fish_add_path /media/Software/AI_models/
alias cursor='/media/Software/Linux/Cursor/Cursor.AppImage'
if test -d $HOME/.nvm
	nvm use 22 --silent
end
set -x QT_QPA_PLATFORMTHEME qt5ct
export EDITOR=nvim
