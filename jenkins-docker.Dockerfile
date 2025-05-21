# jenkins-docker.Dockerfile
FROM jenkins/jenkins:lts-jdk11

USER root

# Install Docker CLI inside Jenkins container
RUN apt-get update && \
    apt-get install -y docker.io && \
    apt-get clean

# Allow jenkins user to access docker socket
RUN usermod -aG docker jenkins

USER jenkins
