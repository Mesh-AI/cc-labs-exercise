#!/bin/bash

# Factory Inventory Management System - Timer Script
# Prints a tick every second up to DURATION seconds.
# Used to demonstrate long-running foreground commands and Ctrl+B backgrounding.
#
# Usage:
#   ./scripts/timer.sh          # 60 ticks (default)
#   ./scripts/timer.sh 120      # 120 ticks

set -e  # Exit on error

# Colors for output
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

DURATION="${1:-60}"

# Validate the argument is a positive integer
if ! [[ "$DURATION" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: duration must be a positive integer (got '$DURATION')" >&2
    exit 1
fi

echo -e "${YELLOW}Starting timer for ${DURATION}s...${NC}\n"

for i in $(seq 1 "$DURATION"); do
    echo "tick $i / $DURATION"
    sleep 1
done

echo -e "\n${GREEN}DONE - timer finished after ${DURATION}s${NC}"
