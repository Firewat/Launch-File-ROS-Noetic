#!/usr/bin/env bash
set -euo pipefail

PI_ROLE="${1:-pi1}"
ROS_MASTER_HOST="${2:-pi1.local}"
ROS_DISTRO="noetic"
ROS_WS="/home/pi/ros_ws"

export ROS_MASTER_URI="http://${ROS_MASTER_HOST}:11311"
export ROS_HOSTNAME="$(hostname -s).local"

source "/opt/ros/${ROS_DISTRO}/setup.bash"
source "${ROS_WS}/devel/setup.bash"

exec roslaunch robot_bringup robot_master.launch pi_role:="${PI_ROLE}" ros_master_host:="${ROS_MASTER_HOST}"
