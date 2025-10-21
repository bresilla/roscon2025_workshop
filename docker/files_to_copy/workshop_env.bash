# If built from sources, setup rmw_zenoh environment
if [ -f ~/rmw_zenoh/install/setup.bash ]; then
    source ~/rmw_zenoh/install/setup.bash
fi
export RMW_IMPLEMENTATION=rmw_zenoh_cpp

# If some configuration files exist in ~/container_data define the rmw_zenoh environment variables
if [ -f ~/container_data/ROUTER_CONFIG.json5 ]; then
    export ZENOH_ROUTER_CONFIG_URI=~/container_data/ROUTER_CONFIG.json5
    echo "  ZENOH_ROUTER_CONFIG_URI=$ZENOH_ROUTER_CONFIG_URI"
fi
if [ -f ~/container_data/SESSION_CONFIG.json5 ]; then
    export ZENOH_SESSION_CONFIG_URI=~/container_data/SESSION_CONFIG.json5
    echo "  ZENOH_SESSION_CONFIG_URI=$ZENOH_SESSION_CONFIG_URI"
fi

# Tune SHM allocated space
# The biggest payload here is the Realsense D435 point cloud: 7.37 MB
# Let's allocate 24 MB to allow 3 in-flight data in SHM (2 could be enough if the Subscriber is fast enough, but it's a VM...)
export ZENOH_SHM_ALLOC_SIZE=25165824

# setup Neobotix ROX simulation environment
source ~/rox_ws/install/setup.bash
GZ_SIM_RESOURCE_PATH=~/rox_ws/src/rox:~/rox_ws/src/neo_gz_worlds/models/

# set other useful variables
export RCUTILS_CONSOLE_OUTPUT_FORMAT="[{severity} {time}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})"
export RCUTILS_COLORIZED_OUTPUT=1
