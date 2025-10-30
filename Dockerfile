# 使用官方Python 3.12镜像
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

RUN df -h

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN df -h

# 复制项目文件
COPY . /app/

# 先安装torch（使用更稳定的安装方式）
RUN pip install torch==2.7.0 torchvision==0.22.0 --index-url https://download.pytorch.org/whl/cu118

RUN df -h

# 再安装paddlepaddle-gpu
RUN pip install paddlepaddle-gpu==3.0.0 -i https://www.paddlepaddle.org.cn/packages/stable/cu118/

RUN df -h

# 最后安装项目依赖
RUN pip install -r requirements.txt

RUN df -h

CMD ["/bin/bash", "-c", "sleep 10000"]