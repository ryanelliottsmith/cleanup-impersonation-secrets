# Use a base image that has Docker and Kubernetes CLI installed
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*


RUN curl -LO "https://dl.k8s.io/release/v1.28.6/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# Copy your script into the container
COPY delete-secrets.sh /usr/local/bin/delete-secrets.sh

# Make the script executable
RUN chmod +x /usr/local/bin/delete-secrets.sh

# Set the entrypoint to your script
ENTRYPOINT ["/usr/local/bin/delete-secrets.sh"]
