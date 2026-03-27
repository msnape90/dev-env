There are 2 different scripts/functions used in this repo to reproduce an enviroment.

1. run
2. config/run

# run

executing the run script/function will run any of the executable scripts listed in the ./runs directory

```bash
/bin/bash run
/bin/bash run --dry # for testing purposes
/bin/bash run [script] will search for scripts with names matching script and execute only them 
```


# config/run

executing the config/run command will copy any files or directories specified within the ./config/run script and copy them to the locations specified in the script
to add more or adjust the target directories the script itself must be modified.

