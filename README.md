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
# Install any 3D game from Steam store (e.g., Portal, CS2, Dota 2)
# Launch games directly from Steam interface
```

**Windows Games:**
```bash
make wine
wine game-installer.exe
# After installation, run games with: wine /path/to/game.exe
```

**Linux Games (Package Manager):**
```bash
make shell
sudo apt install supertuxkart     # 3D racing game
sudo apt install 0ad              # 3D strategy game
sudo apt install minetest         # 3D voxel game
sudo apt install openarena        # 3D FPS game
# Note: Game executables are in /usr/games/ directory
```

**Popular 3D Games to Try:**
- **SuperTuxKart**: `sudo apt install supertuxkart && /usr/games/supertuxkart`
- **0 A.D.**: `sudo apt install 0ad && /usr/games/0ad`
- **Minetest**: `sudo apt install minetest && /usr/games/minetest`
- **OpenArena**: `sudo apt install openarena && /usr/games/openarena`

## Running Installed Games

**From Container Shell:**
```bash
make shell
export PATH=$PATH:/usr/games    # Add games to PATH
minetest                        # Run game directly
# Or use full path: /usr/games/minetest
```

**Direct Game Launch:**
```bash
docker exec -it gaming-env /usr/games/minetest
docker exec -it gaming-env /usr/games/supertuxkart
```

## Data Storage

Game data persists in:
- `./game-data/` - General games
- `./steam-data/` - Steam library
- `./wine-data/` - Windows games

## Requirements

- Docker and docker-compose
- X11 display server
- GPU with DRI support (Intel/AMD integrated or discrete graphics)