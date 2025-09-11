# Exercise 1 - Zenoh router and ROS nodes

The primary role of the Zenoh router is to act as a discovery service for ROS nodes running on the same host.
When a node starts, it automatically tries to connect to the local Zenoh router. If the connection fails, the node waits until the router becomes available. The router shares the locators (IP + port) of each node with others, allowing them to automatically establish peer-to-peer connections. Once nodes are connected, they no longer need the router to communicate with each other.

## Simple Talker/Listener Test

To test this, open three different terminals within the **robot** container and run the `demo_nodes_cpp` package's `talker` and `listener`:

1. Start the Zenoh router:  
  `ros2 run rmw_zenoh_cpp rmw_zenohd`
2. Run the talker:  
  `ros2 run demo_nodes_cpp talker`
3. Run the listener (it should receive messages from the talker):  
  `ros2 run demo_nodes_cpp listener`
4. Press `CTRL+C` to stop the Zenoh router. The talker and listener will continue exchanging messages without the router.

> [!NOTE]
> The router may be started after the Nodes! Each Node periodically tries to connect to the router.
> As soon as the router discovers the Nodes, it propagates their endpoints to each other via a gossip protocol
> and each peer establish a direct connection with each other peer.

<p align="center"><img src="images/talker-listener.png"  height="250" alt="talker-listener"/></p>

### What's the default configuration ?

By default `rmw_zenoh` used two configuration files from its installation directory:

- `~/rmw_zenoh/install/rmw_zenoh_cpp/share/rmw_zenoh_cpp/config/DEFAULT_RMW_ZENOH_ROUTER_CONFIG.json5` for the router.
- `~/rmw_zenoh/install/rmw_zenoh_cpp/share/rmw_zenoh_cpp/config/DEFAULT_RMW_ZENOH_SESSION_CONFIG.json5` for the all the ROS nodes.

> [!NOTE]
> If you install `rmw_zenoh` from the ROS repositories, the default config files are in
> `/opt/ros/${ROS_DISTRO}/share/rmw_zenoh_cpp/config/`

Have a look to both configuration files, especially to those values:

- `connect`: configure the connections that Zenoh will try to establish.
- `listen`: configure the endpoints Zenoh listens to for incoming connections.
- `scouting`: how Zenoh discovers other Zenoh router or processes and automatically establish a connection with

### Changing the configuration files

To change the configuration, a good practice is to copy and modify the default configuration files.
This ensures that you start with a suitable baseline for you ROS distribution and `rmw_zenoh` version.

Let's copy them in preparation of the next exercises:

```bash
cp ~/rmw_zenoh/install/rmw_zenoh_cpp/share/rmw_zenoh_cpp/config/DEFAULT_RMW_ZENOH_ROUTER_CONFIG.json5 \
   /home/ubuntu/container_data/ROUTER_CONFIG.json5
cp ~/rmw_zenoh/install/rmw_zenoh_cpp/share/rmw_zenoh_cpp/config/DEFAULT_RMW_ZENOH_SESSION_CONFIG.json5 \
   /home/ubuntu/container_data/SESSION_CONFIG.json5
```

Now you can also see and edit those files also on your host in `roscon2025_workshop/container_volumes/robot_container/`.

The configuration files used by `rmw_zenoh` are set via environement variables:

- `ZENOH_ROUTER_CONFIG_URI` for the router.
- `ZENOH_SESSION_CONFIG_URI` for the ROS nodes.

In both containers, your bash environment automatically sets those environment variables if the `/home/ubuntu/container_data/ROUTER_CONFIG.json5` and `/home/ubuntu/container_data/SESSION_CONFIG.json5` exist. Now that you created those files, source your `~/.bashrc` to refresh your open terminals.

### Overriding the configuration files

`rmw_zenoh` allows you to override some configuration fields defining in the `ZENOH_CONFIG_OVERRIDE` environment variable. These overrides apply to Zenoh sessions and the Zenoh router after the `ZENOH_SESSION_CONFIG_URI` or `ZENOH_ROUTER_CONFIG_URI` (if specified) has been processed.

You can specify multiple key-value pairs using the following syntax:  
`export ZENOH_CONFIG_OVERRIDE="key/path/to/field1=value1;key/path/to/field2=value2"`

For instance, to configure the multicast scouting and allow the `talker` and `listener` to discover each other without a router:

```bash
# Run the talker
ZENOH_CONFIG_OVERRIDE='scouting/multicast/enabled=true' ros2 run demo_nodes_cpp talker
# Run the listener
ZENOH_CONFIG_OVERRIDE='scouting/multicast/enabled=true' ros2 run demo_nodes_cpp listener
```

## Bonus - Service, Action and Introspection

You can also test with a ROS service:

- Server: `ros2 run demo_nodes_cpp add_two_ints_server`
- Client: `ros2 run demo_nodes_cpp add_two_ints_client`

And with an Action:

- Action server: `ros2 run action_tutorials_cpp fibonacci_action_server`
- Action client: `ros2 run action_tutorials_cpp fibonacci_action_client`

Additionally, you can use the `ros2` command-line tool to inspect the system:

- List nodes: `ros2 node list`
- List topics: `ros2 topic list`
- List services: `ros2 service list`
- List actions: `ros2 action list`

Even if the Zenoh router is stopped, the `ros2` command-line tool will continue to function.
Why?

<details>
<summary>Answer</summary>

When you run a `ros2` command for the first time, it starts the ROS 2 daemon, which is a regular ROS node. This node connects peer-to-peer with other nodes, acts as a cache of the ROS graph, and can directly respond to queries from the `ros2` command-line tool.

</details>

---
[Next exercise ➡️](ex-2.md)
