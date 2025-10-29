# 使用官方Python 3.8镜像
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖（包括ffmpeg等视频处理工具）
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 复制项目文件到容器中
COPY . /app/

# 安装CPU版本的深度学习框架
RUN pip install paddlepaddle==3.0.0 -i https://www.paddlepaddle.org.cn/packages/stable/cpu/
RUN pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu

# 安装项目依赖
RUN pip install -r requirements.txt

CMD ["/bin/bash", "-c", "sleep", "10000"]
