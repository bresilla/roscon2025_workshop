# Exercise 5 - Downsampling

If we want to monitor a topic and also want to reduce the traffic, downsampling the ROS messages is a good idea. Zenoh can achieve this easily.

You can add the following configuration to `ROUTER_CONFIG.json5` for the robot container, which make the frequency of the camera image (The topic is `camera/image_raw`) drop to 1 Hz. After restarting the Zenoh Router, you can see the camera image on the rviz is obviously lagging

```json5
downsampling: [
  {
    flows: ["ingress", "egress"],
    messages: [
      "push",
      "query",
      "reply"
    ],
    rules: [
      { key_expr: "*/camera/image_raw/**", freq: 5 },
    ],
  },
],
```

---
[Next exercise ➡️](ex-7.md)
