Naive instructions so that I remember:

Prompt
```sh
mkdir -p ~/.myscripts
ln -srf fancy-bash.sh ~/.myscripts/
```

Bashrc
```sh
ln -srf bashrc.sh ~/.bashrc
```

Aliases
```sh
ln -srf bash_aliases.sh ~/.bash_aliases
ln -srf bash_aliases.d ~/.bash_aliases.d
```

Completion rules
```sh
ln -srf bash_completion.sh ~/.bash_completion
```

Complete aliases
```sh
git clone https://github.com/lu0/complete-alias ${HOME}/.complete-alias
```

Profile
```sh
ln -srf profile ~/.profile
```

Inputrc - i.e. to auto complete previous commands.
```sh
ln -srf inputrc /etc/inputrc
```
