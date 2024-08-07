FROM debian:testing AS build

# Install build dependencies
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        libavcodec-dev \
        libavdevice-dev \
        libavfilter-dev \
        libavformat-dev \
        libavutil-dev \
        libcamera-dev \
        libcap-dev \
        libswscale-dev \
        libswresample-dev \
        python-is-python3 \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -t /python-packages \
    picamera2 \
    rpi-libcamera


FROM debian:testing

WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        libavcodec60 \
        libavdevice60 \
        libavfilter9 \
        libavformat60 \
        libavutil58 \
        libcamera0.3 \
        libcap2 \
        libswresample4 \
        libswscale7 \
        python-is-python3 \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Copy the python packages
COPY --from=build /python-packages/ /usr/lib/python3/dist-packages

# Copy the script
COPY hls.py ./

CMD [ "python", "./hls.py" ]
