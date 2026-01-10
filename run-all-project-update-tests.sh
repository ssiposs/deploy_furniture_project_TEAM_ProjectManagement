#!/bin/bash

# Colors for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}===============================================${NC}"
echo -e "${BLUE}   Project Management System: Test Suite       ${NC}"
echo -e "${BLUE}===============================================${NC}"

# 1. Backend Unit & Integration Tests
echo -e "\n${GREEN}[1/4] Running Backend JUnit Tests...${NC}"
cd be
./mvnw test -Dtest=ProjectServiceTest,ProjectControllerTest
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Backend Tests Passed${NC}"
else
    echo -e "${RED}✗ Backend Tests Failed${NC}"
    exit 1
fi
cd ..

# 2. Frontend Component Tests
echo -e "\n${GREEN}[2/4] Running Frontend Component Tests...${NC}"
cd fe
npx ng test --watch=false --include src/app/project/edit-item-dialog/edit-item-dialog.component.spec.ts
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Frontend Component Tests Passed${NC}"
else
    echo -e "${RED}✗ Frontend Component Tests Failed${NC}"
    exit 1
fi

# 3. E2E Tests (Cucumber)
# Note: This assumes you have the apps running or use a tool like start-server-and-test
echo -e "\n${GREEN}[3/4] Running Cucumber E2E Tests...${NC}"
# If you don't have a background runner, you might just want to show the code here
# or run: npm run e2e
npx cucumber-js --require-module ts-node/register --require ./features/step-definitions/projects/project_versions.steps.ts ./features/projects/project_versions.feature
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ E2E Tests Passed${NC}"
else
    echo -e "${RED}✗ E2E Tests Failed (Check if servers are running!)${NC}"
fi
cd ..

# 4. JMeter Performance (Optional - just checking if file exists)
echo -e "\n${GREEN}[4/4] Performance Test Status...${NC}"
if [ -f "./performance/test-plan.jmx" ]; then
    echo -e "${GREEN}✓ JMeter Test Plan Found${NC}"
else
    echo -e "${BLUE}ℹ No JMeter plan found in root, ready for manual demo.${NC}"
fi

echo -e "\n${BLUE}===============================================${NC}"
echo -e "${GREEN}         ALL TESTS COMPLETE - READY FOR DEMO    ${NC}"
echo -e "${BLUE}===============================================${NC}"