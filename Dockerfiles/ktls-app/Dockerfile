FROM golang:1.19

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY *.go ./

RUN go build -o ktls-app .

EXPOSE 8443

CMD ["./ktls-app"]