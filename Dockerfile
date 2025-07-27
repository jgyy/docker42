FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y \
    mesa-utils \
    libgl1-mesa-dev \
    libgl1-mesa-dri \
    libglu1-mesa \
    pulseaudio \
    alsa-utils \
    x11-apps \
    xauth \
    xvfb \
    libsdl2-2.0-0 \
    libsdl2-image-2.0-0 \
    libsdl2-mixer-2.0-0 \
    libsdl2-ttf-2.0-0 \
    wine \
    wget \
    curl \
    ca-certificates \
    gnupg \
    software-properties-common \
    libc6:i386 \
    libstdc++6:i386 \
    libgl1-mesa-dev:i386 \
    nano \
    htop \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    mesa-vulkan-drivers \
    vulkan-tools \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O steam.deb https://steamcdn-a.akamaihd.net/client/installer/steam.deb \
    && dpkg -i steam.deb || apt-get install -f -y \
    && rm steam.deb

RUN useradd -m -s /bin/bash gamer \
    && usermod -aG audio,video gamer

USER gamer
WORKDIR /home/gamer

RUN winecfg || true

USER root

ENV DISPLAY=:0

RUN echo '#!/bin/bash\n\
# Set up audio\n\
pulseaudio --start --exit-idle-time=-1 2>/dev/null || true\n\
\n\
# Start as gamer user\n\
exec sudo -u gamer "$@"' > /entrypoint.sh \
    && chmod +x /entrypoint.sh

RUN apt-get update && apt-get install -y sudo \
    && echo "gamer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
