FROM jenkins/jenkins:lts-jdk17

USER root

# Install Docker CLI
RUN curl -fsSL https://get.docker.com | sh

# Give Jenkins user Docker access
RUN usermod -aG docker jenkins

USER jenkins

# Optional: Preinstall plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

