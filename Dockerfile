FROM ubuntu:22.04

# Install essential packages for C development
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    gdb \
    valgrind \
    git \
    vim \
    nano \
    man-db \
    libc6-dev \
    libbsd-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a user to avoid running as root
RUN useradd -m -s /bin/bash libft && \
    echo "libft:libft" | chpasswd && \
    adduser libft sudo

# Set working directory
WORKDIR /home/libft/workspace

# Change ownership of workspace
RUN chown -R libft:libft /home/libft/workspace

# Switch to non-root user
USER libft

# Set default command
CMD ["/bin/bash"]