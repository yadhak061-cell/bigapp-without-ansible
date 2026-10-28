FROM golang:1.21-alpine AS builder
WORKDIR /app

RUN go mod init app
COPY main.go .
RUN go build -o main .

FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
