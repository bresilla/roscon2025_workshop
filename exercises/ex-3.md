# Exercise 3 - Shared Memory

With the default configuration `rmw_zenoh` is using TCP over the loopback interface for inter-processes communication. Enabling shared memory allows to get lower latency for big messages (>512 bytes).

The usage of shared memory with `rmw_zenoh` is fully transparent to your ROS applications:

- No need of a daemon to managed the shared memory.
- No need of loaned buffers - when enabled, `rmw_zenoh` serializes big messages directly in shared memory.
- If shared memory cannot be used (allocation fails or remote peer doesn't use shared memory), Zenoh automatically falls back to TCP.
- Zenoh automatically performs garbage collection and defragmentation of shared memory chunks.
- If a shared memory file is not correctly cleaned up (crash), any router or Zenoh session will cleanup the dangling files at next startup.

## Measuring the latency

To measure the benefit of shared memory, we will first measure the latency of the points cloud publication with the default configuration.

1. Run the router:  
   `just router`
2. Run the simulation, using wall time (i.e. system clock) for timestamping:  
   `just rox_simu use_wall_time:=True`
3. Run a Node measuring the points cloud latency:  
   `just cam_latency`  
   You can also measure the images latency running:  
   `just cam_latency image`

## Configuring shared memory

While enabling shared memory for all processes is not mandatory, it is highly beneficial.  
Therefore, the simplest is to edit your 2 configuration files `~/container_data/ROUTER_CONFIG.json5` and `~/container_data/SESSION_CONFIG.json5` to search for the `shared_memory` section and set `enabled: true` within:

```json5
   // ...

    /// Shared memory configuration.
    /// NOTE: shared memory can be used only if zenoh is compiled with "shared-memory" feature, otherwise
    /// settings in this section have no effect.
    shared_memory: {
      /// Whether shared memory is enabled or not.
      /// ...
      enabled: true,

      // ...
    },

   //...
```

After that, execute the previous commands once more and see the difference in latency.

You can confirm shared memory is enabled by listing the files in `/dev/shm` each `.zenoh` file corresponds to a shared memory allocated by a Zenoh process.

> [!Note]
>
> ***Is it possible to use shared memory between containers ?***
>
> *Yes! But first let's see how to establish communication across containers and hosts in the next exercise...*

---
[Next exercise ➡️](ex-4.md)
