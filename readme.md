RVMI workspace setup
=======

### Fresh install
First [Install ROS](http://wiki.ros.org/)

If you want to use SSH:  
[Create a new SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)  
[Adding an SSH Key to your github account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)  

Then the wstools and catkin-tools:
> $ sudo apt-get install python-wstool python-catkin-tools

Create new workspace:
> $ cd ~  
> $ mkdir scalable_ws  

Initialize your workspace:

> $ cd rvmi_ws  
> $ wstool init src https://raw.githubusercontent.com/RVMI/rvmi_workspace_setup/master/config/full.rosinstall  
> $ rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y  
> $ catkin build  
> $ source devel/setup.bash  

### Updating the workspace from source
To update the workspace run:

> $ rvmi update full.rosinstall

The default rosinstall is <code>full.rosinstall</code>. See all rosinstall in <code>rvmi_workspace_setup/config</code>.

### Bash commands
Source the workspace:
> $ cd ~/scalable_ws/  
> $ source devel/setup.bash  

Build the workspace:
> $ catkin build

Run the tests:
> $ catkin run_tests

After running catkin build some bash commands will be available. (check them out typing rvmi and tab).
