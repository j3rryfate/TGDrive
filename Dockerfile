# Use the official Python base image (slim version က ပိုပေါ့ပါးတယ်)
FROM python:3.11.7-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies လိုအပ်ရင်ပဲ ထည့်ပါ (Telegram bot အတွက် တခါတလေ လိုတတ်တယ်)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first → ဒါက layer caching ကို ကောင်းကောင်း အသုံးချနိုင်တယ်
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Railway.app နဲ့ အလားတူ platform တွေအတွက် PORT ကို environment variable အနေနဲ့ ထားတယ်
# Local မှာ run တဲ့အခါ fallback အနေနဲ့ 8080 သုံးမယ်
ENV PORT=8080

# CMD ကို shell form နဲ့ ရေးထားတယ် → ဒါမှ $PORT ကို အလုပ်လုပ်မယ်
# ${PORT:-8080} ဆိုတာက PORT မရှိရင် 8080 ကို fallback လုပ်ပေးတယ်
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT:-8080}
