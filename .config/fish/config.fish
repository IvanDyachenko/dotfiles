# Configure pinentry to use the correct TTY.
# https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TT
set -x GPG_TTY (tty)

set -gx HOMEBREW_PREFIX "/opt/homebrew"
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
fish_add_path -gP "/opt/homebrew/bin" "/opt/homebrew/sbin"
! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH
! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH

# Add fenv to path
set fish_function_path $fish_function_path $HOME/.config/fish/plugins/plugin-foreign-env/functions

# Source Nix setup script
# fenv source ~/.nix-profile/etc/profile.d/nix.sh

# For direnv to work properly it needs to be hooked into the shell.
eval (direnv hook fish)
