FROM alpine:latest

RUN apk update && apk add --no-cache curl unzip nginx

RUN mkdir -m 777 /xray
RUN mkdir -p /run/nginx

ENV GOMAXPROCS=1

RUN ARCH=$(uname -m); \
    if [ "$ARCH" = "x86_64" ]; then ARCH="64"; \
    elif [ "$ARCH" = "aarch64" ]; then ARCH="arm64-v8a"; \
    else ARCH="64"; fi; \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${ARCH}.zip && \
    unzip /tmp/xray.zip -d /xray && \
    rm /tmp/xray.zip && \
    chmod +x /xray/xray

COPY config.json /xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

CMD ["/entrypoint.sh"]
