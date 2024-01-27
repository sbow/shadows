import cv2
import os
import time
import threading
import json
import matplotlib.pyplot as plt
from IPython import display

# Load machine parameters from JSON file
#with open('./machine_params.json', 'r') as file:
with open('./cameraproj/machine_params.json', 'r') as file:
    machine_params= json.load(file)

# Extract parameters
username_str = machine_params.get('username', '')
password_str = machine_params.get('password', '')
camera_info = machine_params.get('rtsp_urls', {})

# Construct RTSP URLs
rtsp_urls_dic = {cam: f'rtsp://{username_str}:{password_str}@{ip}' for cam, ip in camera_info.items()}

# Set params
os.environ["OPENCV_FFMPEG_CAPTURE_OPTIONS"] = "rtsp_transport;udp"
rtsp1 = rtsp_urls_dic['camera_1'] 
rtsp = rtsp_urls_dic['camera_2'] 
pause_time = 0.2 # seconds between frames

# Multi threading : shared dictionary for image frames
frames = {}
frames_lock = threading.Lock()

def getPicture(url, cam_name):      
    cam = cv2.VideoCapture(url)
    a=cam.get(cv2.CAP_PROP_BUFFERSIZE)
    cam.set(cv2.CAP_PROP_BUFFERSIZE,3)
    start_frame_number = 20
    cam.set(cv2.CAP_PROP_POS_FRAMES, start_frame_number)

    print("buffer"+str(a))

    while True:        
        ret, frame = cam.read()
        small_frame = cv2.resize(frame, (0, 0), fx=.50, fy=.50)
        small_frame = cv2.cvtColor(small_frame,cv2.COLOR_BGR2GRAY)

        with frames_lock:
            frames[cam_name] = small_frame
        
        time.sleep(pause_time)

    # When everything done, release the video capture object
    cam.release()

if __name__ == '__main__':
    # Start camera threads
    threads = []
    for cam_name, rtsp_url in rtsp_urls_dic.items():
        t = threading.Thread(target=getPicture, args=(rtsp_url, cam_name))
        t.start()
        threads.append(t)

    # Display loop in main thread
    plt.ion()
    try:
        while True:
            with frames_lock:
                for cam_name, frame in frames.items():
                    plt.imshow(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
                    plt.title(cam_name)
                    plt.show()
                    display.clear_output(wait=True)
            time.sleep(pause_time)
    except KeyboardInterrupt:
        print("Stopping display loop...")

    # Wait for all threads to finish
    for t in threads:
        t.join()

    print("All threads finished.")