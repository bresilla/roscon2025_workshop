# Exercise 3 - Run rviz2 to visualize the remote robot

It's common to visualize the robot from other host. The exercise will guide you how to visualize your robot remotely.

* Container 1

```bash
# Terminal 1
just router
# Terminal 2
just rox_simu
# Terminal 3
just rox_nav2
```

* Container 2
  * TODO: It might be better to use client mode here.

```bash
# Terminal 1
just router
# Terminal 2
just rviz_nav2
```

---
[Next exercise ➡️](ex-4.md)
