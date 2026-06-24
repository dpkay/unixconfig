# unixconfig — shared shell/dev config

Cross-platform **bash** dotfiles used on macOS, WSL, Debian, and Ubuntu. Bash is
the shell on every platform (macOS too — do **not** convert to zsh). The repo is
expected to live at `~/unixconfig`.

## Layout

- `bashrc` — the real shared bashrc (platform branches for Mac/Windows/Linux). Sourced by `~/.bashrc`.
- `alias_bash` — shared aliases (sourced from `bashrc`).
- `dir_colors` — GNU `dircolors` database (needs GNU coreutils; see gotchas).
- `tmuxrc`, `vimfiles/`, `bin/` — tmux config, vim runtime, and helper scripts on `PATH`.
- `setup/` — install stubs copied into `~` (`bash_profile`, `bashrc`, `gitconfig`, `vimrc`).
- `setup/setup.sh` — **minimal**: just `cp`s the stubs to `~/.*`. It does NOT install
  packages, set `HOME_DIR`, fix the Homebrew path, or change the login shell. Do not
  rely on it alone to bootstrap a machine — follow "Bootstrap a new machine" below.

## How it wires up

`~/.bash_profile` → sources `~/.bashrc` → sets `HOME_DIR`/`UNIXCONFIG` → sources
`$UNIXCONFIG/bashrc`. Putting the real config behind `~/.bashrc` means both login
shells (macOS Terminal) and non-login shells (Linux terminals) load identically.

## Bootstrap a new machine

1. Clone to `~/unixconfig`.
2. Install the stub dotfiles into `~`:
   ```
   cd ~/unixconfig/setup
   cp bash_profile ~/.bash_profile && cp bashrc ~/.bashrc && cp gitconfig ~/.gitconfig && cp vimrc ~/.vimrc
   ```
   (Equivalent to `setup.sh` but skips the stray `~/.setup.sh` it would create.)
3. In `~/.bashrc`, confirm `HOME_DIR="$HOME"` (the line marked "change this"). `$HOME`
   is correct on every platform — only override if the repo is not under `$HOME`.
4. Platform packages:
   - **macOS**: `brew install bash coreutils`. Stock macOS bash is 3.2 (2007, frozen
     for GPLv3 reasons) and lacks GNU coreutils — both are required for this config to
     behave (GNU `ls --color`, `dircolors`, bash 4+ features). Then make Homebrew bash
     the login shell (needs sudo / user password — have the user run it):
     ```
     echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells   # /usr/local on Intel
     chsh -s /opt/homebrew/bin/bash
     ```
   - **Debian/Ubuntu/WSL**: bash + coreutils are already present.
5. Open a new terminal and verify: `echo $PLATFORM` (mac/linux/windows), `type ls`
   (alias → GNU `ls`), and that `ls` shows colors.

## Non-obvious gotchas (the reasons behind the setup)

- **macOS Homebrew prefix** is `/opt/homebrew` on Apple Silicon, `/usr/local` on
  Intel. The Mac branch in `bashrc` auto-detects this; do not hardcode `~/homebrew`.
- **GNU coreutils before BSD**: the Mac branch puts
  `$HOMEBREW_ROOT/opt/coreutils/libexec/gnubin` ahead of `/usr/bin` on `PATH` so `ls`,
  `dircolors`, etc. are the GNU versions the aliases/`dir_colors` expect. BSD `ls` does
  not understand `--color=auto`.
- **`dir_colors` TERM whitelist**: GNU `dircolors` emits an *empty* `LS_COLORS` (→ no
  colors) when `$TERM` is not listed via a `TERM` directive in the file. Modern
  terminals/tmux use `xterm-256color` etc., so glob entries (`TERM xterm*`,
  `TERM *256color*`, `TERM tmux*`, …) must be present. If colors vanish, check this first.
- **Bash deprecation nag**: Apple's `/bin/bash` 3.2 prints "The default interactive
  shell is now zsh…" unless `BASH_SILENCE_DEPRECATION_WARNING=1` is set (done in the Mac
  branch). Switching the login shell to Homebrew bash removes the nag entirely.
- Keep `HOME_DIR` as `$HOME`, not a hardcoded `/home/<user>` — that path is wrong on
  macOS (`/Users/<user>`).
- **`~/.local/bin` must stay on `PATH`** (added at the front in `bashrc`). User-level
  tools install there — Claude Code (`~/.local/bin/claude`), `pipx`, etc. When switching
  a machine's login shell (e.g. macOS zsh → bash), tools that the *old* shell's rc added
  to `PATH` can silently disappear; make sure their dirs are in this shared `bashrc`, not
  only in the abandoned `~/.zshrc`/`~/.zprofile`.
