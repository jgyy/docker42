#\!/bin/bash

# AMD Radeon RX 6500 GPU Test Script

echo "==================== AMD GPU Detection & Benchmarks ===================="
echo "Testing AMD Radeon RX 6500 GPU access and performance"
echo "=============================================================="

# Test X11 connection first
echo "Testing X11 display connection..."
if \! timeout 5 xset q &>/dev/null; then
    echo "ERROR: Cannot connect to X11 display"
    exit 1
fi
echo "X11 display connection OK"

echo ""
echo "=== GPU Hardware Detection ==="
echo "PCI devices (looking for AMD GPU):"
lspci | grep -i "vga\|3d\|display\|amd\|radeon"

echo ""
echo "DRM devices:"
ls -la /dev/dri/

echo ""
echo "=== OpenGL Information ==="
glxinfo | grep -E "(OpenGL vendor|OpenGL renderer|OpenGL version|OpenGL shading)"

echo ""
echo "=== Vulkan Information ==="
if command -v vulkaninfo &> /dev/null; then
    echo "Vulkan devices:"
    vulkaninfo --summary | head -20
else
    echo "vulkaninfo not available"
fi

echo ""
echo "=== AMD-Specific Tools ==="
if command -v radeontop &> /dev/null; then
    echo "AMD GPU monitoring available (radeontop)"
else
    echo "radeontop not available"
fi

echo ""
echo "=== Running AMD GPU Benchmarks ==="
echo "1. OpenGL benchmark targeting AMD GPU..."
echo "   Make sure you see AMD/Radeon in the GL_RENDERER above\!"

glmark2 --annotate --benchmark="terrain:show-fps=true"

echo ""
echo "2. Vulkan benchmark (should use AMD GPU)..."
if command -v vkcube &> /dev/null; then
    timeout 30 vkcube &
    wait
else
    echo "vkcube not available"
fi

echo ""
echo "3. Complex shader test..."
glmark2 --annotate --benchmark="shading:shading=phong:show-fps=true"

echo ""
echo "4. Buffer stress test..."
glmark2 --annotate --benchmark="buffer:update-method=map:show-fps=true"

echo ""
echo "=============================================================="
echo "AMD GPU testing completed\!"
echo "Check if GL_RENDERER shows AMD/Radeon for proper GPU usage"
echo "=============================================================="
