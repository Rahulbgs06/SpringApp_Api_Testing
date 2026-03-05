#!/bin/bash

BASE_URL="http://localhost:8083/api/v1/users"

echo "══════════════════════════════════════════════"
echo "     JENKINS API TEST SUITE"
echo "══════════════════════════════════════════════"
echo "Started at: $(date)"
echo ""

# Function to print test results
print_test() {
    echo ""
    echo "▶ Test $1: $2"
    echo "──────────────────────────────────────────"
    echo "$3"
    if [ "$4" = "PASS" ]; then
        echo "✅ Status: PASS"
    else
        echo "❌ Status: FAIL"
    fi
}

# Test 1: Ping
PING=$(curl -s $BASE_URL/ping)
print_test "1" "Ping Endpoint" "Response: $PING" "PASS"

# Test 2: Create User
CREATE=$(curl -s -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{"name":"Jenkins User","email":"jenkins@test.com"}')
ID=$(echo $CREATE | grep -o '"id":[0-9]*' | cut -d':' -f2)
print_test "2" "Create User" "Response: $CREATE\nUser ID: $ID" "PASS"

# Test 3: Get User by ID
GET=$(curl -s $BASE_URL/id/$ID)
print_test "3" "Get User $ID" "Response: $GET" "PASS"

# Test 4: Get All Users
ALL=$(curl -s $BASE_URL)
COUNT=$(echo $ALL | grep -o '"id"' | wc -l)
print_test "4" "Get All Users" "Total Users: $COUNT\nResponse: $ALL" "PASS"

# Test 5: Delete User
DELETE=$(curl -s -X DELETE $BASE_URL/id/$ID)
print_test "5" "Delete User $ID" "Response: $DELETE" "PASS"

# Test 6: Verify Deletion
VERIFY=$(curl -s -w " (HTTP %{http_code})" $BASE_URL/id/$ID)
print_test "6" "Verify Deletion" "Response: $VERIFY" "PASS"

echo ""
echo "══════════════════════════════════════════════"
echo "✅ ALL TESTS COMPLETED AT: $(date)"
echo "══════════════════════════════════════════════"
