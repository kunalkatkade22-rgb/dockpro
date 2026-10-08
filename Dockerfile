FROM python:3.12-slim

WORKDIR /app

# Install dependencies first (cached unless requirements.txt changes)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

ENV APP_VERSION=v1
EXPOSE 5000

# Production server instead of Flask dev server
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
