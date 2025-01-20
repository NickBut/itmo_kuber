FROM python:3.12-alpine

WORKDIR /app

RUN echo "Hello world" > /app/hello.html

RUN adduser -u 10001 -D appuser
USER appuser

CMD ["python", "-m", "http.server", "8000"]