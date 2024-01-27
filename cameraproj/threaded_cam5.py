import cv2
import numpy as np
import matplotlib.pyplot as plt
from IPython.display import display, Image
import picologging as logging
import json
import subprocess

# Load machine parameters from JSON file
with open('./cameraproj/machine_params.json', 'r') as file:
    machine_params = json.load(file)

# Extract parameters
username_str = machine_params.get('username', '')
password_str = machine_params.get('password', '')
camera_info = machine_params.get('rtsp_urls', {})

# Construct RTSP URLs
rtsp_urls_dic = {cam: f'rtsp://{username_str}:{password_str}@{ip}' for cam, ip in camera_info.items()}

# Set up logging
logger = logging.getLogger('CameraCaptureLogger')
logger.setLevel(logging.DEBUG)
file_handler = logging.FileHandler('camera_capture.log', mode='w', encoding='utf-8')
formatter = logging.Formatter('%(relativeCreated)s - %(name)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)

# Function to display an image in a Jupyter notebook
def display_image(frame):
    _, encoded_image = cv2.imencode('.png', frame)
    display(Image(data=encoded_image))

# Function to capture a frame using ffmpeg
def capture_frame(rtsp_url):
    try:
        command = ['ffmpeg', '-i', rtsp_url, '-frames:v', '1', '-f', 'image2pipe', '-vcodec', 'png', '-']
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)

        frame = np.frombuffer(result.stdout, np.uint8)
        frame = cv2.imdecode(frame, cv2.IMREAD_COLOR)

        if frame is not None:
            return frame
        else:
            logger.error("Failed to capture frame: " + result.stderr.decode())
            return None
    except Exception as e:
        logger.error(f"Error capturing frame: {str(e)}")
        return None

# Modify capture_all_frames to use the RTSP URL directly
def capture_all_frames(rtsp_urls_dic):
    frames = {}
    for camera_name_str, ip_str in rtsp_urls_dic.items():
        try:
            frame = capture_frame(ip_str)
            if frame is not None:
                frames[camera_name_str] = frame
        except Exception as e:
            print(f"Error capturing frame from {camera_name_str}: {e}")
            logger.debug(f"Failed to capture frame from {camera_name_str}")
        else:
            logger.debug(f"Frame captured from {camera_name_str}")
    return frames

# Capture and display the frame
captured_frames = capture_all_frames(rtsp_urls_dic)


# Assuming all frames are of the same size
height, width, channels = captured_frames["camera_1"].shape

# Create a blank canvas
grid_height = height * 2
grid_width = width * 2
grid_image = np.zeros((grid_height, grid_width, channels), dtype=np.uint8)

# Place each frame in the grid
grid_image[0:height, 0:width] = captured_frames["camera_1"]  # Top-left
grid_image[0:height, width:grid_width] = captured_frames["camera_2"]  # Top-right
grid_image[height:grid_height, 0:width] = captured_frames["camera_3"]  # Bottom-left
grid_image[height:grid_height, width:grid_width] = captured_frames["camera_4"]  # Bottom-right

# Display the grid image
plt.imshow(cv2.cvtColor(grid_image, cv2.COLOR_BGR2RGB))
plt.show()


meat = 'spin'