# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

if [ -e /home/primary/.nix-profile/etc/profile.d/nix.sh ]; then . /home/primary/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "/home/primary/.deno/env"
