FROM jenkins/jenkins:lts-jdk17

USER root

# Install Docker CLI
RUN curl -fsSL https://get.docker.com | sh

# Install git (needed for Jenkins Git operations)
RUN apt-get update && apt-get install -y git

# Create docker group with same GID as host Docker group (default to 998)
ARG DOCKER_GID=1
RUN groupadd -g ${DOCKER_GID} docker || true
RUN usermod -aG docker jenkins || true

USER jenkins

# Optional: Preinstall plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt



