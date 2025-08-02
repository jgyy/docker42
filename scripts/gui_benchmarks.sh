#\!/bin/bash

# Interactive GPU Benchmark Script
# This script runs GPU benchmarks with visible GUI windows

echo "==================== Interactive GPU Benchmark Suite ===================="
echo "Starting visual GPU benchmarks..."
echo "Press Ctrl+C to stop any benchmark early"
echo "=============================================================="

# Test X11 connection first
echo "Testing X11 display connection..."
if \! timeout 5 xset q &>/dev/null; then
    echo "ERROR: Cannot connect to X11 display"
    echo "Make sure you ran: xhost +local:docker"
    exit 1
fi
echo "X11 display connection OK"

# Simple OpenGL test first
echo ""
echo "1. Running glxgears (OpenGL test) - will run for 30 seconds..."
echo "   You should see spinning gears in a window"
sleep 3
timeout 30 glxgears &
wait

echo ""
echo "2. Running GLMark2 (OpenGL benchmark) - will run various 3D scenes..."
echo "   This is the main GPU benchmark - watch for frame rates"
sleep 3
glmark2

echo ""
echo "3. Testing Vulkan (if available)..."
if command -v vkcube &> /dev/null; then
    echo "   Running Vulkan cube demo for 30 seconds..."
    timeout 30 vkcube &
    wait
else
    echo "   Vulkan not available"
fi

echo ""
echo "=============================================================="
echo "Visual GPU benchmarks completed\!"
echo "=============================================================="
