FROM ubuntu:jammy as ros2

# Setup environment
ENV LANG C.UTF-8
ENV LC_AL C.UTF-8
ENV ROS2_DISTRO humble
ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute
ENV TZ=Asia/Seoul


# Setup timezone (fix interactive package installation)
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Install necessary packages for ROS and Gazebo
RUN apt-get update &&  apt-get install -q -y \
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
    vim


# Prepare for ROS2
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt update

# Install ROS2
RUN apt install -y \
    ros-${ROS2_DISTRO}-desktop 
    
# Install ROS2 tools
RUN apt install -y \
    python3-argcomplete \
    ros-dev-tools \
    python3-colcon-common-extensions

# Copy configuration files
COPY ./to_copy/aliases /root/.bash_aliases
COPY ./to_copy/vim /root/.vimrc
COPY ./to_copy/tmux /root/.tmux.conf
COPY ./to_copy/ranger /root/.config/ranger/rc.conf


# Initialize ROS2 workspace
RUN mkdir -p /root/ros2_ws/src
WORKDIR /root/ros2_ws
RUN colcon build
WORKDIR /root/ros2_ws/src

# Add some lines in .bashrc
RUN echo "" >> ~/.bashrc
RUN echo 'parse_git_branch() {' >> ~/.bashrc && \
    echo '    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1)/"' >> ~/.bashrc && \
    echo '}' >> ~/.bashrc

RUN echo 'PS1="\[\e[0;31m\][\u]\[\e[m\] \[\e[0;32m\]\w\[\e[m\] \$(parse_git_branch)\[\e[00m\]\n$ "' >> ~/.bashrc

RUN echo "" >> ~/.bashrc
RUN echo "source /opt/ros/${ROS2_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source /root/ros2_ws/install/local_setup.bash" >> ~/.bashrc

# Install gazebo_harmonic
FROM ros2 as ign_gazebo

# Install Gazebo
RUN apt-get update
RUN apt-get install ros-${ROS2_DISTRO}-ros-gz -y

# Install ros2 libraries
RUN apt-get install -y \
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

WORKDIR /root/ros2_ws
RUN rosdep init
RUN rosdep update
RUN rosdep install -r --from-paths src -i -y --rosdistro ${ROS2_DISTRO}

CMD ["bash"]
