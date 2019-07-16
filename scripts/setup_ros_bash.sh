alias resource='source ~/.bashrc'
alias synctime='sudo ntpdate -b -u 192.168.1.2'

#setrosmaster(IP) Set the rosmaster IP
setrosmaster() {
  if [ -z "$1" ]
    then
      export ROS_MASTER_URI=http://localhost:11311
    else
      export ROS_MASTER_URI=http://$1:11311
  fi
  echo Ros master at: $ROS_MASTER_URI
}

catkin_path_get_func() {
	cat ~/.catkin_path
}
catkin_path_save_func() {
  echo -n $1 > ~/.catkin_path
  echo ROS workspace set to: $1
  source $1/devel/setup.bash
}
alias setrvmi='catkin_path_save_func ~/ros_ws/rvmi_ws'

#Setup ROS
export ROS_WORKSPACE=~/ros_ws
export CATKIN_WORKSPACE=$(catkin_path_get_func)
export ROS_IP=$(hostname -I | cut -d ' ' -f1)
echo Computer ip: $ROS_IP

#setrosmaster 10.0.0.3
echo Ros master at: $ROS_MASTER_URI

#Source ROS
source /opt/ros/kinetic/setup.bash
source $CATKIN_WORKSPACE/devel/setup.bash