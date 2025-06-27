FROM nyurik/alpine-python3-requests

LABEL maintainer="SamShumChun"
LABEL version="0.0.1"
LABEL description="Telegram Bot for ServerStatus"

WORKDIR /app
COPY ./bot.py .
CMD [ "python", "./bot.py" ]
