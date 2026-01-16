# Launch-File-ROS-Noetic
1) Pick IPs (or hostnames)
- VM1 IP (master): 192.168.1.10
- VM2 IP: 192.168.1.11
- Verify: ping 192.168.1.10 from VM2 and vice‑versa.
2) Install ROS Noetic on both VMs
- sudo apt update
- sudo apt install ros-noetic-desktop-full
3) Set up catkin workspace (both VMs)
mkdir -p ~/ros_ws/src
cd ~/ros_ws
catkin_make
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
4) Clone your repo (both VMs)
cd ~/ros_ws/src
git clone <YOUR_REPO_URL>
5) Update the master launch with your real packages
Edit:
- ~/ros_ws/src/<your_repo>/robot_bringup/launch/robot_master.launch
Replace the placeholder nodes with your actual launch files. Example:
<group ns="team_movement">
  <include file="/launch/team_movement.launch" />
</group>
Repeat for each group.
6) Build (both VMs)
cd ~/ros_ws
catkin_make
source ~/ros_ws/devel/setup.bash
7) Run master on VM1
export ROS_MASTER_URI=http://192.168.1.10:11311
export ROS_HOSTNAME=192.168.1.10
roslaunch robot_bringup robot_master.launch pi_role:=pi1 ros_master_host:=192.168.1.10
8) Run pi2 + pi3 roles on VM2
export ROS_MASTER_URI=http://192.168.1.10:11311
export ROS_HOSTNAME=192.168.1.11
# pi2 role
roslaunch robot_bringup robot_master.launch pi_role:=pi2 ros_master_host:=192.168.1.10
# pi3 role (in another terminal)
roslaunch robot_bringup robot_master.launch pi_role:=pi3 ros_master_host:=192.168.1.10
9) Verify the ROS graph (from either VM)
rosnode list
rostopic list
You should see nodes under:
- /team_movement, /team_navigation, /team_signals, /points_of_interest
- /speech_in, /speech_out
- /team_monitoring, /team_display
---
Common issues + quick fixes
- rosnode list empty on VM2 → check ROS_MASTER_URI and ROS_HOSTNAME.
- No connectivity → check firewall (ufw) or wrong IP.
- Mixed ROS distros → both VMs must be Noetic.
- Duplicate node names → ensure each role launches unique node names.
