#!/bin/bash

# Ask user for API Base URL
read -p "Enter Base API URL (default http://localhost:8083/api/v1/users): " BASE_URL
BASE_URL=${BASE_URL:-http://localhost:8083/api/v1/users}

# Ask for user details
read -p "Enter Name for new user: " NAME
read -p "Enter Email for new user: " EMAIL

# Step 1: Create a new user
echo -e "\nCreating a new user..."
CREATE_RESPONSE=$(curl -s -X POST "$BASE_URL" \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"$NAME\",\"email\":\"$EMAIL\"}")

echo "Response: $CREATE_RESPONSE"

# Extract the user ID from the JSON response using jq
USER_ID=$(echo $CREATE_RESPONSE | jq -r '.id')
if [ "$USER_ID" == "null" ] || [ -z "$USER_ID" ]; then
  echo "Failed to create user. Exiting..."
  exit 1
fi
echo "User created with ID: $USER_ID"

# Step 2: Get all users after creation
echo -e "\nGetting all users..."
curl -s "$BASE_URL" | jq

# Step 3: Get the specific user by ID (using correct /id/ path)
echo -e "\nGetting user with ID: $USER_ID..."
curl -s "$BASE_URL/id/$USER_ID" | jq

# Step 4: Delete the created user (using correct /id/ path)
echo -e "\nDeleting user with ID: $USER_ID..."
DELETE_RESPONSE=$(curl -s -X DELETE "$BASE_URL/id/$USER_ID" -w " - Status: %{http_code}")
echo "Delete Response: $DELETE_RESPONSE"

# Step 5: Verify user is deleted (should return 404)
echo -e "\nVerifying user deletion (should return 404)..."
curl -s -w "Status: %{http_code}\n" "$BASE_URL/id/$USER_ID"

# Step 6: Get all users after deletion
echo -e "\nGetting all users after deletion..."
curl -s "$BASE_URL" | jq

echo -e "\nAPI test flow completed successfully!"
