# Shaun Bowman
# 2022/06/09
#
# setupUbuntuBase.sh
#
# A script to perform initial setup of a linux machine.
#

# Setup OS level package manager
tput setaf 1
echo "------ Setting up Package Manager -------"
tput sgr0
sudo apt install software-properties-common
sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-add-repository restricted
sudo apt-get update
sudo apt-get upgrade

# Install windowing system & vnc viewer. For linode.
tput setaf 1
read -p "Do u need to setup 'ubuntu-desktop' and vnc?" -n 1 -r
tput sgr0
echo # create newline, optional
if [[ $REPLY =~ ^[Yy]$ ]]
then
	tput setaf 1
	echo "installing ubuntu-desktop!"
	tput sgr0
	sudo apt install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
	tput setaf 1
	echo "installing vnc!"
	tput sgr0
	sudo apt install tigervnc-standalone-server
fi

# Install misc admistrative terminal apps
tput setaf 1
echo "------ Installing Misc Utils  -------"
tput sgr0
sudo snap install btop
sudo apt install mosh
sudo apt install vim
sudo apt install git
sudo apt install rdiff
sudo apt install wget
sudo apt install curl
sudo apt install gnupg
sudo apt install lsb-release
sudo apt install dos2unix
sudo apt install colordiff
sudo apt install tree
sudo apt install bat
sudo apt install httpie
sudo apt install tldr
sudo apt install fzf
tput setaf 1
read -p "Do u need to setup 'fd' fast find?" -n 1 -r
tput sgr0
echo # create newline, optional
if [[ $REPLY =~ ^[Yy]$ ]]
then
	tput setaf 1
	echo "installing command 'fd'!"
	tput sgr0
	sudo apt install fd-find
	cd $HOME
	echo 'alias fd="fdfind"' >> .bashrc
fi
sudo apt install ripgrep
sudo apt install htop
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
sudo apt install python3-pip
sudo apt install python3-venv
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
python3 -m pip install googlemaps
python3 -m pip install gmaps
jupyter nbextension enable --py --sys-prefix gmaps

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

# Install ros
tput setaf 1
read -p "Do u need to install ros1?? " -n 1 -r
tput sgr0
echo # create newline, optional
if [[ $REPLY =~ ^[Yy]$ ]]
then
	tput setaf 1
	echo "installing ros1!"
	tput sgr0
	echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list
	curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add 
	sudo apt update
	sudo apt install ros-noetic-desktop-full
fi
tput setaf 1
read -p "Do u need to install ros2?? " -n 1 -r
tput sgr0
echo # create newline, optional
if [[ $REPLY =~ ^[Yy]$ ]]
then
	tput setaf 1
	echo "installing ros2!"
	tput sgr0
	sudo apt install locales
	sudo locale-gen en_US en_US.UTF-8
	sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
	export LANG=en_US.UTF-8
	sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
	sudo apt update
	sudo apt upgrade
	sudo apt install ros-rolling-desktop
fi

# install webserver / node
sudo apt install nodejs

