# Exercise 5 - Downsampling

If we want to monitor a topic and also want to reduce the traffic, downsampling the ROS messages is a good idea. Zenoh can achieve this easily.

Uncomment the downsampling configuration in the Zenoh Router config on the robot container. Then restart the Zenoh Router. We make the frequency of the camera image (The topic is `camera/image_raw`) drop to 1 Hz. You can see the image on the rviz is obviously lagging.

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
        sim1["Gazebo"] <--> zr1["Zenoh Router</br>Downsampling: 30Hz->1Hz"]
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
[Next exercise ➡️](ex-6.md)
