# Exercise 5 - Access Control

For bandwidth and security purposes, we usually don’t want to expose every topic on the network. Zenoh’s Access Control feature lets us keep specific topics and services confined to the robot.

Let's restrict the deny traffic on `camera/points` topic for points cloud data for instance.  
Starting from the previous exercise setup (NOT with shared memory between containers), keep running the router, the simulation and Navigation2 in the robot container and Rviz in the contraoller container.

1. In the robot container, modify the `~/container_data/ROUTER_CONFIG.json5` file to add this section:  

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

2. Restart the router on the robot:  
`just router`

3. See in RViz that the points cloud are no longer received.

> [!IMPORTANT]
>
> Denying the `camera/points` topic on the router means it won't route any message for this topic. Still the nodes inside the robot can use this topic in peer-to-peer communications.

---
[Next exercise ➡️](ex-6.md)
