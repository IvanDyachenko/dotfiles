# Load "Dracula" theme.
fish_config theme choose "Dracula Official"

# Run foreign bash scripts and capture exported environment variables.
set fish_function_path $fish_function_path $HOME/.config/fish/plugins/plugin-foreign-env/functions

# direnv is an extension for your shell.
# It augments existing shells with a new feature that can load and unload environment variables 
# depending on the current directory.
eval (direnv hook fish)

# Configure pinentry to use the correct TTY.
# https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TT
set -x GPG_TTY (tty)

# Load homebrew.
if test -d /opt/homebrew
	set -gx HOMEBREW_PREFIX "/opt/homebrew"
	set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
end
! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH
fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"
