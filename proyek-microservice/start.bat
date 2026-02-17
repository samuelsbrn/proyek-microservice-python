@echo off
REM Windows batch script untuk Docker Compose operations

if "%1"=="build" (
    echo Building all services...
    docker-compose build
) else if "%1"=="up" (
    echo Starting all services...
    docker-compose up -d
) else if "%1"=="down" (
    echo Stopping all services...
    docker-compose down
) else if "%1"=="logs" (
    if "%2"=="" (
        docker-compose logs -f
    ) else (
        docker-compose logs -f %2
    )
) else if "%1"=="rebuild" (
    echo Rebuilding and starting all services...
    docker-compose up --build -d
) else if "%1"=="status" (
    docker-compose ps
) else if "%1"=="test" (
    echo Testing Flask...
    curl http://localhost:5001/
    echo.
    echo Testing FastAPI...
    curl http://localhost:5002/
    echo.
    echo Testing Django...
    curl http://localhost:5003/
) else (
    echo Usage:
    echo   docker-compose.bat build    - Build all services
    echo   docker-compose.bat up       - Start all services in background
    echo   docker-compose.bat down     - Stop all services
    echo   docker-compose.bat logs     - View logs (all or specific service)
    echo   docker-compose.bat rebuild  - Rebuild and start services
    echo   docker-compose.bat status   - Show service status
    echo   docker-compose.bat test     - Test all endpoints
)
