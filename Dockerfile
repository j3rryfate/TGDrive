# Use the official Python base image
FROM python:3.11.7-slim

# Set the working directory inside the container
WORKDIR /app

# System dependencies (Telegram bot တွေအတွက် တစ်ခါတလေ လိုအပ်တတ်လို့ ထည့်ပေးထားပါတယ်)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Port ကို Default 8080 ပေးထားမယ် (Railway က ဒါကို အလိုအလျောက် သိပါတယ်)
ENV PORT=8080

# ပြဿနာဖြစ်စေတဲ့ ["uvicorn", ...] ပုံစံကို ဖြုတ်ပြီး 
# Shell အတိုင်း တိုက်ရိုက် Run ခိုင်းလိုက်ပါ (ဒါမှ $PORT က integer ဖြစ်မှာပါ)
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT}
