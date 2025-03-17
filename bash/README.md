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
sudo apt install bash-completion
git clone https://github.com/cykerway/complete-alias ~/.complete-alias
cd ~/.complete-alias
git checkout 3fc67e8
```

Profile
```sh
ln -srf profile ~/.profile
```

Inputrc - i.e. to auto complete previous commands.
```sh
ln -srf inputrc /etc/inputrc
```
