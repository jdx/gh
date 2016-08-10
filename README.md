gh
==

gh allows you to very quickly navigate between GitHub project cloned on your
local box. It will `cd` into project directories quickly and clone repos that do
not exist.

There is a lot of mental overhead trying to manage a custom `~/src` directory with your projects. I tried managing by work/personal, programming language, even tried a different directory for each month. I found by simply making your projects path reflect GitHub, it was much easier to remember where things were.

Here is a demo of me moving around various projects

![demo](demo.gif)

Usage
=====

Clone and/or go to `~/src/github.com/githubuser/githubrepo`.

```
gh githubuser githubrepo
```

It'll either just be a `cd` or it will clone `git@github.com:githubuser/githubrepo.git`

Note that tab completion is available for project and usernames.

## Changing the base directory
`gh` will clone or `cd` into `$GH_BASE_DIR/github.com/user/repo`.
By default `$GH_BASE_DIR` points to `$HOME/src`. By changing the `$GH_BASE_DIR` variable in your shell's config file, you can control where `gh` will clone/`cd` into.

**Note:** Already cloned repos will not be transferred to the new location, they will be cloned again.

**More important Note:** Do not use the tilde-character (`~`) in `$GH_BASE_DIR`, use `$HOME` instead.

Supported Shells
================

* bash
* [fish](http://fishshell.com/)
* [OH-MY-ZSH](http://ohmyz.sh/)

Installation For Fish
=====================

Using [fisherman](https://github.com/fisherman/fisherman):

```
fisher dickeyxxx/gh
```

Alternatively, symlink (or copy) the function and completion files into `$fish_function_path` and `$fish_complete_path`

    mkdir -p ~/src/github.com/dickeyxxx
    git clone git@github.com:dickeyxxx/gh.git ~/src/github.com/dickeyxxx/gh
    ln -s ~/src/github.com/dickeyxxx/gh/functions/gh.fish ~/.config/fish/functions/gh.fish
    ln -s ~/src/github.com/dickeyxxx/gh/completions/gh.fish ~/.config/fish/completions/gh.fish

Installation For Oh-My-ZSH
==========================

Add this environment variable for your GitHub username (optional)

    typeset +gx -A GITHUB
    GITHUB[user]=dickeyxxx

Then symlink (or copy) the gh folder into your Oh-My-ZSH plugins folder

    ln -s ~/src/github.com/dickeyxxx/gh/zsh/gh ~/.oh-my-zsh/custom/plugins/gh

Next add the plugin to your `~/.zshrc` file

    plugins=(gh)

For example:

```
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew meteor node npm osx redis-cli sublime gh)

```

Finally reload the `~/.zshrc` file:

    source ~/.zshrc

The zsh autocompletion supports loading a user's repositories from github. For that to work, you need to set the environment variable `GH_FETCH_REPOS` to true. You will also need to install [jsawk](https://github.com/micha/jsawk) for it to work.

If you now type `gh someusername` and then press `<Tab>`, it will load that user's repositories from github and display them to you.

Installation for bash
=====================

```
echo 'source ~/src/github.com/dickeyxxx/gh/bash/gh.bash' >> ~/.bashrc
echo 'source ~/src/github.com/dickeyxxx/gh/completions/gh.bash' >> ~/.bashrc
```

GitHub Alternatives
===================

* bb - bitbucket (fish)
* gl - gitlab (fish)

Go developers
=============

This follows the standard convention for Go projects so long as you have your `GOPATH` set to `~`.
