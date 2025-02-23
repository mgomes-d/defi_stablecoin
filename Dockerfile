FROM debian:bookworm

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl && \
    apt-get install -y git-all && \
    apt-get install -y make && \
    curl -L "https://foundry.paradigm.xyz" | bash

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]
