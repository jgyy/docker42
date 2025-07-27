# Gaming Container Setup

Docker container for running 3D GUI games without sudo rights on Ubuntu.

## Quick Start

```bash
make start    # Setup and start container
make shell    # Access gaming environment
make stop     # Stop container
```

## Available Commands

```bash
make help     # Show all available commands
make steam    # Launch Steam directly
make wine     # Configure Wine for Windows games
make logs     # View container logs
make clean    # Remove everything
```

## What's Included

- Steam for Steam games
- Wine for Windows games  
- Mesa/OpenGL for 3D graphics
- Vulkan support
- PulseAudio for audio
- SDL2 libraries

## Installing Games

**Steam Games:**
```bash
make steam
```

**Windows Games:**
```bash
make wine
wine game-installer.exe
```

**Linux Games:**
```bash
make shell
sudo apt install game-name
```

## Data Storage

Game data persists in:
- `./game-data/` - General games
- `./steam-data/` - Steam library
- `./wine-data/` - Windows games

## Requirements

- Docker and docker-compose
- NVIDIA GPU (for 3D acceleration)
- X11 display server