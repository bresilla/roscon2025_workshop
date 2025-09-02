<div align="center">

  <h1>🐲 Zenoh ROSCon(s) 2025 Workshop 🇬🇧 🏴󠁧󠁢󠁳󠁣󠁴󠁿 🇸🇬 🇫🇷 🇩🇪 </h1>

  <p>
    <strong> Your first steps with Zenoh as an RMW in ROS 2 </strong>
  </p>

  <p>
    <a href="https://choosealicense.com/licenses/epl-2.0/"><img alt="License EPL" src="https://img.shields.io/badge/License-EPL%202.0-blue"/></a>
    <a href="https://opensource.org/licenses/Apache-2.0"><img alt="License EPL" src="https://img.shields.io/badge/License-Apache%202.0-blue.svg"/></a>
  </p>

<sub>Built by the <a href="https://zenoh.io">Zenoh</a> team at <a href="https://www.zettascale.tech">ZettaScale</a> with ❤️</sub>
</div>

## About

Welcome! This repository is part of the `ROS 2 Networking Redefined: Deep Dive into RMW Zenoh` workshops, scheduled to take place at several ROSCons in 2025:

* [ROSCon UK](https://roscon.org.uk/2025/) 🇬🇧 🏴󠁧󠁢󠁳󠁣󠁴󠁿, on September 16th
* [ROSCon Singapore](https://roscon.ros.org/2025/) 🇸🇬, on October 27th
* [ROSCon FR & DE](https://roscon.ros.org/fr/2025/) 🇫🇷 🇩🇪, on November 18th

It contains all the resources you’ll need to get started with `rmw_zenoh`, the Zenoh middleware for `ROS 2`.

In this hands-on workshop, you’ll explore how to leverage Zenoh as a ROS 2 middleware (RMW) layer. Whether you're new to Zenoh or looking to deepen your understanding of it, this workshop is designed to give you practical insights through simple demonstrations.

What's Included:

* Some [introduction slides](Introduction_slides.pdf) showing an overview of both Zenoh and `rmw_zenoh`.
* Dockerized environment: Pre-configured for easy setup and reproducibility.
* Simple ROS 2 applications: Designed to showcase the use of rmw_zenoh.
* Scripts and utilities: Simplifying container management, environment setup and configuration files.

Get ready to dive into the exciting world of ROS 2 networking with Zenoh!

## Setup

This workshop runs entirely within Docker containers, so you’ll need a host machine with Docker installed. Both `amd64` and `arm64` architectures are supported.

### Docker image installation

The easiest way to get the image is by pulling it from Docker Hub:

```bash
docker pull zettascaletech/roscon2025_workshop
```

Alternatively, you can clone this repository and build the image yourself using the provided `build_image.sh` script. By default, the image will be named roscon2025_workshop, or you can specify a different name by setting the $IMAGE_NAME environment variable.

```bash
./docker/build_image.sh
```

The image includes ROS 2 Jazzy Jalisco (core) with pre-installed demo ROS 2 packages. The ROS environment, ready to use `rmw_zenoh` and demos is automatically set up when you start a bash session (for details see the `~/workshop_env.bash` file which is sourced by `~/.bashrc`).

### Using the Docker Container

The docker directory contains several scripts to help manage the container:

* Run [`./docker/create_container.sh`](docker/create_container.sh) to create a container named `roscon2025_workshop`, or use the `$CONTAINER_NAME` environment variable to specify a custom name.
  Once created, you can open a VNC view on container's desktop on http://localhost:6080/
* Run [`./docker/login_container.sh`](docker/login_container.sh) to start a bash shell inside the container
* Run [`./docker/restart_container.sh`](docker/restart_container.sh) to restart the container
* Run [`./docker/stop_container.sh`](docker/stop_container.sh) to stop the container
* Run [`./docker/rm_container.sh`](docker/rm_container.sh) to delete the container
* Run [`./docker/rm_image.sh`](docker/rm_image.sh) to delete the Docker image

### (Optional) Using `docker compose` to simplify the process

[docker compose](https://docs.docker.com/compose/install/) is a tool to running multiple containers at once. We can use this to run two containers for the exercises later.

```bash
cd docker
docker compose up
```

Now you can access two containers with http://localhost:6080/ and http://localhost:6081/
Stop the containers after finishing the exercises.

```bash
cd docker
docker compose down
```

## Exercises

### [Exercise 1 - Navigation2 with rmw_zenoh](exercises/ex-1.md)

### [Exercise 2 - Enable shared memory in rmw_zenoh](exercises/ex-2.md)

### [Exercise 3 - Run rviz2 to visualize the remote robot](exercises/ex-3.md)

### [Exercise 4 - Access Control](exercises/ex-4.md)

### [Exercise 5 - Downsampling](exercises/ex-5.md)

### [Exercise 6 - Adjust the QoS & Priority of topics](exercises/ex-6.md)

### [Exercise 7 - Traverse the Internet](exercises/ex-7.md)
