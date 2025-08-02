#\!/bin/bash

export DRI_PRIME=1
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=gpl
export DISPLAY=:0
export QT_X11_NO_MITSHM=1
export __GLX_VENDOR_LIBRARY_NAME=mesa

# Mesa compatibility fixes for older OpenGL apps
export MESA_GL_VERSION_OVERRIDE=3.3
export MESA_GLSL_VERSION_OVERRIDE=330
export mesa_glthread=false
export LIBGL_ALWAYS_SOFTWARE=0

echo "=== Launching Unigine Heaven with compatibility mode ==="
echo "GPU: $(lspci | grep -i vga)"
echo ""

cd /opt/Unigine_Heaven-4.0/bin/

# Try different rendering modes
echo "Attempting launch with OpenGL compatibility..."
./heaven_x64 \
  -data_path ../ \
  -video_app opengl \
  -video_mode 1024x768 \
  -video_fullscreen 0 \
  -sound_app null \
  -render_manager_main 1 \
  -video_multisample 0 \
  -video_vsync 0

echo "Heaven session ended."
