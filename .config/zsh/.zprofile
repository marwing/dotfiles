# set PATH so it includes .yarn/bin folder if it exists
if [ -d "$(yarn global bin)" ] ; then
    PATH="$(yarn global bin):$PATH"
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
export TERMINAL="termite"

# enable wayland
export MOZ_ENABLE_WAYLAND=1
# export QT_QPA_PLATFORM=wayland-egl
# export GDK_BACKEND=wayland
# export CLUTTER_BACKEND=wayland
# export XDG_CURRENT_DESKTOP=Unity

export RANGER_LOAD_DEFAULT_RC=false

export DVDCSS_CACHE="${XDG_DATA_HOME:-$HOME/.local/share}"/dvdcss

# use ccache in cmake builds if available
if command -v /usr/bin/ccache; then
    for lang in "C" "CXX"; do
        export CMAKE_${lang}_COMPILER_LAUNCHER="ccache"
        export ${lang}FLAGS="${${(P)lang}FLAGS} -fdiagnostics-color=always"
    done
fi

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi
