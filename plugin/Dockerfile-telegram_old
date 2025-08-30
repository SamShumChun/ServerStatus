FROM python:alpine

LABEL maintainer="samshum"
LABEL version="0.0.1"
LABEL description="Telegram Bot for ServerStatus"

WORKDIR /app
RUN pip install requests
COPY ./bot-telegram.py .
CMD [ "python", "./bot-telegram.py" ]
