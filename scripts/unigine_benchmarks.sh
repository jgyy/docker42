#\!/bin/bash

# Unigine Benchmarks for AMD RX 6500 GPU
# Force AMD GPU usage and run real Unigine benchmarks

export DRI_PRIME=1
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=gpl
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
export DISPLAY=${DISPLAY:-:0}

echo "=== Unigine GPU Benchmarks for AMD RX 6500 ==="
echo "Timestamp: $(date)"
echo "Forcing AMD GPU usage with DRI_PRIME=1"
echo ""

# Check GPU info first
echo "=== GPU Information ==="
lspci | grep -i "VGA\|3D\|Display\|AMD\|Radeon" || echo "No GPU info found"
echo ""

# Check if Unigine is available
echo "=== Checking Unigine Installation ==="
ls -la /opt/Unigine* 2>/dev/null || echo "Unigine directories not found"
ls -la /usr/local/bin/unigine* 2>/dev/null || echo "Unigine binaries not found"
echo ""

# Run Unigine Heaven if available
echo "=== Running Unigine Heaven 4.0 ==="
if [ -f "/opt/Unigine_Heaven-4.0/bin/heaven_x64" ]; then
    echo "Found Unigine Heaven, starting benchmark..."
    cd /opt/Unigine_Heaven-4.0/bin/
    ./heaven_x64 -video_app opengl -video_mode -1 -sound_app null -data_path ../ -engine_config ../data/heaven_4.0.cfg -system_script heaven/unigine.cpp || echo "Heaven failed to run"
    echo "Heaven benchmark completed"
else
    echo "Unigine Heaven not found at /opt/Unigine_Heaven-4.0/bin/heaven_x64"
fi
echo ""

# Run Unigine Superposition if available  
echo "=== Running Unigine Superposition 1.1 ==="
if [ -f "/opt/Unigine_Superposition-1.1/bin/superposition" ]; then
    echo "Found Unigine Superposition, starting benchmark..."
    cd /opt/Unigine_Superposition-1.1/bin/
    ./superposition -video_app opengl -sound_app null -data_path ../ -engine_config ../data/superposition_1.1.cfg || echo "Superposition failed to run"
    echo "Superposition benchmark completed"
else
    echo "Unigine Superposition not found at /opt/Unigine_Superposition-1.1/bin/superposition"
fi
echo ""

# Alternative: Try symlinked versions
echo "=== Trying Symlinked Executables ==="
if command -v unigine-heaven >/dev/null 2>&1; then
    echo "Running Unigine Heaven via symlink..."
    unigine-heaven -video_app opengl -video_mode -1 -sound_app null || echo "Symlinked Heaven failed"
fi

if command -v unigine-superposition >/dev/null 2>&1; then
    echo "Running Unigine Superposition via symlink..."
    unigine-superposition -video_app opengl -sound_app null || echo "Symlinked Superposition failed"
fi

echo ""
echo "=== Benchmark completed at $(date) ==="
