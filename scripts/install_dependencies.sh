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
if roscd skiros2; then
    cd .. && python -m pip install -r requirements.txt --user
fi
if roscd skills_sandbox; then
    python -m pip install -r requirements.txt --user
fi
if roscd vision; then
    python -m pip install -r requirements.txt --user
fi
if roscd low_level_logics; then
    python -m pip install -r requirements.txt --user
fi

# Install realsense drivers
# Get distribution environment variables
. /etc/lsb-release
export repo="http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo $DISTRIB_CODENAME main"
if ! grep -q "^deb .*$repo" /etc/apt/sources.list /etc/apt/sources.list.d/*; then\
    sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
    sudo add-apt-repository "$repo" -u
else
    echo "Realsense repo exists already."
fi

sudo apt update
sudo apt install librealsense2-dkms librealsense2-utils librealsense2-dev
