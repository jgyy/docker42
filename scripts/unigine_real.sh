#\!/bin/bash

# Real Unigine GPU Benchmarks on AMD RX 6500
# This script runs the official Unigine Heaven and Superposition benchmarks

export DRI_PRIME=1
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=gpl

echo "==================== UNIGINE GPU BENCHMARKS ===================="
echo "🔥 Running OFFICIAL Unigine benchmarks on AMD Radeon RX 6500\!"
echo "Expected massive performance improvement over integrated graphics"
echo "=============================================================="

echo "Environment: DRI_PRIME=$DRI_PRIME (forcing AMD GPU)"
echo ""

# Check if Unigine benchmarks are available
echo "=== Checking Available Unigine Benchmarks ==="
echo "Unigine installations:"
ls -la /opt/ | grep -i unigine || echo "No Unigine directories found in /opt"

echo ""
echo "Checking symlinks:"
ls -la /usr/local/bin/ | grep unigine || echo "No Unigine symlinks found"

echo ""
echo "=== GPU Information ==="
glxinfo | grep -E "(OpenGL vendor|OpenGL renderer|OpenGL version)"

echo ""
echo "1. UNIGINE HEAVEN BENCHMARK"
echo "=============================================================="
if [ -x "/opt/Unigine_Heaven-4.0/bin/heaven_x64" ]; then
    echo "✅ Found Unigine Heaven\! Starting benchmark..."
    cd /opt/Unigine_Heaven-4.0/bin/
    ./heaven_x64 \
        -video_app opengl \
        -video_mode -1 \
        -video_fullscreen 0 \
        -video_width 1920 \
        -video_height 1080 \
        -video_quality ultra \
        -shaders_quality ultra \
        -tessellation_quality ultra \
        -textures_quality ultra \
        -anisotropy 16 \
        -antialiasing 8
elif [ -x "/usr/local/bin/unigine-heaven" ]; then
    echo "✅ Found Unigine Heaven via symlink\! Starting..."
    unigine-heaven \
        -video_app opengl \
        -video_mode -1 \
        -video_fullscreen 0 \
        -video_width 1920 \
        -video_height 1080 \
        -video_quality ultra
else
    echo "❌ Unigine Heaven not found. Checking extraction..."
    find /opt -name "*heaven*" -type f -executable 2>/dev/null | head -5
    echo "Running GLMark2 as fallback..."
    glmark2 --annotate --benchmark="terrain:show-fps=true"
fi

echo ""
echo "2. UNIGINE SUPERPOSITION BENCHMARK"
echo "=============================================================="
if [ -x "/opt/Unigine_Superposition-1.1/bin/superposition" ]; then
    echo "✅ Found Unigine Superposition\! Starting benchmark..."
    cd /opt/Unigine_Superposition-1.1/bin/
    ./superposition \
        -video_app opengl \
        -video_mode -1 \
        -video_fullscreen 0 \
        -video_width 1920 \
        -video_height 1080 \
        -video_quality ultra
elif [ -x "/usr/local/bin/unigine-superposition" ]; then
    echo "✅ Found Unigine Superposition via symlink\! Starting..."
    unigine-superposition \
        -video_app opengl \
        -video_mode -1 \
        -video_fullscreen 0 \
        -video_width 1920 \
        -video_height 1080 \
        -video_quality ultra
else
    echo "❌ Unigine Superposition not found. Checking extraction..."
    find /opt -name "*superposition*" -type f -executable 2>/dev/null | head -5
fi

echo ""
echo "=============================================================="
echo "🎯 Unigine benchmarks completed\!"
echo "Your AMD RX 6500 should show significantly higher scores"
echo "than integrated graphics (expect 2000-5000+ vs 300-500)"
echo "=============================================================="
