# صورة أساس مستقرة
FROM ubuntu:22.04

# ما تخليش apt يسوّل فالنصّب
ENV DEBIAN_FRONTEND=noninteractive

# تحديث + أدوات أساسية
RUN apt-get update && apt-get install -y \
    bash curl ca-certificates git wget unzip \
    && rm -rf /var/lib/apt/lists/*

# الديركتوري ديال التطبيق
WORKDIR /app

# نسخ جميع ملفات البروجيكت
COPY . .

# نعطي صلاحيات للسكريبتات
RUN chmod +x install.sh bm.sh update.sh || true

# شغّل سكريبت التنصيب (إلا ما كانش، ما يضرش)
RUN bash ./install.sh || true

# خلي PORT متاح افتراضياً
ENV PORT=3000

# البورت الداخل اللي غادي نسمعو عليه
EXPOSE 3000

# مهم بزاف: bm.sh خاصو يشغّل السيرفر ويربط على 0.0.0.0:$PORT
CMD ["bash", "./bm.sh"]
