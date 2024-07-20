FROM python:3

WORKDIR /usr/src/app

# Install ffmpeg
RUN apt-get update && \
    apt-get install -y \
        cmake \
        libavcodec-dev \
        libavdevice-dev \
        libavfilter-dev \
        libavformat-dev \
        libavutil-dev \
        libcap-dev \
        libswscale-dev \
        libswresample-dev && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the script
COPY hls.py ./

CMD [ "python", "./hls.py" ]
