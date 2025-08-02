#\!/bin/bash

# Final Unigine GPU Benchmark Script
# This script will run the best available GPU stress tests

echo "==================== GPU Stress Test Suite ===================="
echo "Running intensive GPU benchmarks..."
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
echo "Checking available benchmarks..."
find /opt -name "*heaven*" -o -name "*unigine*" -o -name "*valley*" 2>/dev/null

echo ""
echo "1. Looking for Unigine Heaven..."
if [ -x "/opt/Unigine_Heaven-4.0/bin/heaven_x64" ]; then
    echo "   Found Unigine Heaven\! Starting benchmark..."
    cd /opt/Unigine_Heaven-4.0/bin/
    ./heaven_x64 -video_app opengl -video_mode -1 -video_fullscreen 0 -video_width 1920 -video_height 1080 -video_quality ultra -shaders_quality ultra
elif [ -x "/opt/unigine/heaven_demo.sh" ]; then
    echo "   Running GLMark2 intensive terrain benchmark as Heaven alternative..."
    /opt/unigine/heaven_demo.sh
else
    echo "   Running intensive GLMark2 terrain benchmark..."
    timeout 120 glmark2 --annotate --run-forever --benchmark="terrain:show-fps=true:terrain-blur=true"
fi

echo ""
echo "2. Running additional intensive GPU tests..."
echo "   Starting complex shader benchmark..."
timeout 60 glmark2 --annotate --benchmark="shading:shading=phong:show-fps=true"

echo ""
echo "   Starting refraction stress test..."
timeout 60 glmark2 --annotate --benchmark="refract:show-fps=true"

echo ""
echo "   Starting shadow mapping test..."
timeout 60 glmark2 --annotate --benchmark="shadow:show-fps=true"

echo ""
echo "3. Final stress test - Complex desktop effects..."
timeout 60 glmark2 --annotate --benchmark="desktop:windows=12:effect=shadow:show-fps=true"

echo ""
echo "=============================================================="
echo "Intensive GPU stress tests completed\!"
echo "=============================================================="
