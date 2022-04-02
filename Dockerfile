FROM golang:1.18-alpine
WORKDIR /app-build
COPY go.mod ./
#COPY go.sum ./
# May change to "RUN go mod tidy" later
RUN go mod download
# Only go file(s) in git root is needed as for now
COPY *.go ./
RUN CGO_ENABLED=0 go build -o my-test-app

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /app-bin/
COPY --from=0 /app-build/my-test-app ./
CMD ["./my-test-app"]  