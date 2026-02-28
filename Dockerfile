# Use the official Python base image
FROM python:3.11.7-slim AS base

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file to the working directory and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the working directory
COPY . .

# Railway နဲ့ Zeabur အတွက် Port ကို အရှင် (Dynamic) ထားပေးရပါမယ်
# Default အနေနဲ့ 8080 ကို သတ်မှတ်ထားပေးပါတယ်
ENV PORT=8080

# Expose the port (Documentation purposes)
EXPOSE 8080

# Shell form ကို သုံးပြီး $PORT variable ကို တိုက်ရိုက်ယူသုံးခြင်း
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT}
