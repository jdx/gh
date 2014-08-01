Quick GitHub project downloader/finder for fish shell

Installation:

Add this environment variable for your GitHub username:

    set -U GITHUB dickeyxxx

Then copy the function into `$fish_function_path`:

    cp ~/src/github.com/dickeyxxx/g/g.fish ~/.config/fish/functions/g.fish

Usage:

Go to `~/src/github.com/dickeyxxx`:

```
g
```

Go to `~/src/github.com/dickeyxxx/myrepo`:

```
g myrepo
```

Go to `~/src/github.com/otheruser/repo`:

```
g otheruser repo
```
