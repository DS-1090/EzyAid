FROM python

WORKDIR /app

RUN pip install kafka-python redis

COPY kafkaconsumer.py kafkaconsumer.py

CMD ["python", "kafkaconsumer.py"]
