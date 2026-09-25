# استفاده از ایمیج پایه سبک
FROM alpine:latest

# نصب ابزارهای لازم
RUN apk update && apk add --no-cache curl unzip

# ساخت پوشه برای V2Ray
RUN mkdir -m 777 /v2ray

# دانلود فایل V2Ray برای معماری ARM64 (معماری سرور DormHost)
RUN curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/download/v5.8.0/v2ray-linux-arm64-v8a.zip && \
    unzip /tmp/v2ray.zip -d /v2ray && \
    rm /tmp/v2ray.zip && \
    chmod +x /v2ray/v2ray

# کپی فایل کانفیگ
COPY config.json /v2ray/config.json

# اجرای V2Ray با فایل کانفیگ
CMD ["/v2ray/v2ray", "-config", "/v2ray/config.json"]
