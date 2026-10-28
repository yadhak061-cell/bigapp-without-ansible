FROM golang:1.21-alpine AS builder
WORKDIR /app
RUN go mod init app

# Create a proper HTTP server that stays running
cat << 'GOEOF' > main.go
package main
import (
    "fmt"
    "net/http"
)
func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintln(w, "Hello from Dynamic DevOps Pipeline!")
    })
    http.ListenAndServe(":8080", nil)
}
GOEOF

RUN go build -o main .

FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
