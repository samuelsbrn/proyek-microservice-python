from fastapi import FastAPI
from fastapi.responses import HTMLResponse
import redis
import uvicorn

app = FastAPI(title="FastAPI Service")

# Konek ke Redis - nama service adalah "redis-db"
redis_client = redis.Redis(host='redis-db', port=6379, decode_responses=True)

@app.get("/", response_class=HTMLResponse)
async def hello():
    """Endpoint utama yang menghitung jumlah kunjungan"""
    visits = redis_client.incr('fastapi-visits')
    return f'<h2>FastAPI Service - Anda adalah pengunjung ke: {visits}</h2>'

@app.get("/health")
async def health():
    """Endpoint untuk health check"""
    try:
        redis_client.ping()
        return {'status': 'healthy', 'service': 'FastAPI'}
    except:
        return {'status': 'unhealthy', 'service': 'FastAPI'}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5000)
