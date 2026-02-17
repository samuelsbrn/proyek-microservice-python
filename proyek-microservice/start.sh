#!/bin/bash
# Linux/Mac bash script untuk Docker Compose operations

case "$1" in
  build)
    echo "Building all services..."
    docker-compose build
    ;;
  up)
    echo "Starting all services..."
    docker-compose up -d
    ;;
  down)
    echo "Stopping all services..."
    docker-compose down
    ;;
  logs)
    if [ -z "$2" ]; then
      docker-compose logs -f
    else
      docker-compose logs -f "$2"
    fi
    ;;
  rebuild)
    echo "Rebuilding and starting all services..."
    docker-compose up --build -d
    ;;
  status)
    docker-compose ps
    ;;
  test)
    echo "Testing Flask..."
    curl http://localhost:5001/
    echo -e "\n"
    echo "Testing FastAPI..."
    curl http://localhost:5002/
    echo -e "\n"
    echo "Testing Django..."
    curl http://localhost:5003/
    ;;
  *)
    echo "Usage:"
    echo "  $0 build    - Build all services"
    echo "  $0 up       - Start all services in background"
    echo "  $0 down     - Stop all services"
    echo "  $0 logs     - View logs (all or specific service)"
    echo "  $0 rebuild  - Rebuild and start services"
    echo "  $0 status   - Show service status"
    echo "  $0 test     - Test all endpoints"
    ;;
esac
