FROM python:3.11-bullseye

# use ustc mirror to update and install the essentials
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y \
  build-essential gcc wget \
  cron locales tzdata

# set chinese timezone and locale
RUN echo "zh_CN.GB18030 GB18030" > /etc/locale.gen && locale-gen \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# use utsc mirror to update and install python packages
RUN python -m pip install -i https://pypi.mirrors.ustc.edu.cn/simple/ --upgrade pip \
  && pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple \
  && pip install setuptools
