# syntax=docker/dockerfile:1

# Build stage
FROM golang:1-alpine AS builder
WORKDIR /app
ENV CGO_ENABLED=0

# Cache dependencies
COPY go.mod ./
RUN --mount=type=cache,target=/go/pkg/mod go mod download

# Copy source
COPY . .

# Build
RUN --mount=type=cache,target=/go/pkg/mod go build -o server .

# Runtime stage
FROM scratch
WORKDIR /app
ENV GIN_MODE=release

# Non-root user (optional for simplicity, keeping root; uncomment if desired)
# RUN adduser -D -g '' appuser
# USER appuser

COPY --from=builder /app/server /app/server
EXPOSE 8080
CMD ["/app/server"]
