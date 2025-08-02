#\!/bin/bash

export DRI_PRIME=1
export AMD_VULKAN_ICD=RADV
export DISPLAY=:0

# Simple compatibility settings
export LIBGL_ALWAYS_INDIRECT=0
export MESA_GL_VERSION_OVERRIDE=2.1
export MESA_GLSL_VERSION_OVERRIDE=120

echo "=== Simple Heaven Launch ==="
echo "Using AMD RX 6500 GPU"
echo ""

cd /opt/Unigine_Heaven-4.0/bin/

# Run with minimal settings
./heaven_x64 \
  -data_path ../ \
  -video_app opengl \
  -video_mode 800x600 \
  -video_fullscreen 0 \
  -video_vsync 0 \
  -sound_app null

echo "Done."
