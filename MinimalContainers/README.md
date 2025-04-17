# Minimal Containers

When building container images, we often start from technology-specific base images in order to obtain a ready-made environment for building the container. For example, when building a Python application, we might start with a base image which already has Python installed, as well as common tools like `pip`. While this approach is very convenient, it is not ideal from a security point of view. The reason for this is that the resulting images then contain binaries and scripts which are only needed at build time, but not at runtime of the application. Such binaries and scripts expose an unnecessary attack surface. Furthermore, including a shell and network tools like `nslookup`, `nc` or `curl` in your image, provides an attacker with a toolbox for further exploits.

We can mitigate this by using multi-stage builds for building our container images. Multistage builds allow us to use conveniently rich images for building an application and the copying only the require artifacts to a second much leaner runtime image.

## Examples

### A minimal Python application image

Images for applications written in interpreted languages like Python or Node.js can usually be stripped down to a minimal runtime. Consider the following non-optimal Dockerfile:

```Dockerfile
FROM python:3.9

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY src/ .

CMD [ "python", "./example.py" ]
```

Use the following command to build a non-minimal image for a Python Flask application:

```shell
export REPO="<your container registry>"
docker build examples/python -f examples/python/Dockerfile -t "$REPO/python-example:0.0.1"
```

Now consider the same application in a multistage build:

```Dockerfile
FROM python:3.9 AS builder
COPY requirements.txt .

RUN pip install --user -r requirements.txt

FROM python:3.9-alpine
WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY ./src .

ENV PATH=/root/.local:$PATH

CMD [ "python", "./server.py" ]
```

Use the following command to build an optimized image for a Python Flask application:

```shell
docker build examples/python -f examples/python/minimal.Dockerfile -t "$REPO/python-minimal-example:0.0.1"
```

We can compare the two images using the `dive` tool for inspecting container images:

```shell
dive "$REPO/python-example:0.0.1"
```

Just looking at the size we see that this image is more than 800 megabytes.

```shell
dive "$REPO/python-minimal-example:0.0.1"
```

If we look at the size of the minimal image, we see that it is less than 60 megabytes.

### A distroless Go application image

Images for applications written in a compiled language like Go can be stripped down even further, starting from `scratch` in the image build and adding only the compiled binary.

In order to compare the situation in this case, we consider this non-minimal image:

```Dockerfile
FROM golang:1
WORKDIR /usr/src/app
COPY . ./
RUN go build -o app

EXPOSE 8080
ENTRYPOINT ["./app"]
```

We can build it using the following command:

```shell
docker build examples/golang -f examples/golang/Dockerfile -t "$REPO/golang-example:0.0.1"
```

Now consider this multistage build. Note that the second build stage starts from `scratch`, which is the keyword for an empty image.

```Dockerfile
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
```

We can build it using the following command:

```shell
docker build examples/golang -f examples/golang/minimal.Dockerfile -t "$REPO/golang-minimal-example:0.0.1"
```

We can again compare the two images using the `dive` tool for inspecting container images.

```shell
dive "$REPO/golang-example:0.0.1"
```

Just looking at the size we see that this image is more than 800 megabytes.

```shell
dive "$REPO/golang-minimal-example:0.0.1"
```

If we look at the size of the minimal image, we see that it is less than 5 megabytes and contains almost only the built binary.
