#!/bin/bash

#Downloads packages and builds
mkdir -p rvmi_ws/src && cd rvmi_ws
wstool init src https://raw.githubusercontent.com/RVMI/rvmi_workspace_setup/master/config/arm_motion_base.rosinstall
rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y
catkin build
source ~/rvmi_ws/devel/setup.bash
roscd rvmi_workspace_setup/script
cp ./setup_ros_bash.sh ~

#Setup ROS sourcing
string="source ~/setup_ros_bash.sh"
temp=$(cat ~/.bashrc | grep "$string")
if [ -z "$temp" ]; then
	echo $string >> ~/.bashrc
	echo "Printing string in .bashrc: $string"
else
	echo "No string added to bashrc (it is already there)"
fi

#Setup python requirements
roscd skiros2/..
pip install -r requirements.txt
sh ./skiros2/scripts/install_fd_task_planner.sh

roscd skills_sandbox/..
pip install -r requirements.txt