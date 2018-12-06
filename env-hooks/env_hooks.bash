
# If you change this file, please increment the version number in
# CMakeLists.txt to trigger a CMake update.

function rvmi() {
    local workspace=$(roscd && cd .. && pwd)
    case $1 in
	s|src|source)
	    cd "$workspace/src"
	    ;;
	b|build)
	    shift
	    catkin build -w "$workspace" $*
	    ;;
	l|launch)
	    shift
	    roslaunch rvmi_workspace_setup $*
	    ;;
	L|LAUNCH)
	    shift
	    rosrun rosmon rosmon --name=rosmon rvmi_workspace_setup $*
	    ;;
  u|update)
	    shift
      $(rospack find rvmi_workspace_setup)/scripts/update_workspace.sh $*
      ;;
    esac
}

function _rvmi() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local cmd="${COMP_WORDS[1]}"

    case "${COMP_CWORD}" in
	1)
	    COMPREPLY=( $(compgen -W "s source b build l launch L LAUNCH u update" -- $cur) )
	    ;;
	2)
	    local workspace=$(roscd && cd .. && pwd)

	    case "${cmd}" in
		u|update)
		    local installfiles=$(find $(rospack find rvmi_workspace_setup) -name '*.rosinstall' -type f -printf "%f\n")
		    COMPREPLY=( $(compgen -W "${installfiles}" -- $cur) )
		    ;;
		b|build)
		    local packages=$(catkin list -w ${workspace})
		    COMPREPLY=( $(compgen -W "${packages}" -- $cur) )
		    ;;
		l|launch|L|LAUNCH)
		    local launchfiles=$(find $(rospack find rvmi_workspace_setup) -name '*.launch' -type f -printf "%f\n")
		    COMPREPLY=( $(compgen -W "${launchfiles}" -- $cur) )
		    ;;
	    esac
	    ;;
	*)
	    COMPREPLY=""
	    ;;
    esac
}
complete -F _rvmi rvmi
