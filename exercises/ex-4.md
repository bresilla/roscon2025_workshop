# Exercise 4 - Access Control

Sometimes we just don't want to expose all the topics to the network for both bandwidth and security issue. The Access Control in Zenoh can help us filter the traffic.

Uncomment the ACL configuration in the Zenoh Router config on the robot container. Then restart the Zenoh Router. We don't allow the image topic to pass through the Zenoh Router. You can see that the image on the Rviz will not be updated anymore.

```mermaid
---
config:
  theme: redux
  look: handDrawn
  layout: dagre
---
graph TD
subgraph Host
    subgraph Container A
        sim1["Gazebo"] <--> zr1["Zenoh Router</br>ACL: deny image"]
        nav1["Navigation2"] <--> zr1
        sim1 <--> nav1
    end
    subgraph Container B
        rv2["RViz2"] <--> zr2["Zenoh Router"]
    end
    zr1 <--> zr2
end
```

---
[Next exercise ➡️](ex-5.md)
