# Shaun Bowman
# 2023/03/09
#
# setupFedoraBase.sh
#
# A script to perform initial setup of a linux machine.
#


# Install windowing system & vnc viewer. For linode.
# Install misc admistrative terminal apps
tput setaf 1
echo "------ Installing Misc Utils  -------"
tput sgr0
sudo dnf install mosh
sudo dnf install vim
sudo dnf install git
sudo dnf install rdiff
sudo dnf install wget
sudo dnf install curl
sudo dnf install gnupg
sudo dnf install lsb-release
sudo dnf install dos2unix
sudo dnf install colordiff
sudo dnf install tree
sudo dnf install bat
sudo dnf install httpie
sudo dnf install tldr
sudo dnf install fzf
sudo dnf install net-tools
sudo dnf install smdb

tput setaf 1
read -p "Do u need to setup 'fd' fast find?" -n 1 -r
tput sgr0
echo # create newline, optional
if [[ $REPLY =~ ^[Yy]$ ]]
then
	tput setaf 1
	echo "installing command 'fd'!"
	tput sgr0
	sudo dnf install fd-find
	cd $HOME
	echo 'alias fd="fdfind"' >> .bashrc
fi
sudo dnf install ripgrep
sudo dnf install htop
tput setaf 1
read -p "Do u need to setup 'z' jump-around?" -n 1 -r
tput sgr0
echo # create newline, optional
if [[ $REPLY =~ ^[Yy]$ ]]
then
	tput setaf 1
	echo "installing command 'z'!"
	tput sgr0
	cd $HOME
	wget https://raw.githubusercontent.com/rupa/z/master/z.sh
	chmod +x z.sh
	echo '. ~/z.sh' >> .bashrc
fi


# Setup python for ML / AI / Datascience
sudo dnf install python3-pip
sudo dnf install python3-venv
cd $HOME
tput setaf 1
read -p "Do u need to setup python venv (venv38)f? " -n 1 -r
tput sgr0
echo # create newline, optional
if [[ $REPLY =~ ^[Yy]$ ]]
then
	tput setaf 1
	echo "u said yes!"
	tput sgr0
	python3 -m venv venv38
	source venv38/bin/activate
	echo 'source venv38/bin/activate' >> .bashrc
fi
tput setaf 1
echo "------ Setting up python modules -------"
tput sgr0
python3 -m pip install numpy
python3 -m pip install pandas
python3 -m pip install scipy
python3 -m pip install pillow
python3 -m pip install matplotlib
python3 -m pip install opencv-python
python3 -m pip install scikit-learn
python3 -m pip install keras
python3 -m pip install tensorflow tensorflow-gpu
python3 -m pip install torch torchvision
python3 -m pip install mxnet
python3 -m pip install jupyter
python3 -m pip install jupyter_http_over_ws
python3 -m pip install jupyter_contrib_nbextensions
python3 -m pip install jupyter_nbextensions_configurator
python3 -m pip install jupyterlab
python3 -m pip install SimpleHTTPServer
python3 -m pip install pychromecast
python3 -m pip install googlemaps
python3 -m pip install gmaps
python3 -m pip install mdfreader
jupyter nbextension enable --py --sys-prefix gmaps
jupyter contrib nbextension install --user
python3 -m pip install pytest
python3 -m pip install pycodestyle

# Setup home folder
tput setaf 1
read -p "Do u want to setup home dirs/git clones?? " -n 1 -r
tput sgr0
echo # create newline, optional
if [[ $REPLY =~ ^[Yy]$ ]]
then
	tput setaf 1
	echo "doing initial git clones and folder creation!"
	tput sgr0
	cd $HOME
	mkdir git
	mkdir mlDatasets
	cd git
	git clone https://github.com/sbow/shadows
	git clone https://github.com/sbow/RpiDatalogger
	git clone https://github.com/sbow/pyCast
	git clone https://github.com/sbow/mowbotCpp
	git clone https://github.com/sbow/scratch
	git clone https://github.com/sbow/vim
	git clone https://github.com/sbow/coursera
	git clone https://github.com/sbow/udacity
fi

