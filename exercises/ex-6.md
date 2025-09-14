# Exercise 6 - Cope with congestion and head of line blocking

With a poor network connection (e.g. 2.4GHz WiFi with radio disturbance), the TCP connection with the robot get congested. For all topics except those with TRANSIENT_LOCAL + KEEP_ALL QoS, `rmw_zenoh` is configured with congestion control `drop`. Meaning that in case of congestion, Zenoh will drop the messages it can't push to the network socket.

Let's experiment by simulating a WiFi connection connection between the two containers:

1. Stop Rviz in the control container

2. In robot container, limit the network traffic with the control container running:  
   `just network_limit`



Some topic is large but less significant. The drop of those data is allowed, but we still want to receive them with low priority.
However, when the network quality is bad, the data can't even send out because some of the fragments is dropped.
We can adjust congestion control to at least keep only one message, so the receiver side can receive it.

* Emulate the restrained network

   ```bash
   just network_limit
   ```

* Camera image can't be loaded on the remote rviz2.

* Add the following QoS section into the `ROUTER_CONFIG.json5` in the robot container.

   ```json5
   qos: {
     network: [
       {
         payload_size: "4096..",
         messages: ["put"],
         overwrite: {
             congestion_control: "block_first",
             priority: "data_low",
         }
       },
     ],
   },
   ```

* Now we can see the camera image is shown now.

* Restore the network

   ```bash
   just network_normal
   ```

---
[Next exercise ➡️](ex-7.md)
