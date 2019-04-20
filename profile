# /etc/profile

# Set our umask
umask 022

# Append our default paths
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

appendpath '/usr/local/sbin'
appendpath '/usr/local/bin'
appendpath '/usr/bin'
appendpath '/mbin'
appendpath '/opt/android-sdk/platform-tools'
appendpath '/opt/android-sdk/build-tools'
unset appendpath

export PATH

# Use Wayland
#export QT_QPA_PLATFORM="wayland-egl;xcb"    # QT5
#export SDL_VIDEODRIVER=wayland             # SDL2

# Wayland Keyboard Configuration
export XKB_DEFAULT_MODEL="pc105"
export XKB_DEFAULT_LAYOUT="us,el"
export XKB_DEFAULT_OPTIONS="grp:alt_shift_toggle,caps:swapescape"

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
    for profile in /etc/profile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

# Source global bash config
if test "$PS1" && test "$BASH" && test -z ${POSIXLY_CORRECT+x} && test -r /etc/bash.bashrc; then
    . /etc/bash.bashrc
fi

# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP

# Man is much better than us at figuring this out
unset MANPATH
