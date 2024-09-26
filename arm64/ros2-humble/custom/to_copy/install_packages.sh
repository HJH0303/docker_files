#! /bin/bash

#1#
echo "Start to install necessary packages for ROS and Gazebo..."

wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc | sudo tee /etc/apt/trusted.gpg.d/kitware.asc

apt-get update && apt-get install -q -y \
    apt-utils \
    build-essential \
    bc \
    cmake \
    curl \
    git \
    lsb-release \
    libboost-dev \
    sudo \
    nano \
    net-tools \
    tmux \
    tmuxinator \
    wget \
    ranger \
    htop \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    vim \
    v4l-utils \
#imagemagic    

#2#
echo "Start to move the copied files..." 

mv aliases .bash_aliases
mv vimrc .vimrc
mv tmux .tmux.conf
mkdir -p .config/ranger
mv ranger .config/ranger/rc.conf


#3#
echo "Start to modify some lines in .bashrc"

echo "" >> ~/.bashrc
echo 'parse_git_branch() {' >> ~/.bashrc && \
echo '    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1)/"' >> ~/.bashrc && \
echo '}' >> ~/.bashrc
echo 'PS1="\[\e[0;31m\][\u]\[\e[m\] \[\e[0;32m\]\w\[\e[m\] \$(parse_git_branch)\[\e[00m\]\n$ "' >> ~/.bashrc

echo 'export EDITOR=vim;'

echo "" >> ~/.bashrc
echo 'echo "$(stty speed 921600 < /dev/ttyUSB0)"'
