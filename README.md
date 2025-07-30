# Universal Docker Development Environment

A comprehensive containerized development environment supporting multiple programming languages and frameworks, providing all necessary tools without requiring sudo access on your host system.

## Prerequisites

- Docker
- Docker Compose

## Quick Start

```bash
make dev
```

## Supported Technologies

### Languages & Runtimes
- **C/C++**: GCC, G++, Make, CMake, GDB, Valgrind
- **Node.js**: v20, NPM, Yarn, TypeScript
- **Python**: v3, pip, venv, Jupyter
- **Java**: OpenJDK 17
- **Go**: Latest stable
- **Rust**: Latest stable

### Frameworks & Tools
- **Frontend**: React, Vue, Angular, Vite
- **Backend**: Express, Flask, Django, FastAPI
- **Mobile**: React Native, Expo
- **Development**: Git, Vim, Nano, tmux, screen

## Available Commands

### Basic Container Management
| Command | Description |
|---------|-------------|
| `make build` | Build the Docker image |
| `make up` | Start container in background |
| `make down` | Stop the container |
| `make shell` | Enter running container |
| `make run` | Start new container with shell |
| `make dev` | Build and start development shell |
| `make clean` | Remove containers and images |

### Project Management
| Command | Description |
|---------|-------------|
| `make install-node` | Install Node.js dependencies |
| `make install-python` | Install Python requirements |
| `make jupyter` | Start Jupyter notebook server |

### Quick Project Creation
| Command | Example |
|---------|---------|
| `make create-react name=myapp` | Create React app |
| `make create-vue name=myapp` | Create Vue app |
| `make create-angular name=myapp` | Create Angular app |

## Development Workflows

### C/C++ Development
```bash
make dev
# Inside container:
gcc -Wall -Wextra -Werror main.c -o program
gdb ./program
valgrind --leak-check=full ./program
```

### Web Development
```bash
make dev
# Inside container:
npx create-react-app myapp
cd myapp && npm start
# Access at http://localhost:3000
```

### Python Development
```bash
make dev
# Inside container:
python3 -m venv venv
source venv/bin/activate
pip install flask
python app.py
# Access at http://localhost:5000
```

### Mobile Development
```bash
make dev
# Inside container:
npx create-expo-app MyApp
cd MyApp && npx expo start
```

## Port Mappings

| Port | Service |
|------|---------|
| 3000 | React/Next.js |
| 4200 | Angular |
| 5000 | Flask |
| 5173 | Vite |
| 8000 | Django/FastAPI |
| 8080 | General web server |
| 8888 | Jupyter Notebook |

## Project Structure

```
docker42/
├── Dockerfile          # Container definition
├── docker-compose.yml  # Container orchestration
├── Makefile            # Build commands
├── README.md           # This file
└── [your projects]     # Your project files
```

## Notes

- All project files are mounted in `/home/developer/workspace`
- Changes persist on your host system
- Container runs as `developer` user (not root)
- Docker socket is mounted for containerized builds
- Multiple ports exposed for various development servers