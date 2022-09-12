alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' \
      dfs='dotfiles' \
      ls='exa' \
      rip='pv /dev/sr0 > $(vobcopy -I /dev/sr0 2>&1 | awk "/DVD-name/ {print \$3}").iso && eject' \
      ffmpeg="ffmpeg -hide_banner" \
      pall='for r in */; do echo --------------------------------$(basename "${r}")--------------------------------; git -C "${r}" pull; done' \
      purgeemptydirs='find . -depth -type d -empty -delete' \
      arcsize='arc_summary | grep "ARC size"'
