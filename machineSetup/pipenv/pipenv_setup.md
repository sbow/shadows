## Pipenv | folder by folder venv
- Compliments pyenv
- Replaces conda
- Can read requirements.txt

### Fix potential timeout issue:
> mkdir $HOME/.config/pip
> touch $HOME/.config/pip/pip.conf
> echo -e "[global]\ntimeout = 3600"> $HOME/.config/pip/pip.conf

### Basic usage - utilize Pipfile to get dependancies:
> pipenv install 

### Basic usage - utilize requirements.txt to get dependancies:
> pipenv -r requirements.txt

### Basic usage - set python version & init venv:
> cd $home/path/to/project/root
> pipenv --python 3.8


### Ref - basic pyenv usage:
> pyenv install 3.8

### libgdal-dev and pygdal specific instructions
- https://rasmuse.github.io/setting-up-gdal-python-virtualenv.html
