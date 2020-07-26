# Configure pinentry to use the correct TTY.
# https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TT
set -x GPG_TTY (tty)
