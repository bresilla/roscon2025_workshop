# Exercise 1 - Navigation2 with rmw_zenoh

The exercise shows the basic example how to run navigation2 with rmw_zenoh.

```bash
# Terminal 1
ros2 run rmw_zenoh_cpp rmw_zenohd
# Terminal 2
ros2 launch rox_bringup bringup_sim_launch.py
# Terminal 3
ros2 launch rox_navigation navigation.launch.py use_sim_time:=true
```

---
[Next exercise ➡️](ex-2.md)
