# Configure pinentry to use the correct TTY.
# https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TT
set -x GPG_TTY (tty)

# Add fenv to path
set fish_function_path $fish_function_path $HOME/.config/fish/plugins/plugin-foreign-env/functions

# Source Nix setup script
fenv source ~/.nix-profile/etc/profile.d/nix.sh

# For direnv to work properly it needs to be hooked into the shell.
eval (direnv hook fish)

thefuck --alias | source
