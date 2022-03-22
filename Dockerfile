FROM debian:buster-slim

RUN groupadd -r dockeruser -g 433 && \
    useradd -u 431 -r -g dockeruser -s /sbin/nologin -c "Docker image user" dockeruser

RUN apt update -y && \
    apt install -y python3 curl

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

COPY .artifakt .artifakt/
RUN chmod +x .artifakt/build.sh
RUN .artifakt/build.sh

USER dockeruser

EXPOSE 80

ENTRYPOINT [ "python3", "-m", "http.server", "80"]