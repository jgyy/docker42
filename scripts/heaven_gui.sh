#\!/bin/bash

export DRI_PRIME=1
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=gpl
export DISPLAY=:0
export QT_X11_NO_MITSHM=1
export __GLX_VENDOR_LIBRARY_NAME=mesa

echo "=== Launching Unigine Heaven 4.0 GUI ==="
echo "GPU Detection:"
lspci | grep -i vga
echo ""

echo "GL Info:"
glxinfo | grep "OpenGL renderer" || echo "GL info not available"
echo ""

cd /opt/Unigine_Heaven-4.0/bin/

echo "Testing Heaven with explicit window settings..."
./heaven_x64 \
  -data_path ../ \
  -video_app opengl \
  -video_mode 1280x720 \
  -video_fullscreen 0 \
  -video_vsync 1 \
  -sound_app null \
  -console_command "engine.console.setActivity(1)"

echo "Heaven benchmark session ended."
