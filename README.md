# overview/roadmap

This script will primarily focus on creating a development/devops enviroment focusing on the installation of tools, languages, and settings geared around terminal based developer productivity.

- creates a distro based reproducible development enviroment when run
- the common install and configurations paths used by the script are defined in the .env file
- installs to $HOME/.local/ with the attempt to keep the home path a clean as possible
- shell updates such as aliases, hotkeys, commands, and path updates will go in ~/.config/shell
- the shell will be zsh based but updates will also be available in a bash shell

# How to run the script 
There are 2 different scripts/functions used in this repo to reproduce an enviroment.

1. run
2. config/run

## run

executing the run script/function will run any of the executable scripts listed in the ./runs directory

```bash
/bin/bash run
/bin/bash run --dry # for testing purposes
/bin/bash run [script] will search for scripts with names matching script and execute only them 
```


## config/run

executing the config/run command will copy any files or directories specified within the ./config/run script and copy them to the locations specified in the script
to add more or adjust the target directories the script itself must be modified.

