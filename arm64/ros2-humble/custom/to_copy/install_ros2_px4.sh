#! /bin/bash

#1#
# Install the ROS2

# Prepare for ROS2
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
apt update

# Install ROS2
apt install -y ros-${ROS2_DISTRO}-desktop 

# Install ROS2-tools
apt install -y \
    python3-argcomplete \
    ros-dev-tools \
    python3-colcon-common-extensions

# Initialize ROS2 workspace
mkdir -p /root/ros2_ws/src
cd /root/ros2_ws
colcon build
cd /root/ros2_ws/src

echo "" >> ~/.bashrc
echo "source /opt/ros/${ROS2_DISTRO}/setup.bash" >> ~/.bashrc
echo "source /root/ros2_ws/install/local_setup.bash" >> ~/.bashrc

# Install Gazebo
apt-get update
apt-get install ros-${ROS2_DISTRO}-ros-gz -y

# Install ros2 libraries
apt-get install -y \
    ros-${ROS2_DISTRO}-ros-ign-bridge \
    ros-${ROS2_DISTRO}-vision-msgs \
    ros-${ROS2_DISTRO}-joint-state-publisher \
    ros-${ROS2_DISTRO}-ros2-control \
    ros-${ROS2_DISTRO}-ros2-controllers \
    ros-${ROS2_DISTRO}-hardware-interface \
    ros-${ROS2_DISTRO}-controller-interface \ 
    ros-${ROS2_DISTRO}-controller-manager \
    ros-${ROS2_DISTRO}-image-transport \
    ros-${ROS2_DISTRO}-cv-bridge \
    libignition-transport11-dev \
    libignition-gazebo6-dev 

cd /root/ros2_ws
rosdep init
rosdep update
rosdep install -r --from-paths src -i -y --rosdistro ${ROS2_DISTRO}


#2#
# Setup the Agent (Companion Computer)
cd /root/
git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
cd /root/Micro-XRCE-DDS-Agent
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig /usr/local/lib/
