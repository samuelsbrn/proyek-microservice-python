# Quick Start Guide

## Prerequisites
- Docker
- Docker Compose

## Langkah-Langkah Jalankan

### 1. **Build dan Start Services** (Pertama Kali)
```bash
# Windows
start.bat rebuild

# Linux/Mac  
chmod +x start.sh
./start.sh rebuild

# Atau langsung
docker-compose up --build -d
```

### 2. **Lihat Status Services**
```bash
docker-compose ps
```

Atau gunakan script:
```bash
# Windows
start.bat status

# Linux/Mac
./start.sh status
```

### 3. **Test Endpoints**

**Flask** (http://localhost:5001/):
```bash
curl http://localhost:5001/
curl http://localhost:5001/health
```

**FastAPI** (http://localhost:5002/):
```bash
curl http://localhost:5002/
curl http://localhost:5002/health
# Akses documentation di: http://localhost:5002/docs
```

**Django** (http://localhost:5003/):
```bash
curl http://localhost:5003/
curl http://localhost:5003/health/
```

Atau gunakan script test:
```bash
# Windows
start.bat test

# Linux/Mac
./start.sh test
```

### 4. **Lihat Logs**

Semua service:
```bash
docker-compose logs -f
```

Service tertentu:
```bash
# Windows
start.bat logs flask-app
start.bat logs fastapi-app
start.bat logs django-app

# Linux/Mac
./start.sh logs flask-app
./start.sh logs fastapi-app
./start.sh logs django-app

# Atau langsung
docker-compose logs -f flask-app
docker-compose logs -f fastapi-app
docker-compose logs -f django-app
```

### 5. **Stop Services**
```bash
# Windows
start.bat down

# Linux/Mac
./start.sh down

# Atau langsung
docker-compose down
```

## Architecture

```
┌─────────────────────────────────────────────┐
│         Docker Network Bridge               │
├─────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐         │
│  │   Flask      │  │   FastAPI    │         │
│  │  :5001/5000  │  │  :5002/5000  │         │
│  └──────┬───────┘  └──────┬───────┘         │
│         └──────────┬───────┘                │
│                    │                        │
│  ┌──────────────┐  │  ┌──────────────┐     │
│  │   Django     │──┼──│   Redis DB   │     │
│  │  :5003/5000  │  │  │  :6379       │     │
│  └──────────────┘  │  └──────────────┘     │
│                    │      (redis-db)       │
└─────────────────────────────────────────────┘

  Endpoint Monitoring: /health
```

## Troubleshooting

### Port sudah terpakai
```bash
# Ubah port di docker-compose.yml
# Atau kill process yang menggunakan port
# Windows
netstat -ano | findstr :5001
taskkill /PID <PID> /F

# Linux/Mac
lsof -i :5001
kill -9 <PID>
```

### Service tidak bisa connect ke Redis
```bash
# Verifikasi Redis berjalan
docker-compose ps

# Cek Redis connection
docker-compose exec flask-app redis-cli -h redis-db ping
```

### Container tidak start
```bash
# Lihat detail error
docker-compose logs <service-name>

# Coba rebuild
docker-compose build --no-cache
docker-compose up --build
```

## Struktur File

```
.
├── docker-compose.yml           # Main orchestration file
├── README.md                     # Documentation
├── QUICKSTART.md                 # File ini
├── start.bat                     # Windows helper script
├── start.sh                      # Linux/Mac helper script
├── flask-service/
│   ├── app.py                    # Flask application
│   ├── requirements.txt
│   └── Dockerfile
├── fastapi-service/
│   ├── app.py                    # FastAPI application
│   ├── requirements.txt
│   └── Dockerfile
└── django-service/
    ├── manage.py
    ├── requirements.txt
    ├── Dockerfile
    └── config/
        ├── settings.py
        ├── urls.py
        └── wsgi.py
```

## Tips & Tricks

### 1. Jalankan Command di Container
```bash
# Flask shell
docker-compose exec flask-app python

# FastAPI debug mode
docker-compose exec fastapi-app bash

# Django shell
docker-compose exec django-app python manage.py shell
```

### 2. Rebuild Hanya 1 Service
```bash
docker-compose build flask-app
docker-compose up -d flask-app
```

### 3. Lihat Environment Variables
```bash
docker-compose exec flask-app env
```

### 4. Lihat Network Info
```bash
docker network ls
docker network inspect <network-name>
```

## Development Tips

- Semua service sudah dikonfigurasi untuk hot-reload
- Flask memiliki `debug=True` untuk development
- FastAPI berjalan dengan uvicorn dalam development mode
- Django menggunakan gunicorn untuk production-like environment
- Semua service terhubung ke Redis instance yang sama

Selamat! Anda sekarang memiliki microservices yang berjalan dengan Docker Compose! 🚀
