# dotfiles

This repository resides in `$HOME`, the working tree. The git
directory should reside in `$HOME/.dots.git`.

To use this repository, place this in your shell config:

~~~
alias config='/usr/bin/git --git-dir=$HOME/.dots.git/ --work-tree=$HOME'
~~~

## To clone this repository

~~~
git clone --bare <this-repo-url> $HOME/.dots.git
~~~

Then run:

~~~
config checkout
config config --local status.showUntrackedFiles no
~~~

## To add files to or remove files from this repository

The `config` alias can be used just like the `git` command.

~~~
config add <file>
~~~

~~~
config rm <file>
~~~

~~~
config commit -m "Some changes"
~~~

## To store changes remotely or pull updates

~~~
config push
~~~

~~~
config pull
~~~

## Resources

I found this idea while researching how to ignore git
repositories with Syncthing (the solution: don't sync git
repositories with Syncthing).

<https://news.ycombinator.com/item?id=11071754>

<https://www.atlassian.com/git/tutorials/dotfiles>

<https://www.ackama.com/blog/posts/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained>
