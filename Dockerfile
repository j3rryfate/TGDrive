# Official slim Python image သုံးပါ (ပေါ့ပါးပြီး လုံခြုံတယ်)
FROM python:3.11.7-slim

# Working directory သတ်မှတ်ပါ
WORKDIR /app

# System dependencies လိုအပ်ရင် ထည့်ပါ (gcc နဲ့ python-dev က Telegram bot အတွက် တခါတလေ လိုတတ်တယ်)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Requirements အရင်ကော်ပီ → caching ကောင်းအောင်
COPY requirements.txt .

# Dependencies ထည့်ပါ
RUN pip install --no-cache-dir -r requirements.txt

# ကျန်တဲ့ code အားလုံး ကော်ပီ
COPY . .

# Optional: local testing အတွက် fallback
ENV PORT=8080

# EXPOSE ထည့်ထားရင် ပိုကောင်းတယ် (Railway က မလိုအပ်ပေမယ့် ကောင်းတယ်)
EXPOSE 8080

# Shell form နဲ့ ရေးပါ → $PORT ကို expand လုပ်ပေးမယ်
# ${PORT:-8080} ဆိုတာ PORT မရှိရင် 8080 ကို သုံးမယ်
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT:-8080}
