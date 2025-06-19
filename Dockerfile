FROM python:3.10-slim

ENV ENVIRONMENT=DEV
ENV HOST=localhost
ENV PORT=8000
ENV REDIS_HOST=10.77.41.60
ENV REDIS_PORT=6379
ENV REDIS_DB=0

RUN groupadd -r devoteam \
 && useradd -r -g devoteam -d /app -s /sbin/nologin devoteam

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && update-ca-certificates

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host files.pythonhosted.org --trusted-host pypi.python.org  -r requirements.txt

COPY . .

RUN chown -R devoteam:devoteam /app

USER devoteam

EXPOSE 8000

CMD ["python", "hello.py"]

