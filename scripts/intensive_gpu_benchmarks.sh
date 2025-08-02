#\!/bin/bash

# Intensive GPU Benchmark Script
# This script runs demanding GPU stress tests with visible GUI

echo "==================== Intensive GPU Stress Tests ===================="
echo "Starting high-performance GPU benchmarks..."
echo "These tests will stress your GPU heavily - monitor temperatures\!"
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

echo ""
echo "1. Running GLMark2 (Intensive OpenGL benchmark)..."
echo "   Running all intensive test scenes with maximum settings"
sleep 3
glmark2 --benchmark-list | grep -E "terrain|refract|shadow|bump|desktop" | while read scene; do
    echo "Running scene: $scene"
    glmark2 --run-forever --benchmark="$scene"
done

echo ""
echo "2. Running Unigine Heaven (Extreme GPU stress test)..."
echo "   This is a very demanding DirectX/OpenGL benchmark"
if [ -x "/opt/Unigine_Heaven-4.0/bin/heaven_x64" ]; then
    cd /opt/Unigine_Heaven-4.0/bin/
    ./heaven_x64 -video_app opengl -video_mode -1 -video_fullscreen 0 -video_width 1920 -video_height 1080 -video_quality ultra -shaders_quality ultra -tessellation_quality ultra -textures_quality ultra -anisotropy 16 -antialiasing 8
else
    echo "   Unigine Heaven not available, running GLMark2 stress test instead"
    glmark2 --annotate --run-forever
fi

echo ""
echo "3. Running Unigine Valley (Nature stress test)..."
echo "   Heavy vegetation and particle effects"
if [ -x "/opt/Unigine_Valley-1.0/bin/valley_x64" ]; then
    cd /opt/Unigine_Valley-1.0/bin/
    ./valley_x64 -video_app opengl -video_mode -1 -video_fullscreen 0 -video_width 1920 -video_height 1080 -video_quality ultra -shaders_quality ultra -tessellation_quality ultra -textures_quality ultra -anisotropy 16 -antialiasing 8
else
    echo "   Unigine Valley not available"
fi

echo ""
echo "4. Running Vulkan stress test..."
if command -v vkcube &> /dev/null; then
    echo "   Running intensive Vulkan workload"
    timeout 300 vkcube &
    wait
else
    echo "   Vulkan not available"
fi

echo ""
echo "=============================================================="
echo "Intensive GPU stress tests completed\!"
echo "Check your GPU temperatures and performance metrics"
echo "=============================================================="
