# Java Spring Boot DevOps Pipeline Project
## Project Overview
This project demonstrates a complete CI/CD pipeline implementation using modern DevOps tools and practices. The pipeline follows the sequence:

Git ➜ Jenkins ➜ Maven ➜ SonarQube ➜ Docker ➜ Trivy ➜ Kubernetes ➜ Slack

## Important Note
The Jenkinsfile in this repository is currently experiencing compatibility issues. Please use the provided pipeline-script.txt for Jenkins pipeline configuration instead. The script version has been tested and works correctly with the current setup.

## Technologies Used
- Java 17
- Spring Boot 3.3.11
- Maven
- Jenkins
- SonarQube
- Docker
- Kubernetes
- Trivy (for security scanning)
## Project Structure
```
java-maven-app/
├── src/                    # Application source code
├── k8s/                    # Kubernetes configurations
├── pom.xml                 # Maven configuration
├── Dockerfile              # Container image definition
├── pipeline-script.txt     # Working Jenkins pipeline script
├── Jenkinsfile            # (Currently not working)
└── sonar-project.properties
```
## Setup Instructions

### Local Development
```
# Build the application
mvn clean install

# Run locally
java -jar target/*.jar
```
### Docker Build
```
docker build -t your-registry/java-maven-app:latest .
docker run -p 8081:8081 your-registry/java-maven-app:latest
```
### Jenkins Pipeline Setup
1. Create a new Pipeline job in Jenkins
2. Copy contents from pipeline-script.txt
3. Configure environment variables as needed
4. Run the pipeline
### Kubernetes Deployment
```
kubectl apply -f k8s/
```
## Application Endpoints
- Health Check: http://localhost:8081/hello
## Configuration
- Application runs on port 8081
- Kubernetes service exposes port 80
- SonarQube configuration in sonar-project.properties
## Security Features
- Trivy scanning for vulnerabilities
- Resource limits in Kubernetes
- Fixed dependency versions
## Monitoring
- Kubernetes readiness probe
- Basic Spring Boot actuator endpoints
- SonarQube quality metrics
## Future Improvements
- Implement automated testing
- Add Prometheus metrics
- Configure horizontal pod autoscaling
## Contributing
Contributions are welcome. Please follow the standard fork and pull request workflow.