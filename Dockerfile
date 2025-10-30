# 使用官方Python 3.12镜像
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

# 复制项目文件
COPY . /app/

# 合并所有pip安装步骤，并在每一步后清理缓存
RUN pip install --no-cache-dir torch==2.7.0 torchvision==0.22.0 --index-url https://download.pytorch.org/whl/cu118 && \
    pip install --no-cache-dir paddlepaddle-gpu==3.0.0 -i https://www.paddlepaddle.org.cn/packages/stable/cu118/ && \
    pip install --no-cache-dir -r requirements.txt && \
    # 清理所有可能的缓存
    pip cache purge && \
    rm -rf /root/.cache/pip && \
    rm -rf /tmp/* && \
    # 清理文档和不需要的文件
    find /usr/local -name '*.pyc' -delete && \
    find /usr/local -name '__pycache__' -type d -exec rm -rf {} + && \
    # 清理apt缓存（再次确认）
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

CMD ["/bin/bash", "-c", "sleep 10000"]