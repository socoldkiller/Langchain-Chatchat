# 使用官方Python运行时作为父镜像
FROM python:3.11

# 设置工作目录
WORKDIR /app

COPY requirements requirements 

WORKDIR /app/requirements

# 安装requirements.txt中指定的任何所需包
RUN pip install  --no-cache-dir -r requirements.txt && \
    pip install  --no-cache-dir -r requirements_api.txt && \
    pip install  --no-cache-dir -r requirements_webui.txt  


WORKDIR /app
RUN apt update && \
    apt install git-lfs && \
    git lfs install && \
    git clone https://huggingface.co/THUDM/chatglm3-6b && \
    git clone https://huggingface.co/BAAI/bge-large-zh

COPY . .

RUN python3 copy_config_example.py && \
    python init_database.py --recreate-vs

WORKDIR /usr/local/data/chatchat/Langchain-Chatchat-master

CMD /bin/bash






