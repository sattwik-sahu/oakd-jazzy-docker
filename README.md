# OAK-D ROS2 Jazzy

Get the OAK-D RGBD Camera up and running with ROS2 Jazzy!

## Installation

1. Pull the image from Docker Hub and clone the helper repo
    ```bash
    docker pull sattwik21/oakd-jazzy:v1.0.2
    git clone git@github.com:sattwik-sahu/oakd-jazzy-docker.git       # Git clone using SSH
    git clone https://github.com/sattwik-sahu/oakd-jazzy-docker.git   # Git clone using HTTPS
    cd oakd-jazzy-docker
    ```
2. Set the `DISPLAY` environment variable and **allow Docker to access the display server** (on X11 display environment)
    ```bash
    export DISPLAY=:0   # or :1
    xhost +local:docker
    ```
3. Allow executable permissions to the scripts
    ```bash
    sudo chmod u+x ./scripts/*.sh
    ```
4. Run the container
    ```bash
    ./scripts/start_container.sh $OAKD_CONTAINER_NAME
    ```
5. Connect to the container's terminal
    ```bash
    ./scripts/connect_container.sh $OAKD_CONTAINER_NAME
    ```

> Either set the environment variable by `export OAKD_CONTAINER_NAME=<your-container-name>` or replace `$OAKD_CONTAINER_NAME` in the above command with the container name.

## Usage

### Connect the OAK-D Camera

- Connect the [OAK-D camera](https://shop.luxonis.com/products/oak-d?srsltid=AfmBOoqHXc1_1GaBGmXg64BifbYKK67BzZnEAHjXfYNZaTucdE2CGG0M) (prefereably using the USB cord provided by [Luxonis](https://www.luxonis.com/)), to the computer (`x86_64` or `amd64` architecture; embedded systems require a commercial license to run the [SpectacularAI](https://www.spectacularai.com/) library used for VIO).
- The USB should be connected to a **super-speed USB _aka_ USB 3.0 port**. Check if the inner parts of the port are *blue*.

> :pencil: Learn more about [super speed usb ports](https://www.techtarget.com/searchwindowsserver/definition/USB-30-SuperSpeed-USB) and [computer architectures](https://en.wikipedia.org/wiki/Computer_architecture)

### Enter the Container Terminal

After running the above commands in the terminal, you should be in the container's terminal. If retrying after a reboot, you need to restart the container and connect to it again using
```bash
docker container start $OAKD_CONTAINER_NAME
./scripts/connect_container.sh $OAKD_CONTAINER_NAME
```

### Activate ROS2 and Run the Node

To run the [ROS2 Jazzy](https://docs.ros.org/en/jazzy/index.html) node and visualize the topics, follow the steps below in the container terminal.

1. Source ROS2
    ```bash
    source /opt/ros/$ROS_DISTRO/setup.zsh
    ```
2. Enter the `oakd-ros` project and activate the virtual environment
    ```bash
    cd /root/oakd-ros
    source ./venv/bin/activate
    ```
3. Update the Python packages using the [`uv Python dependency manager`](https://docs.astral.sh/uv/)
    ```bash
    uv sync
    ```
4. Run the `oakd-ros` command to check everything is fine
    ```bash
    oakd-ros
    ```
    > You should see the output `Welcome to OAK-D with ROS2!` without any errors.
5. Start the ROS2 node
    ```bash
    oakd-ros ros run
    ```

### Visualize the topics

1. Open rviz2 by connecting to the container in another terminal tab/window using the [`connect_container.sh`](./scripts/connect_container.sh) script as shown above. Make sure to source ROS2 also.
    ```bash
    rviz2
    ```
    If the window does not open, try changing the `DISPLAY` environment variable to some other number.
2. Add the topics described below to view in RVIZ2.

| Topic | Description |
| ----- | ----------- |
| `/slam/rgb` | The RGB camera feed. Resolution: `640 x 400` |
| `/slam/odometry` | The VIO output from [SpectacularAI for OAK-D](https://spectacularai.github.io/docs/sdk/wrappers/oak.html) |
| `/slam/pointcloud` | The pointcloud from constructed by the OAK-D camera |
| `/slam/depth` | The depth image from the OAK-D camera |

Now that you have the topics, read them in another node and create awesome projects!

> You may want to install [`tmux`](https://github.com/tmux/tmux/wiki) in the container. Advanced users may use it to multiplex terminals inside the container itself without creating more terminal instances on the host. Here is a [quick guide](https://hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/) to use `tmux`.

## Contributing

Create an issue to request a feature.

---

Made with :heart: in [MOON Lab](https://moonlab.iiserb.ac.in) @ [IISER Bhopal](https://iiserb.ac.in).

