#!/bin/bash

# Setup OneDrive mapping on linux
# ... also many cloud storage

# Install rclone
sudo apt install rclone

rclone config


# Example post install / config setup
#
# Follow auto unless sure
#
#  1813  rclone config
#  1814  mkdir GoogleDrive
#  1815  rclone --vfs-cache-mode writes mount googledrive: ~/mnt/GoogleDrive &
#  1816  rclone config
#  1817  mkdir GooglePhotos
#  1818  rclone --vfs-cache-mode writes mount googlephotos: ~/mnt/GooglePhotos &
#  1819  ls

