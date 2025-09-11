# Exercise 3 - Run rviz2 to visualize the remote robot

It's common to visualize the robot from other host. The exercise will guide you how to visualize your robot remotely.

## robot container

1. Run the router:
   `just router`
2. Run the simulation:
   `just rox_simu`
3. Run the navigation2:
   `just rox_nav2`  

## control container

1. Copy the Zenoh Config to container_data, just as we did in the robot container before. Remember `source ~/.bashrc` in the open terminal.

   ```bash
   cp ~/rmw_zenoh/install/rmw_zenoh_cpp/share/rmw_zenoh_cpp/config/DEFAULT_RMW_ZENOH_ROUTER_CONFIG.json5 \
      /home/ubuntu/container_data/ROUTER_CONFIG.json5
   cp ~/rmw_zenoh/install/rmw_zenoh_cpp/share/rmw_zenoh_cpp/config/DEFAULT_RMW_ZENOH_SESSION_CONFIG.json5 \
      /home/ubuntu/container_data/SESSION_CONFIG.json5
   ```

2. Update the `SESSION_CONFIG.json5` in container_data. Update the mode to `client` and add `"tcp/172.1.0.2:7447"` to `connect/endpoint` section.

3. Run the simulation:
   `just rviz_nav2`

## Experiments

* What will happen if we stop the Zenoh Router?
  * The rviz2 will stop working. That means the ROS messages need to pass through the Zenoh Router.
* Why do we need to configure the mode to `client`? What will happen if we keep using `peer`?
  * By default, the `peers_failover_brokering` is disabled in Zenoh router to avoid unnecessary connections, but it stops forwarding messages between containers.

---
[Next exercise ➡️](ex-5.md)
