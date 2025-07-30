# Libft Docker Development Environment

A containerized development environment for the 42 School libft project, providing all necessary tools without requiring sudo access on your host system.

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. **Build and run the development environment:**
   ```bash
   make dev
   ```

2. **Or use individual commands:**
   ```bash
   # Build the Docker image
   make build
   
   # Start development shell
   make run
   ```

## Available Commands

| Command | Description |
|---------|-------------|
| `make build` | Build the Docker image |
| `make up` | Start container in background |
| `make down` | Stop the container |
| `make shell` | Enter running container |
| `make run` | Start new container with shell |
| `make logs` | View container logs |
| `make restart` | Restart the container |
| `make clean` | Remove containers and images |
| `make rebuild` | Clean rebuild everything |
| `make dev` | Build and start development shell |

## Development Workflow

1. **Start development:**
   ```bash
   make dev
   ```

2. **Inside the container, work on your libft:**
   ```bash
   # Your project files are in /home/libft/workspace
   ls -la
   
   # Compile your library
   make
   
   # Test with provided main functions
   gcc -Wall -Wextra -Werror main.c libft.a
   ./a.out
   
   # Debug with gdb
   gdb ./a.out
   
   # Check for memory leaks with valgrind
   valgrind --leak-check=full ./a.out
   ```

3. **Exit container:**
   ```bash
   exit
   ```

## Included Tools

- **GCC**: C compiler with all necessary flags
- **Make**: Build automation
- **GDB**: GNU Debugger
- **Valgrind**: Memory leak detection
- **Git**: Version control
- **Vim/Nano**: Text editors
- **Man pages**: Documentation

## Project Structure

```
docker42/
├── Dockerfile          # Container definition
├── docker-compose.yml  # Container orchestration
├── Makefile            # Build commands
├── README.md           # This file
└── [your libft files]  # Your project files
```

## Notes

- All your project files are automatically mounted in the container
- Changes made inside the container persist on your host system
- The container runs as user 'libft' (not root) for security
- Container includes all standard C libraries and development tools