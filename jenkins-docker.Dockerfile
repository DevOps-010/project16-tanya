FROM jenkins/jenkins:lts-jdk17

USER root

# Install Docker CLI
RUN curl -fsSL https://get.docker.com | sh

# Install git (needed for Jenkins Git operations)
RUN apt-get update && apt-get install -y git

# Install Trivy (security scanner)
RUN apt-get install -y apt-transport-https curl gnupg lsb-release ca-certificates && \
    curl -sfL https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor -o /usr/share/keyrings/trivy-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/trivy-archive-keyring.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" > /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install -y trivy

# ✅ Install kubectl
RUN curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Create docker group with same GID as host Docker group (default to 998)
ARG DOCKER_GID=1
RUN groupadd -g ${DOCKER_GID} docker || true
RUN usermod -aG docker jenkins || true

USER jenkins

# Optional: Preinstall plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
