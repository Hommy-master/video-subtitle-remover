# 使用 NVIDIA 官方 CUDA 镜像
FROM nvidia/cuda:11.8-cudnn9-devel-ubuntu20.04

# 或者使用 PyTorch 官方镜像
# FROM pytorch/pytorch:2.7.0-cuda11.8-cudnn9-devel

# 安装 Python
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/bin/python3.12 /usr/bin/python

WORKDIR /app

# 复制项目文件
COPY . /app/

# 安装 Python 依赖
RUN pip install --no-cache-dir torch==2.7.0 torchvision==0.22.0 --index-url https://download.pytorch.org/whl/cu118 && \
    pip install --no-cache-dir paddlepaddle-gpu==3.0.0 -i https://www.paddlepaddle.org.cn/packages/stable/cu118/ && \
    pip install --no-cache-dir -r requirements.txt

CMD ["/bin/bash", "-c", "sleep 10000"]