import time

from picamera2 import Picamera2
from picamera2.encoders import H264Encoder
from picamera2.outputs import FfmpegOutput


picam2 = Picamera2()
picam2.configure(picam2.create_video_configuration())

encoder = H264Encoder(repeat=True, iperiod=15)
encoder.output = FfmpegOutput("-f mpegts udp://0.0.0.0:12345")

picam2.start_encoder(encoder)
picam2.start()

# Loop infinitely
while True:
    time.sleep(1)
