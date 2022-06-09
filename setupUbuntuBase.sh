# Shaun Bowman
# 2022/06/09
#
# setupUbuntuBase.sh
#
# A script to perform initial setup of a linux machine.
#

# Setup OS level package manager
sudo apt install software-properties-common
sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-add-repository restricted
sudo apt-get update
sudo apt-get upgrade

# Install windowing system & vnc viewer. For linode.
# sudo apt install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
# sudo apt install tigervnc-standalone-server

# Install misc admistrative terminal apps
sudo apt-get install mosh
sudo snap install btop
sudo apt-get install vim
sudo apt-get install git
sudo apt install rdiff
sudo apt install wget
sudo apt install curl
sudo apt install gnupg
sudo apt install lsb-release


# Setup python for ML / AI / Datascience
sudo apt install python3-pip
sudo apt install python3-venv
cd $HOME
python3 -m venv venv38
source venv38/bin/activate
echo 'source venv38/bin/activate' >> .bashrc
exec $SHELL
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

# Setup home folder
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

# Grab ML datasets
cd $HOME
cd mlDatasets

# Install ros
echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add 
sudo apt update
sudo apt install ros-noetic-desktop-full
sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt upgrade
sudo apt install ros-rolling-desktop

