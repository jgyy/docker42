# Steam with AMD GPU Docker Container

A simple Docker container for running Steam with AMD GPU support without requiring sudo access on the host system.

## Prerequisites

- Docker and Docker Compose installed
- AMD GPU with Mesa drivers installed on host
- X11 server running

## Quick Start

```bash
# Build the container
make build

# Launch Steam with AMD GPU
make steam
```

## What This Does

- **Steam**: Full Steam client with GUI
- **AMD GPU Support**: Automatically uses your AMD RX 6500 GPU
- **RADV Drivers**: Optimized AMD Vulkan drivers for gaming
- **No Sudo Required**: Runs entirely in Docker

## Usage

### First Time Setup

```bash
# Build the container
make build

# Launch Steam
make steam
```

### Daily Use

```bash
# Just run Steam
make steam
```

### Verify GPU Detection

```bash
# Check if AMD GPU is detected
make gpu-check
```

## Commands

- `make build` - Build the Docker image
- `make steam` - Launch Steam with AMD GPU
- `make gpu-check` - Check AMD GPU status
- `make stop` - Stop the container
- `make clean` - Clean up Docker resources
- `make help` - Show available commands

## Steam Features

✅ **Full Steam Store access**  
✅ **Game downloads and installation**  
✅ **AMD GPU gaming with RADV drivers**  
✅ **Vulkan and OpenGL game support**  
✅ **Steam Workshop and Community**

## AMD GPU Configuration

The container automatically configures:
- `DRI_PRIME=1` - Forces AMD GPU usage
- `AMD_VULKAN_ICD=RADV` - Uses optimized RADV drivers
- `RADV_PERFTEST=gpl` - Enables performance optimizations

Your games will automatically use the AMD RX 6500 GPU for maximum performance!