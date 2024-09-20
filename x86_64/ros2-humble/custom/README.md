# Guideline for Local Setup

**Step 1. Build the Dockerfile**
```
docker build -t aims_fly/ros:humble-desktop .
```

**Step 2. Run the Docker Container**
```
bash docker_run.sh <v1,2,3...> aims_fly/ros:humble-desktop
```

**Step 3. Check Whether GUI is Available**

```
xclock
```