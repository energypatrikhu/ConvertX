FROM c4illin/convertx:latest

# Add all components in /etc/apt/sources.list.d/debian.sources; replace "main" with "main contrib non-free non-free-firmware"
RUN sed -i 's/main/main contrib non-free non-free-firmware/g' /etc/apt/sources.list.d/debian.sources

# Install NVIDIA CUDA libraries and FFmpeg with NVENC support
RUN apt-get update \
    && apt-get install -y \
      libcuda1 \
      libnvcuvid1 \
      libnvidia-encode1 \
      libavcodec-extra \
      libffmpeg-nvenc-dev \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*
