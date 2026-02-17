"""
URL configuration for config project.
"""
from django.http import JsonResponse, HttpResponse
from django.urls import path
import redis

redis_client = redis.Redis(host='redis-db', port=6379, decode_responses=True)

def hello(request):
    """Endpoint utama yang menghitung jumlah kunjungan"""
    visits = redis_client.incr('django-visits')
    return HttpResponse(f'<h2>Django Service - Anda adalah pengunjung ke: {visits}</h2>')

def health(request):
    """Endpoint untuk health check"""
    try:
        redis_client.ping()
        return JsonResponse({'status': 'healthy', 'service': 'Django'})
    except:
        return JsonResponse({'status': 'unhealthy', 'service': 'Django'}, status=500)

urlpatterns = [
    path('', hello, name='hello'),
    path('health/', health, name='health'),
]
