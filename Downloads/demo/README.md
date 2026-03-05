# User Management API

A Spring Boot REST API for user management with MySQL database integration. Supports create, read, and delete operations.

## Tech Stack
- Java 17
- Spring Boot 4.0.3
- MySQL 8
- Docker & Docker Compose
- Maven

## Prerequisites
- Docker and Docker Compose installed
- Java 17 (for local development without Docker)
- Maven (for local builds)
- Git

## How to Run

### Using Docker (Recommended)
```bash
# 1. Clone the repository
git clone https://github.com/yourusername/user-management-api.git
cd user-management-api

# 2. Build the application
./mvnw clean package -DskipTests

# 3. Start with Docker Compose
docker-compose up -d --build

# 4. Check if application is running
curl http://localhost:8083/api/v1/users/ping


RUN LOCALLY WIHOUT DOCKER
# 1. Update application.properties with your MySQL credentials
# Change: jdbc:mysql://localhost:3306/demo_db

# 2. Run the application
./mvnw spring-boot:run


API Endpoints
Method	Endpoint	Description
GET	/api/v1/users/ping	Health check
GET	/api/v1/users	Get all users
GET	/api/v1/users/id/{id}	Get user by ID
POST	/api/v1/users	Create new user
DELETE	/api/v1/users/id/{id}	Delete user

Testing Commands
Using Curl Commands
# 1. Health check
curl http://localhost:8083/api/v1/users/ping

# 2. Get all users
curl http://localhost:8083/api/v1/users

# 3. Create a user
curl -X POST http://localhost:8083/api/v1/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@example.com"}'

# 4. Get user by ID (replace 1 with actual ID)
curl http://localhost:8083/api/v1/users/id/1

# 5. Delete user (replace 1 with actual ID)
curl -X DELETE http://localhost:8083/api/v1/users/id/1

Using Test Script
# Make script executable
chmod +x test-curl.sh

# Run all tests
./test-curl.sh

Docker Commands
# Build and start containers
docker-compose up -d --build -mysql
wiat 15sec to be rady 
docker-compose up -d --build -springboot

# View logs
docker-compose logs -f springboot
docker-compose logs -f mysql

# Stop containers
docker-compose down

# Stop and remove volumes (clears database)
docker-compose down -v

# Restart containers
docker-compose restart

# Check container status
docker ps

# Execute commands inside container
docker exec -it springboot-container sh
docker exec -it mysql-container mysql -uroot -p

LICENSE
MIT

## Save and Push to Git:

```bash
# Create the README file
cat > README.md << 'EOF'
[PASTE THE ABOVE CONTENT HERE]
EOF

# Add to git
git add README.md
git commit -m "Add README documentation"
git push
