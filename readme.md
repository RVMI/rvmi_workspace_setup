RVMI workspace setup
=======

### Fresh install
First [Install ROS](http://wiki.ros.org/)

If you want to use SSH:  
[Create a new SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)  
[Adding an SSH Key to your github account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)  

Then the wstools and catkin-tools:
> sudo apt-get install python-wstool python-catkin-tools

Create new workspace:
> cd ~  
> mkdir rvmi_ws  
> cd rvmi_ws  

Initialize your workspace:

> wstool init src https://raw.githubusercontent.com/RVMI/rvmi_workspace_setup/master/config/arm_motion_base.rosinstall

You can replace arm_motion_base.rosinstall with different configurations (have a look into config folder for all the options):  

* *arm_motion_base.rosinstall*: robot drivers, description, low_level_logic and skiros
* *skiros_examples.rosinstall*: skiros plus skills examples

Install the dependencies:
> rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y

Build the workspace:
> catkin build

Source the workspace (this line should be added also to your bash configuration ~/.bashrc):
> source ~/rvmi_ws/devel/setup.bash

### Bash commands

After running catkin build some bash commands will be available (check them out typing rvmi and tab). For example, you can run *rvmi update* to git pull all packages.

