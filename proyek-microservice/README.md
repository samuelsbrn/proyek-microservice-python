# Microservices Python Project
# Tiga layanan Python yang berbeda (Flask, FastAPI, Django) dijalankan bersama

## Struktur Proyek

```
proyek-microservice/
├── docker-compose.yml          # Orkestrasi ketiga layanan
├── flask-service/
│   ├── Dockerfile
│   ├── app.py                  # Flask application
│   └── requirements.txt
├── fastapi-service/
│   ├── Dockerfile
│   ├── app.py                  # FastAPI application
│   └── requirements.txt
├── django-service/
│   ├── Dockerfile
│   ├── manage.py
│   ├── requirements.txt
│   ├── config/
│   │   ├── settings.py
│   │   ├── urls.py
│   │   ├── wsgi.py
│   │   └── __init__.py
│   └── api/
│       ├── __init__.py
│       └── apps.py
└── README.md                   # Dokumentasi ini
```

## Port Layanan

- **Flask**: http://localhost:5001/
- **FastAPI**: http://localhost:5002/
- **Django**: http://localhost:5003/
- **Redis**: localhost:6379

## Cara Menjalankan

### 1. Build dan Start Semua Service
```bash
docker-compose up --build
```

### 2. Stop Semua Service
```bash
docker-compose down
```

### 3. View Logs
```bash
# Semua service
docker-compose logs -f

# Spesifik service
docker-compose logs -f flask-app
docker-compose logs -f fastapi-app
docker-compose logs -f django-app
```

## Fitur

Semua layanan memiliki:
- ✅ Endpoint utama `/` - menampilkan counter kunjungan dari Redis
- ✅ Endpoint `/health` - health check
- ✅ Terhubung ke database Redis bersama
- ✅ Containerized dengan Docker
- ✅ Network bridge untuk komunikasi antar service

## Contoh Request

### Flask
```bash
curl http://localhost:5001/
curl http://localhost:5001/health
```

### FastAPI
```bash
curl http://localhost:5002/
curl http://localhost:5002/health
curl http://localhost:5002/docs  # Interactive API documentation
```

### Django
```bash
curl http://localhost:5003/
curl http://localhost:5003/health/
```

## Teknologi

- **Flask**: Microframework ringan
- **FastAPI**: Framework modern, async-first
- **Django**: Full-featured framework
- **Redis**: In-memory data store
- **Docker**: Container orchestration

## Catatan

- Semua service berbagi Redis yang sama untuk demonstrasi
- Setiap service menghitung visit counter-nya sendiri di Redis (prefixed dengan nama service)
- Menggunakan Python 3.11 slim image untuk ukuran yang lebih kecil
