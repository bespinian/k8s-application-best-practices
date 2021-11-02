FROM golang:1 as builder
RUN groupadd -r app && useradd --no-log-init -r -g app app
WORKDIR /usr/src/app
COPY . ./
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -a -installsuffix cgo -o bin/app

FROM scratch
WORKDIR /usr/app
COPY --from=builder /usr/src/app/bin/app ./
COPY --from=builder /etc/passwd /etc/passwd
USER app
EXPOSE 8080
ENTRYPOINT ["./app"]
