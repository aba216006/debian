FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PORT=8080 \
    USERNAME=admin \
    PASSWORD=admin

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    wget curl git make sudo fastfetch procps htop nano vim jq unzip zip ca-certificates \
    python3 python3-pip python3-venv \
    iputils-ping iproute2 net-tools dnsutils traceroute mtr tcpdump nmap \
    nginx iptables iptables-persistent fail2ban && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -qO /bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 && \
    chmod +x /bin/ttyd

RUN echo "fastfetch" >> /root/.bashrc && \
    echo "cd /root" >> /root/.bashrc

EXPOSE 8080

CMD ["/bin/bash", "-c", "USER_VAL=${USERNAME:-root}; PASS_VAL=${PASSWORD:-root}; PORT_VAL=${PORT:-8080}; echo \"export PS1='\\[\\033[01;31m\\]$USER_VAL@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '\" >> /root/.bashrc && /bin/ttyd -p $PORT_VAL -c $USER_VAL:$PASS_VAL /bin/bash"]
