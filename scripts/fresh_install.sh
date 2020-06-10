#!/bin/bash
#Automatically select ROS version and install

function get-ubuntu-release
{
    . /etc/lsb-release
    echo $DISTRIB_RELEASE
}

function check-pkg-installed
{
    if [ $# -eq 0 ]; then
        echo "Please specify package name" 1>&2
        exit -1
    else
        if ! `apt list --installed 2>/dev/null | grep -iqwe ^$1`; then
            if [[ -z `apt-cache search --names-only ^$1` ]]; then
                echo "Package $1 does not exist" 1>&2
                exit -1
            fi
            return 0
        else
            return 1
        fi
    fi
}

function install-pkg
{
    if check-pkg-installed $1 -eq 0; then
        sudo apt-get install $1
    else
        echo "$1 already installed."
    fi
}

function install-pkgs
{
    for pkg in $*; do
        install-pkg $pkg
    done
}

#MAIN------------------------

ubuntu_release=$(get-ubuntu-release)
PYTHON=python
if [[ $ubuntu_release == *"20.04"* ]]; then
    ROS_DISTRO="noetic"
    PYTHON=python3
elif [[ $ubuntu_release == *"18.04"* ]]; then
    ROS_DISTRO="melodic"
elif [[ $ubuntu_release == *"16.04"* ]]; then
    ROS_DISTRO="kinetic"
else
    echo "Ubuntu release not supported: $ubuntu_release"
    exit -1
fi

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update

#ROS install
if check-pkg-installed ros-$ROS_DISTRO-desktop -eq 0; then
    sudo apt install ros-$ROS_DISTRO-desktop
    install-pkg $PYTHON-rosdep
    sudo rosdep init
    rosdep update
    echo "ROS $ROS_DISTRO installed."
else
    echo "ROS $ROS_DISTRO already installed."
fi

#ROS compilation utils and pip
install-pkgs $PYTHON-wstool $PYTHON-pip
if [[ $ROS_DISTRO == "noetic" ]]; then
    $PYTHON -m pip install --user git+https://github.com/catkin/catkin_tools.git
else
    install-pkg $PYTHON-catkin-tools
fi
