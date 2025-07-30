FROM ubuntu:22.04

# Install comprehensive development packages (without Node.js first)
RUN apt-get update && apt-get install -y \
    # Base development tools
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    gdb \
    valgrind \
    git \
    vim \
    nano \
    curl \
    wget \
    unzip \
    zip \
    # Languages and runtimes
    python3 \
    python3-pip \
    python3-venv \
    openjdk-17-jdk \
    golang-go \
    rustc \
    # C/C++ libraries
    libc6-dev \
    libbsd-dev \
    man-db \
    # Additional utilities
    tree \
    htop \
    tmux \
    screen \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x separately to avoid conflicts
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install global npm packages
RUN npm install -g \
    yarn \
    typescript \
    @vue/cli \
    @angular/cli \
    create-react-app \
    @expo/cli \
    @react-native-community/cli

# Install Python packages
RUN pip3 install \
    jupyter \
    pandas \
    numpy \
    flask \
    django \
    fastapi \
    requests

# Create a user to avoid running as root
RUN useradd -m -s /bin/bash developer && \
    echo "developer:developer" | chpasswd && \
    adduser developer sudo

# Set working directory
WORKDIR /home/developer/workspace

# Change ownership of workspace
RUN chown -R developer:developer /home/developer/workspace

# Switch to non-root user
USER developer

# Set default command
CMD ["/bin/bash"]