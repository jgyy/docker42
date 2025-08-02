#\!/bin/bash

# GPU Benchmark Script
# This script runs GPU benchmarks only and saves results

RESULTS_DIR="/home/benchuser/results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "==================== GPU Benchmark Suite ===================="
echo "Starting GPU benchmarks at: $(date)"
echo "Results will be saved to: $RESULTS_DIR"
echo "=============================================================="

# Create results directory if it doesn't exist
mkdir -p "$RESULTS_DIR"
chmod 755 "$RESULTS_DIR"

# GPU Information Collection
echo "Collecting GPU information..."
{
    echo "=== GPU Information ==="
    echo "Date: $(date)"
    echo "Architecture: $(uname -m)"
    
    echo "GPU Hardware:"
    lspci | grep -i "vga\|3d\|display" || echo "No GPU devices found via lspci"
    
    echo ""
    echo "Graphics Driver Info:"
    if command -v nvidia-smi &> /dev/null; then
        echo "NVIDIA GPU detected:"
        nvidia-smi
    else
        echo "NVIDIA drivers not available"
    fi
    
    if command -v glxinfo &> /dev/null; then
        echo ""
        echo "OpenGL Information:"
        glxinfo | grep -E "(OpenGL vendor|OpenGL renderer|OpenGL version|OpenGL shading language version)"
    else
        echo "glxinfo not available (install mesa-utils)"
    fi
    
    if command -v vulkaninfo &> /dev/null; then
        echo ""
        echo "Vulkan Information:"
        vulkaninfo --summary
    else
        echo "vulkaninfo not available"
    fi
    echo ""
} > "$RESULTS_DIR/gpu_info_$TIMESTAMP.txt" 2>&1

# OpenGL Benchmark with GLMark2
if command -v glmark2 &> /dev/null; then
    echo "Running GLMark2 OpenGL benchmark..."
    timeout 60 glmark2 --annotate > "$RESULTS_DIR/glmark2_$TIMESTAMP.txt" 2>&1 || echo "GLMark2 benchmark completed"
else
    echo "GLMark2 not available, skipping OpenGL benchmark"
fi

# Mesa GPU benchmark
if command -v glxgears &> /dev/null; then
    echo "Running Mesa GPU tests..."
    timeout 30 glxgears -info > "$RESULTS_DIR/glxgears_$TIMESTAMP.txt" 2>&1 || echo "Mesa GPU test completed"
fi

echo "=============================================================="
echo "GPU benchmarks completed at: $(date)"
echo "Results saved to: $RESULTS_DIR"
echo "=============================================================="

# List all result files
echo "Generated result files:"
ls -la "$RESULTS_DIR"/*_$TIMESTAMP.* 2>/dev/null || echo "No result files found"
