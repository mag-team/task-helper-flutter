# Builder
FROM ubuntu AS builder

RUN apt update && apt install -y curl git wget unzip

RUN git clone -b stable --depth 1 https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor
RUN flutter config --enable-web

RUN mkdir /app
WORKDIR /app

COPY ./lib ./lib
COPY ./web ./web
COPY pubspec.* ./

RUN flutter build web --web-renderer canvaskit

# Runner
FROM httpd

COPY --from=builder /app/build/web /usr/local/apache2/htdocs/

