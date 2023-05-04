# Base image
FROM node:16

# Set the working directory
WORKDIR /app

# Set the container name
ENV CONTAINER_NAME logging-service-visualizer

# Expose the application port
EXPOSE 9090

# Set the entry point
ENTRYPOINT ["bash", "/app/start.sh"]