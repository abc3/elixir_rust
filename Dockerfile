FROM python:3-slim

WORKDIR /app

COPY echo.py . 

CMD ["python", "echo.py"]