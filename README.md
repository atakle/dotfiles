#  dotfiles
Personal UNIX configuration files.

## Installation

The `install.zsh` script can be run to install symbolic links to the files in
this repository. Use the `-h` flag for details.

Files are kept out of the user's `$HOME` directory whenever possible – XDG base
directories are used instead. Some programs support this natively; others can
be instructed to do so through environment variables, most of which are read
from the [`.zshenv`](zsh/.zshenv) file, with one important exception:

### ZDOTDIR

One caveat of keeping the user's zsh configuration outside of `$HOME`, is that
zsh needs to be told through the `ZDOTDIR` variable where to find it – by some
method other than reading the user's zsh configuration itself.

Setting `ZDOTDIR` is not handled by the install script, as there isn't really
one right way to do it – it depends on the circumstances. Some options include:

* Define it in one of the system-wide rc files ([example](zsh/zshenv-global.example.zsh)).
* Keep a single rc file in `$HOME` to bootstrap the process ([example](zsh/zshenv-user.example.zsh)).
