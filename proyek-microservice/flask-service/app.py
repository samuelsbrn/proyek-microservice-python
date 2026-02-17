from flask import Flask
import redis

app = Flask(__name__)

# Konek ke Redis - nama service adalah "redis-db"
redis_client = redis.Redis(host='redis-db', port=6379, decode_responses=True)

@app.route('/')
def hello():
    """Endpoint utama yang menghitung jumlah kunjungan"""
    visits = redis_client.incr('flask-visits')
    return f'<h2>Flask Service - Anda adalah pengunjung ke: {visits}</h2>'

@app.route('/health')
def health():
    """Endpoint untuk health check"""
    try:
        redis_client.ping()
        return {'status': 'healthy', 'service': 'Flask'}
    except:
        return {'status': 'unhealthy', 'service': 'Flask'}, 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
