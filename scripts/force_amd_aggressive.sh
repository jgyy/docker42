#\!/bin/bash

# Aggressive AMD GPU Forcing Script for RX 6500

echo "==================== AGGRESSIVE AMD GPU FORCING ===================="
echo "Forcing AMD Radeon RX 6500 GPU usage with multiple methods"
echo "=============================================================="

# Check if running as root for device access
echo "Current user: $(whoami)"
echo "Current groups: $(groups)"

echo ""
echo "=== Device Information ==="
echo "Available DRI devices:"
ls -la /dev/dri/

echo ""
echo "GPU devices detected:"
lspci | grep -E "(VGA|Display|3D)"

echo ""
echo "=== Setting Multiple Environment Variables ==="
export DRI_PRIME=1
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=gpl
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
export __GLX_VENDOR_LIBRARY_NAME=amd
export GPU_MAX_ALLOC_PERCENT=100
export GPU_USE_SYNC_OBJECTS=1

echo "Environment set:"
echo "DRI_PRIME=$DRI_PRIME"
echo "__GLX_VENDOR_LIBRARY_NAME=$__GLX_VENDOR_LIBRARY_NAME"

echo ""
echo "=== Trying to access AMD GPU device directly ==="
if [ -c "/dev/dri/renderD129" ]; then
    echo "AMD GPU device accessible: $(ls -la /dev/dri/renderD129)"
    chmod 666 /dev/dri/renderD129 2>/dev/null || echo "Cannot change permissions (may not be needed)"
else
    echo "AMD GPU device not found at /dev/dri/renderD129"
fi

echo ""
echo "=== Testing OpenGL with forced AMD ==="
echo "1. Standard DRI_PRIME test..."
DRI_PRIME=1 glxinfo | grep -E "(OpenGL vendor|OpenGL renderer|OpenGL version)" || echo "DRI_PRIME failed"

echo ""
echo "2. Alternative GPU selection methods..."
# Try different approaches
MESA_VK_DEVICE_SELECT=1023:743f glxinfo | grep -E "(OpenGL vendor|OpenGL renderer)" || echo "MESA_VK_DEVICE_SELECT failed"

echo ""
echo "=== Running Benchmark with ALL Force Methods ==="
echo "Running GLMark2 with maximum AMD forcing..."

# Try multiple environment combinations
DRI_PRIME=1 __GLX_VENDOR_LIBRARY_NAME=amd MESA_VK_DEVICE_SELECT=1023:743f glmark2 --annotate --benchmark="terrain:show-fps=true"

echo ""
echo "=============================================================="
echo "If still showing Intel GPU, the AMD drivers may need host-level setup"
echo "or your AMD GPU might be in a power-saving mode"
echo "=============================================================="
