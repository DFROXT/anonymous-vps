FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server sudo curl wget git python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd
RUN echo 'root:dev' | chpasswd
RUN useradd -m -s /bin/bash dev 2>/dev/null || true
RUN echo 'dev:dev' | chpasswd
RUN usermod -aG sudo dev

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
    && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list \
    && apt-get update && apt-get install -y ngrok

WORKDIR /app
COPY . .

EXPOSE 22 8080

CMD ["bash", "deploy.sh"]
