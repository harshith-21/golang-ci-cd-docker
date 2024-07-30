# Use the specified Golang image to build the binary
FROM golang:1.22-alpine3.20 AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the source from the current directory to the Working Directory inside the container
COPY ./app .

# Build the Go app
RUN go build -o app-binary

# Start a new stage from scratch
FROM alpine:3.20

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/app-binary /app-binary

# Expose port 4000 to the outside world
EXPOSE 4000

# Command to run the executable
CMD ["/app-binary"]
