#!/bin/bash
#Install software dependencies

echo "This script is intended to run in the root of your catkin workspace, e.g. ~/catkin_ws. Your workspace needs to be built at least once before."

# To get access to ros commands
if ! source $( pwd )/devel/setup.bash; then
    echo "Please navigate to the root of your workspace!"
    exit -1
fi

# Planner for SkiROS2
if roscd skiros2; then
    ./scripts/install_fd_task_planner.sh
fi

# Python Dependencies
PIP="python$ROS_PYTHON_VERSION -m pip"
if roscd skiros2; then
    cd .. && $PIP install -r requirements.txt --user
fi
if roscd skills_sandbox; then
    if [[ $ROS_PYTHON_VERSION == 3 ]]; then
        $PIP install --upgrade git+https://github.com/kivy/kivy
    fi
    $PIP install -r requirements.txt --user
fi
if roscd vision; then
    if [[ $ROS_PYTHON_VERSION == 3 ]]; then
        $PIP install --upgrade git+https://github.com/emmanuelkring/pypcd.git
    fi
    $PIP install -r requirements.txt --user
fi
if roscd low_level_logics; then
    $PIP install -r requirements.txt --user
fi

# Install realsense drivers
# Currently not available on Ubuntu 20.04
# Get distribution environment variables
if [[ $ROS_PYTHON_VERSION == 2 ]]; then
    . /etc/lsb-release
    export repo="http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo"
    export repo_check="$repo $DISTRIB_CODENAME main"
    export repo_add="$repo main"
    if ! grep -q "^deb .*$repo_check" /etc/apt/sources.list /etc/apt/sources.list.d/*; then\
        sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
        sudo add-apt-repository "$repo_add" -u
    else
        echo "Realsense repo exists already."
    fi

    sudo apt update
    sudo apt install librealsense2-dkms librealsense2-utils librealsense2-dev
else
    echo "WARNING: realsense drivers are currently not available for this platform"
fi
