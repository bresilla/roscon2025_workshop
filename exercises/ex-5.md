# Exercise 4 - Access Control

Sometimes we just don't want to expose all the topics to the network for both bandwidth and security issue. The Access Control in Zenoh can help us filter the traffic.

You can add the following configuration to `ROUTER_CONFIG.json5` for the robot container, which deny the image topic to pass through the Zenoh Router. After restarting the Zenoh Router, you can see that the image on the Rviz will not be updated anymore.

```json5
access_control: {
  "enabled": true,
  "default_permission": "allow",
  "rules":
  [
    {
      "id": "rule1",
      "messages": [
        "put", "delete", "declare_subscriber",
        "query", "reply", "declare_queryable",
        "liveliness_token", "liveliness_query", "declare_liveliness_subscriber",
      ],
      "flows":["egress","ingress"],
      "permission": "deny",
      "key_exprs": [
        "*/camera/image_raw/**"
      ],
    },
  ],
  "subjects":
  [
    {
      "id": "subject1",
    },
  ],
  "policies":
  [
    {
      "id": "policy1",
      "rules": ["rule1"],
      "subjects": ["subject1"],
    },
  ]
},
```

Remember to remove the configuration after finishing the exercise.

---
[Next exercise ➡️](ex-6.md)
