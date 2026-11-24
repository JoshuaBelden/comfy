FROM python:3.12-slim

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
      git ffmpeg libgl1 libglib2.0-0 build-essential \
    && rm -rf /var/lib/apt/lists/*

# CUDA 12.8 wheels support Blackwell GPUs (RTX 50-series)
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128

# Pin a ComfyUI version with: docker compose build --build-arg COMFYUI_REF=<tag-or-commit>
ARG COMFYUI_REF=master
RUN git clone https://github.com/Comfy-Org/ComfyUI /opt/ComfyUI \
    && cd /opt/ComfyUI \
    && git checkout ${COMFYUI_REF} \
    && pip install -r requirements.txt

COPY entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r$//' /entrypoint.sh && chmod +x /entrypoint.sh

WORKDIR /opt/ComfyUI
EXPOSE 8188
ENTRYPOINT ["/entrypoint.sh"]
