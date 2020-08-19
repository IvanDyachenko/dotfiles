# Set the `JAVA_HOME` path.
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$JAVA_HOME/bin:$PATH
if [ -e /Users/ivandyachenko/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/ivandyachenko/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
