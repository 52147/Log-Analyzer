#!/bin/bash

# Function to analyze a log file
analyze_log_file() {
    local log_file="$1"
    
    # Count occurrences of specific events
    event_count=$(grep -cE 'ASL Sender Statistics' "$log_file")

    # Print analysis results
    echo "Log file: $log_file"
    echo "Number of 'ASL Sender Statistics' events: $event_count"
    echo "Timestamps:"

    # Extract and print timestamps
    grep -oE '[A-Z][a-z]{2} +[0-9]{1,2} [0-9]{2}:[0-9]{2}:[0-9]{2}' "$log_file" | while read -r timestamp; do
        echo "$timestamp"
    done
    echo "------------------------------"
}

# Main script logic
if [ $# -eq 0 ]; then
    echo "Usage: ./log_analyzer.sh <log_file1> [<log_file2> ...]"
    exit 1
fi

# Analyze each log file provided as command-line arguments
for log_file in "$@"; do
    if [ -f "$log_file" ]; then
        analyze_log_file "$log_file"
    else
        echo "Error: Log file '$log_file' not found."
    fi
done
