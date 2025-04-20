FROM python:alpine

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt || true

CMD ["tail", "-f", "/dev/null"]