FROM jenkins/jenkins:lts-jdk17

USER root

# Install Docker CLI
RUN curl -fsSL https://get.docker.com | sh

# Create docker group with same GID as host Docker group (typically 998 or 999)
ARG DOCKER_GID=998
RUN groupadd -g ${DOCKER_GID} docker && usermod -aG docker jenkins || true

USER jenkins

# Optional: Preinstall plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt


