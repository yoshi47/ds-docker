FROM ubuntu:20.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update && apt-get install -y \
    tzdata \
&&  ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Tokyo

RUN apt-get update  --fix-missing && \
    apt-get install -y \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncursesw5-dev \
    xz-utils tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    libgdbm-dev \
    git \
    openssh-server \
    python3-pip

RUN apt-get install -y nodejs npm
RUN npm install n -g
RUN n stable
RUN apt-get purge -y nodejs npm

RUN python3 -m pip install --upgrade pip && \
    pip install --no-cache-dir \
    jupyterlab \
    ipywidgets \
    numpy \
    pandas \
    scipy \
    torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu \
    scikit-learn \
    matplotlib \
    japanize_matplotlib \
    seaborn \
    xgboost \
    lightgbm


# 拡張機能
RUN pip install --no-cache-dir \
    jupyterlab-git \
    jupyterlab_code_formatter \
    lckr-jupyterlab-variableinspector \
    git+https://github.com/cliffwoolley/jupyter_tensorboard.git

# RUN jupyter labextension install \
#     jupyterlab_tensorboard \