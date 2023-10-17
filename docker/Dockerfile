FROM python:3.8-slim

WORKDIR /app

COPY app.py .
COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 80

CMD ["python", "app.py"]
