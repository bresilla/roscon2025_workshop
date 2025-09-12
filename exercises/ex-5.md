# Exercise 5 - Access Control

For bandwidth and security purposes, we usually don’t want to expose every topic on the network. Zenoh’s Access Control feature allows to keep specific topics and services confined to the robot.

Let’s experiment by limiting the traffic on the point cloud topic: `/camera/points`.

But at first measure the Zenoh traffic between RViz and the robot, running the same setup than the previous exercise (NOT with shared memory between containers!):

- In the robot container, run:

  - `just router`
  - `just rox_simu`
  - `just rox_nav2`

- In the control container, run:

  - `just rviz_nav2`
  - `just iftop_router`

Now, in the robot container, you can modify the `~/container_data/ROUTER_CONFIG.json5` file to add this section:  

   ```json5
   access_control: {
     enabled: true,
     default_permission: "allow",
     rules:
     [
       {
         id: "deny_points_cloud",
         // deny any kind of messages...
         permission: "deny",
         messages: [
           "put", "delete", "declare_subscriber",
           "query", "reply", "declare_queryable",
           "liveliness_token", "liveliness_query", "declare_liveliness_subscriber",
         ],
         // ... incoming or outgoing ...
         flows:["egress", "ingress"],
         // ... on any key expressions containing "/camera/points/",
         // including the specific ones with "/@adv" used for TRANSIENT_LOCAL topics
         key_exprs: [
           "*/camera/points/**",
           "*/camera/points/**/@adv/**"
         ],
       },
     ],
     subjects:
     [
       {
         // An empty subject means that the rule will apply to ALL peers/clients/routers
         id: "ALL",
       },
     ],
     policies:
     [
       {
         // Apply the rule to all
         id: "deny_points_cloud_to_all",
         rules: ["deny_points_cloud"],
         subjects: ["ALL"],
       },
     ]
   },
   ```

And restart the router in the robot container.

See the impact on the traffic and check that the points cloud are no longer received by RViz.

> [!IMPORTANT]
>
> Denying the `camera/points` topic on the router means it won't route any message for this topic. Still the nodes inside the robot can use this topic in peer-to-peer communications.

---
[Next exercise ➡️](ex-6.md)
