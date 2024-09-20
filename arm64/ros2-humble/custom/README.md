# Guideline for Jetson Docker Setup

**Step 1. Pull the Docker Image**
```
docker pull dustynv/ros:humble-desktop-l4t-r35.1.0
```

**Step 2. Run the Docker Container**
```
bash docker_run.sh <container_name> <image_name>:<tag_name>
```

**Step 3. Inside the container, Run the scripts file**

3-1. Run the script file (/root/install_packages.sh)

3-2. Run the script file (/root/install_ros2_px4.sh)

3-3. Source the bashrc 