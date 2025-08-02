#\!/bin/bash

# Unigine-Only GPU Benchmark Script
# This script runs only Unigine benchmarks

echo "==================== Unigine GPU Benchmarks ===================="
echo "Starting Unigine benchmark suite..."
echo "These are industry-standard GPU stress tests"
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
echo "Available Unigine benchmarks:"
ls -la /opt/ | grep -i unigine || ls -la /opt/ | grep -E "(heaven|valley|superposition)"

echo ""
echo "1. Running Unigine Heaven (Classic GPU stress test)..."
if [ -x "/opt/heaven/bin/heaven_x64" ]; then
    echo "   Starting Unigine Heaven benchmark..."
    cd /opt/heaven/bin/
    ./heaven_x64 -video_app opengl -video_mode -1 -video_fullscreen 0 -video_width 1920 -video_height 1080 -video_quality ultra -shaders_quality ultra -tessellation_quality ultra -textures_quality ultra -anisotropy 16 -antialiasing 8
elif [ -x "/opt/Unigine_Heaven-4.0/bin/heaven_x64" ]; then
    echo "   Found alternative Heaven path..."
    cd /opt/Unigine_Heaven-4.0/bin/
    ./heaven_x64 -video_app opengl -video_mode -1 -video_fullscreen 0 -video_width 1920 -video_height 1080 -video_quality ultra
else
    echo "   Unigine Heaven not found at expected paths"
    find /opt -name "*heaven*" -type f -executable 2>/dev/null | head -5
fi

echo ""
echo "2. Running Unigine Valley (Nature scenes stress test)..."
if [ -x "/opt/valley/bin/valley_x64" ]; then
    echo "   Starting Unigine Valley benchmark..."
    cd /opt/valley/bin/
    ./valley_x64 -video_app opengl -video_mode -1 -video_fullscreen 0 -video_width 1920 -video_height 1080 -video_quality ultra -shaders_quality ultra -tessellation_quality ultra -textures_quality ultra -anisotropy 16 -antialiasing 8
elif [ -x "/opt/Unigine_Valley-1.0/bin/valley_x64" ]; then
    echo "   Found alternative Valley path..."
    cd /opt/Unigine_Valley-1.0/bin/
    ./valley_x64 -video_app opengl -video_mode -1 -video_fullscreen 0 -video_width 1920 -video_height 1080 -video_quality ultra
else
    echo "   Unigine Valley not found at expected paths"
    find /opt -name "*valley*" -type f -executable 2>/dev/null | head -5
fi

echo ""
echo "3. Running Unigine Superposition (Latest benchmark)..."
if [ -x "/opt/superposition/bin/superposition" ]; then
    echo "   Starting Unigine Superposition benchmark..."
    cd /opt/superposition/bin/
    ./superposition -video_app opengl -video_mode -1 -video_fullscreen 0 -video_width 1920 -video_height 1080 -video_quality ultra
else
    echo "   Unigine Superposition not found"
    find /opt -name "*superposition*" -type f -executable 2>/dev/null | head -5
fi

echo ""
echo "=============================================================="
echo "Unigine GPU benchmarks completed\!"
echo "=============================================================="
