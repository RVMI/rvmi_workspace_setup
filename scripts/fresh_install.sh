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
        if `apt list --installed 2>/dev/null | grep -iqwe ^$1/`; then
            if `apt list 2>/dev/null | grep -iqwe ^$1/`; then
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
    if [ $# -eq 0 ]; then
        echo "Please specify package name" 1>&2
        exit -1
    else
        if `apt list --installed 2>/dev/null | grep -iqwe ^$1/`; then
            if `apt list 2>/dev/null | grep -iqwe ^$1/`; then
                echo "Package $1 does not exist" 1>&2
                exit -1
            else
                sudo apt-get install $1
            fi
        else
            echo "$1 already installed."
        fi
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
if [[ $ubuntu_release == *"18.04"* ]]; then
  ROS_DISTRO="melodic"
elif [[ $ubuntu_release == *"16.04"* ]]; then
  ROS_DISTRO="kinetic"
else
  echo "Ubuntu release not supported: $ubuntu_release"
  exit -1
fi

#ROS install
if check-pkg-installed ros-$ROS_DISTRO-desktop -eq 0; then
  sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
  sudo apt update
  sudo apt install ros-$ROS_DISTRO-desktop
  sudo rosdep init
  rosdep update
  sudo apt install python-wstool python-catkin-tools
else
  echo "ROS $ROS_DISTRO already installed."
fi

#ROS compilation utils
install-pkgs python-catkin-tools python-wstool
