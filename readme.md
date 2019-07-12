RVMI workspace setup
=======

### Fresh install
First [Install ROS](http://wiki.ros.org/)

If you want to use SSH:  
[Create a new SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)  
[Adding an SSH Key to your github account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)  

Then the wstools and catkin-tools:
> sudo apt-get install python-wstool python-catkin-tools

Create and initialize new workspace:
> cd ~  
> mkdir rvmi_ws  
> cd rvmi_ws  
> wstool init src \\  
> https://raw.githubusercontent.com/RVMI/rvmi_workspace_setup/master/config/arm_motion_base.rosinstall  
> catkin init  
> catkin config --extend /opt/ros/kinetic

You can replace arm_motion_base.rosinstall with different configurations (have a look into config folder for all the options):  

* *arm_motion_base.rosinstall*: robot drivers, bh_robot description, low_level_logic, skiros and general skills
* *vision.rosinstall*: realsense camera driver, vision packages and skills
* *skiros_examples.rosinstall*: skiros plus skills examples

Install the dependencies:
> rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y

Build the workspace:
> catkin build

Source the workspace (this line should be added also to your bash configuration ~/.bashrc):
> source ~/rvmi_ws/devel/setup.bash

In case _package_ is still missing, try to search for it:
> apt-cache search ros-kinetic-_package_  

If it exists, you can install it manually:
> sudo apt-get install ros-kinetic-_package_  

### Bash commands

After running catkin build some bash commands will be available (check them out typing rvmi and tab). For example, you can run *rvmi update* to git pull all packages.

