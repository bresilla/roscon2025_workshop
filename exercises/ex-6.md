# Exercise 6 - Adjust the QoS & Priority of topics

Not every topic is important. Some might be large but less significant, while some is very critical. Zenoh supports adding the priority for each topic.

* Emulate the restrained network

```bash
just network_limit
```

* Prioritize the topic and adjust the QoS in the config

* Restore the network

```bash
just network_normal
```

---
[Next exercise ➡️](ex-7.md)
