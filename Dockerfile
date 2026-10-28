FROM golang:1.21-alpine AS builder
WORKDIR /app

# Initialize a temporary Go module
RUN go mod init app

# Create a sample main.go so the build succeeds
RUN echo 'package main; import "fmt"; func main() { fmt.Println("Hello from DevOps Pipeline!") }' > main.go

RUN go build -o main .

FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
