# Gin Go API (Dockerized)

Simple Go API using Gin with two endpoints:
- `GET /health` -> `{ "status": "ok" }`
- `GET /hello?name=YourName` -> `{ "message": "hello YourName" }` (defaults to `world`)

## Prerequisites
- Go 1.22+
- Docker (optional, if running via container)

## Run locally
```bash
# From project root
go run .
# Or build and run
# go build -o server . && ./server
```

Then test:
```bash
curl -s http://localhost:8080/health
curl -s "http://localhost:8080/hello?name=Gin"
```

## Run with Docker
```bash
# Build image
docker build -t gin-api .

# Run container (maps 8080 -> 8080)
docker run --rm -p 8080:8080 gin-api
```

Test:
```bash
curl -s http://localhost:8080/health
curl -s http://localhost:8080/hello
```

## Configuration
- Port can be overridden via `PORT` env var (default `8080`).
  - Example: `PORT=9000 go run .`
  - Docker: `docker run --rm -e PORT=9000 -p 9000:9000 gin-api`

## Project Structure
```
.
├── Dockerfile
├── README.md
├── go.mod
├── main.go
└── .dockerignore
```
