FROM centos:7

MAINTAINER iython <allinnnn@163.com>

RUN yum -y install epel-release && \
    yum -y --enablerepo="epel" update && \
    yum clean all && \
    yum -y --enablerepo="epel" install sudo && \
    yum -y --enablerepo="epel" install python36-devel && \
    yum -y --enablerepo="epel" install python36-setuptools && \
    curl https://bootstrap.pypa.io/get-pip.py | python3.6
#========================================
# Add normal user(xyz) with passwordless sudo
#========================================
RUN useradd xyz && \
    echo 'xyz  ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
    # chmod -R 777 /home/xyz
#==============================
# Timezone && Locale
#==============================
ENV TZ Asia/Shanghai
ENV LANG zh_CN.UTF-8

COPY . /home/xyz/wyproxy/
WORKDIR /home/xyz/wyproxy
RUN pip3 install -r requirements.txt -i https://pypi.doubanio.com/simple
