#!/usr/bin/env bash
set -e
cd /opt/ComfyUI

# Standard model folders (the bind mount starts empty)
for d in checkpoints diffusion_models text_encoders vae loras clip_vision \
         controlnet upscale_models audio_encoders embeddings; do
  mkdir -p "models/$d"
done

# ComfyUI-Manager, installed into the mounted custom_nodes folder
if [ ! -d custom_nodes/ComfyUI-Manager ]; then
  git clone --depth 1 https://github.com/Comfy-Org/ComfyUI-Manager custom_nodes/ComfyUI-Manager
fi

# Reinstall custom node dependencies (container filesystem resets on recreate)
for req in custom_nodes/*/requirements.txt; do
  [ -f "$req" ] && pip install -q -r "$req" || echo "warn: failed installing $req"
done

exec python main.py --listen 0.0.0.0 --port 8188 "$@"
