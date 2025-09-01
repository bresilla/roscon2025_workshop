# Exercise 3 - Run rviz2 to visualize the remote robot

It's common to visualize the robot from other host. The exercise will guide you how to visualize your robot remotely.

* Container 1

```bash
# Terminal 1
ros2 run rmw_zenoh_cpp rmw_zenohd
# Terminal 2
ros2 launch rox_bringup bringup_sim_launch.py
# Terminal 3
ros2 launch rox_navigation navigation.launch.py use_sim_time:=true
```

* Container 2
  * TODO: It might be better to use client mode here.

```bash
# Terminal 1
ros2 run rmw_zenoh_cpp rmw_zenohd
# Terminal 2
ros2 launch nav2_bringup rviz_launch.py
```

---
[Next exercise ➡️](ex-4.md)
