FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0
ENV AMD_VULKAN_ICD=RADV
ENV RADV_PERFTEST=gpl

# Enable 32-bit architecture for Steam
RUN dpkg --add-architecture i386

# Install essential packages for AMD GPU and Steam
RUN apt-get update && apt-get install -y \
    wget \
    mesa-vulkan-drivers \
    mesa-vulkan-drivers:i386 \
    libgl1-mesa-dri:i386 \
    libgl1-mesa-glx:i386 \
    libdrm2:i386 \
    pciutils \
    && rm -rf /var/lib/apt/lists/*

# Install X11 dependencies for Steam GUI
RUN apt-get update && apt-get install -y \
    libxrandr2 \
    libxinerama1 \
    libxcursor1 \
    libxi6 \
    libfontconfig1 \
    libfreetype6 \
    libxss1 \
    libasound2 \
    libnspr4 \
    libnss3 \
    libxtst6 \
    libgtk-3-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Steam
RUN cd /tmp && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb && \
    dpkg -i steam.deb || true && \
    apt-get update && \
    apt-get install -f -y && \
    rm -f steam.deb && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash benchuser
USER benchuser
WORKDIR /home/benchuser

RUN mkdir -p /home/benchuser/benchmarks

CMD ["/bin/bash"]
