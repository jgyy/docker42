#\!/bin/bash

# Force AMD GPU Usage Script

echo "==================== Forcing AMD GPU Usage ===================="
echo "Attempting to force OpenGL/Vulkan to use AMD Radeon RX 6500"
echo "=============================================================="

# Set environment variables to prefer AMD GPU
export DRI_PRIME=1
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=gpl
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json

echo "Environment variables set:"
echo "DRI_PRIME=$DRI_PRIME"
echo "AMD_VULKAN_ICD=$AMD_VULKAN_ICD"
echo "RADV_PERFTEST=$RADV_PERFTEST"

echo ""
echo "Testing with DRI_PRIME=1 (should force discrete GPU)..."

echo ""
echo "=== OpenGL with DRI_PRIME=1 ==="
DRI_PRIME=1 glxinfo | grep -E "(OpenGL vendor|OpenGL renderer|OpenGL version)"

echo ""
echo "=== Running Benchmark with Forced AMD GPU ==="
echo "1. Terrain benchmark with DRI_PRIME=1..."
DRI_PRIME=1 glmark2 --annotate --benchmark="terrain:show-fps=true"

echo ""
echo "2. Complex shader test with DRI_PRIME=1..."
DRI_PRIME=1 glmark2 --annotate --benchmark="shading:shading=phong:show-fps=true"

echo ""
echo "3. Vulkan test targeting AMD GPU..."
DRI_PRIME=1 vulkaninfo --summary | head -20

echo ""
echo "=============================================================="
echo "If you still see Intel renderer, the AMD GPU may need"
echo "additional drivers or the container needs more privileges"
echo "=============================================================="
