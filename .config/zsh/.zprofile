# set PATH so it includes .yarn/bin folder if it exists
if (( $+commands[yarn] )) && [ -d "$(yarn --offline global bin)" ] ; then
    PATH="$(yarn --offline global bin):$PATH"
fi

# set PATH so it includes .local/bin folder if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes .scripts folder if it exists
if [ -d "$HOME/.scripts" ] ; then
    PATH="$HOME/.scripts:$PATH"
fi

# export some variables
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export PAGER="less"
export TERMINAL="alacritty"

# enable wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export _JAVA_AWT_WM_NONREPARENTING=1

export RANGER_LOAD_DEFAULT_RC=false

export DVDCSS_CACHE="${XDG_DATA_HOME:-$HOME/.local/share}"/dvdcss

export MAKEFLAGS=-j$(($(nproc) + 2))

# use ccache in cmake builds if available
if (( $+commands[ccache] )); then
    for lang in "C" "CXX"; do
        export CMAKE_${lang}_COMPILER_LAUNCHER="ccache"
        export ${lang}FLAGS="${${(P)lang}FLAGS} -fdiagnostics-color=always"
    done
fi

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi
