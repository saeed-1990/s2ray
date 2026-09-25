FROM alpine:latest

RUN apk update && apk add --no-cache curl unzip

RUN mkdir -m 777 /v2ray

# این بخش خودش معماری سرور رو تشخیص میده و فایل درست رو دانلود میکنه
RUN ARCH=$(uname -m); \
    if [ "$ARCH" = "x86_64" ]; then ARCH="64"; \
    elif [ "$ARCH" = "aarch64" ]; then ARCH="arm64-v8a"; \
    else ARCH="64"; fi; \
    curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/download/v5.16.1/v2ray-linux-${ARCH}.zip && \
    unzip /tmp/v2ray.zip -d /v2ray && \
    rm /tmp/v2ray.zip && \
    chmod +x /v2ray/v2ray

COPY config.json /v2ray/config.json

# این خط مهم‌ترین تغییره: کلمه run اضافه شده تا با نسخه ۵ کار کنه
CMD ["/v2ray/v2ray", "run", "-config", "/v2ray/config.json"]
