#!/bin/bash

# Gaming Benchmark Script
# This script runs various benchmarks and saves results

RESULTS_DIR="/home/benchuser/results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "==================== Gaming Benchmark Suite ===================="
echo "Starting benchmarks at: $(date)"
echo "Results will be saved to: $RESULTS_DIR"
echo "=============================================================="

# Create results directory if it doesn't exist
mkdir -p "$RESULTS_DIR"
chmod 755 "$RESULTS_DIR"

# System Information
echo "Collecting system information..."
{
    echo "=== System Information ==="
    echo "Date: $(date)"
    echo "Architecture: $(uname -m)"
    echo "CPU Info:"
    cat /proc/cpuinfo | grep "model name" | head -1
    echo "Memory Info:"
    cat /proc/meminfo | grep "MemTotal"
    echo "GPU Info (if available):"
    lspci | grep -i vga || echo "No VGA devices found"
    echo ""
} > "$RESULTS_DIR/system_info_$TIMESTAMP.txt"

# CPU Benchmark with Geekbench (if available)
if command -v geekbench6 &> /dev/null; then
    echo "Running Geekbench 6 CPU benchmark..."
    geekbench6 --cpu > "$RESULTS_DIR/geekbench_cpu_$TIMESTAMP.txt" 2>&1 || echo "Geekbench CPU benchmark failed"
else
    echo "Geekbench not available, skipping CPU benchmark"
fi

# OpenGL Benchmark with GLMark2
if command -v glmark2 &> /dev/null; then
    echo "Running GLMark2 OpenGL benchmark..."
    timeout 300 glmark2 --run-forever --annotate > "$RESULTS_DIR/glmark2_$TIMESTAMP.txt" 2>&1 || echo "GLMark2 benchmark completed or timed out"
else
    echo "GLMark2 not available, skipping OpenGL benchmark"
fi

# Memory Benchmark with Sysbench
if command -v sysbench &> /dev/null; then
    echo "Running Sysbench memory benchmark..."
    {
        echo "=== Memory Benchmark ==="
        sysbench memory --memory-block-size=1K --memory-total-size=100G run
        echo ""
        sysbench memory --memory-block-size=1M --memory-total-size=10G run
    } > "$RESULTS_DIR/sysbench_memory_$TIMESTAMP.txt" 2>&1
else
    echo "Sysbench not available, skipping memory benchmark"
fi

# CPU Stress Test with stress-ng
if command -v stress-ng &> /dev/null; then
    echo "Running CPU stress test with stress-ng..."
    stress-ng --cpu 4 --timeout 60s --metrics-brief > "$RESULTS_DIR/stress_ng_cpu_$TIMESTAMP.txt" 2>&1 || echo "CPU stress test completed"
else
    echo "stress-ng not available, skipping CPU stress test"
fi

# GPU Information (if available)
echo "Collecting GPU information..."
{
    echo "=== GPU Information ==="
    if command -v nvidia-smi &> /dev/null; then
        echo "NVIDIA GPU detected:"
        nvidia-smi
    else
        echo "NVIDIA GPU not available"
    fi
    
    if command -v glxinfo &> /dev/null; then
        echo "OpenGL Information:"
        glxinfo | grep -E "(OpenGL vendor|OpenGL renderer|OpenGL version)" || echo "OpenGL info not available"
    else
        echo "glxinfo not available"
    fi
    
    if command -v vulkaninfo &> /dev/null; then
        echo "Vulkan Information:"
        vulkaninfo --summary || echo "Vulkan info not available"
    else
        echo "vulkaninfo not available"
    fi
} > "$RESULTS_DIR/gpu_info_$TIMESTAMP.txt" 2>&1

echo "=============================================================="
echo "Benchmarks completed at: $(date)"
echo "Results saved to: $RESULTS_DIR"
echo "=============================================================="

# List all result files
echo "Generated result files:"
ls -la "$RESULTS_DIR"/*_$TIMESTAMP.*