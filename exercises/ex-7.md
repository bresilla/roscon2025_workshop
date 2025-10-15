# Exercise 7 - Cope with congestion and head of line blocking

Head-of-line blocking occurs when large messages (such as images or point clouds) delay the transmission of smaller, time-sensitive data (like control commands or status updates) in the same communication channel. This can introduce unacceptable latency for critical operations, especially over constrained networks.

For all topics except those with TRANSIENT_LOCAL + KEEP_ALL QoS, `rmw_zenoh` is configured with congestion control `drop`. Meaning that in case of congestion, Zenoh will drop the messages it can't push to the network after a timeout (see `transport/link/tx/queue/congestion_control/drop` config). On a congested network, the push of large messages will probably always exceed the timeout and hence always be dropped.  

What you likely want in such case is to at least have one large message from time to time, but not impacting the latency of small messages. The solution for this if to make the router to change on-the-fly the QoS of large messages to:

* Change the Zenoh `congestion_control` QoS from `drop` to `block_first`. With this QoS Zenoh will block on the first message to be pushed to the network and drop the other ones until this first message it sent. Thus at lease some large messages manage to be transmitted.
* Lower the priority of large messages, to keep higher priority for smaller messages.

Let's experiment this configuration on a simulated WiFi connection connection between the two containers:

1. In robot container, limit the network traffic with the control container running:  
   `just network_limit`  
   You can check it's effective with a ping to the control container:  
   `ping 172.1.0.3`

2. In the robot container, run:

   * `just router`
   * `just rox_simu`
   * `just rox_nav2`

3. In the control container, run:  
   `just rviz_nav2`

You can see that RViz doesn't receive any camera image.

Now, in robot container's `~/container_data/ROUTER_CONFIG.json5` file, add the following QoS section:

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

And restart the robot's router. You should see the images received in RViz now.

To restore the network back, run `just network_normal`

---
[Solution](solutions/ex-7/) 💡

[Next exercise ➡️](ex-8.md)
