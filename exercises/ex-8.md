# Exercise 8 - Traverse the Internet

If both your robot and rviz are behind the NAT, it's difficult to connect them together. This is not an issue for Zenoh. We can easily add a Zenoh router to traverse the Internet.

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
        sim1["Gazebo"] <--> zr1["Zenoh Router"]
        nav1["Navigation2"] <--> zr1
        sim1 <--> nav1
    end
    subgraph Container B
        rv2["RViz2"] <--> zr2["Zenoh Router"]
    end
end
subgraph Cloud
    zr3["Zenoh Router"]
end
zr1 <-- data / discovery --> zr3
zr2 <-- data / discovery --> zr3
```
