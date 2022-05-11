# Terminal configuration: Tilix

I now use the [`tilix`](https://github.com/gnunn1/tilix) terminal after being a
keen user of `gnome-terminal` in the past, since they use the same engine (GTK+
3 VTE) and hence they are very similar in their configurations and features,
which has made the migration very smooth.

Major difference between the two is: `tilix` supports side-panels natively! So
no need to multiplex it with external dependencies (such as `tmux`).

Here I share my refactored configuration files for `tilix`.


## Setup

Backup current keybindings
```sh
dconf dump /com/gexperts/Tilix/ > tilix-terminal.conf.backup
```

### Oneliner
If future me trusts me:
```sh
./load_terminal_dconf.sh
```

### Manual
Othe

1. Override base schema:
```sh
dconf reset -f /com/gexperts/Tilix/
dconf load /com/gexperts/Tilix/ < tilix-base.conf
```

1. Override with my custom keybindings
```sh
dconf load /com/gexperts/Tilix/ < tilix-keybindings.conf
```

1. Load my custom profile (palette/theme and fonts)
```sh
dconf load /com/gexperts/Tilix/ < tilix-profile.conf
```
