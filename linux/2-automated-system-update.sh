#!/bin/bash

LOG_FILE="/home/ubuntu/parkee/linux/update_$(date +%Y%m%d%H%M%S).log"

echo "Starting system update at $(date)" | tee -a "$LOG_FILE"

if command -v apt-get &> /dev/null; then
    PACKAGE_MANAGER="apt-get"
    echo "Using apt-get for updates." | tee -a "$LOG_FILE"
    sudo apt-get update | tee -a "$LOG_FILE" && sudo apt-get upgrade -y | tee -a "$LOG_FILE"
elif command -v yum &> /dev/null; then
    PACKAGE_MANAGER="yum"
    echo "Using yum for updates." | tee -a "$LOG_FILE"
    sudo yum update -y | tee -a "$LOG_FILE"
elif command -v dnf &> /dev/null; then
    PACKAGE_MANAGER="dnf"
    echo "Using dnf for updates." | tee -a "$LOG_FILE"
    sudo dnf update -y | tee -a "$LOG_FILE"
else
    echo "Error: No supported package manager (apt, yum, dnf) found." | tee -a "$LOG_FILE"
    exit 1
fi

echo "System update finished at $(date)" | tee -a "$LOG_FILE"
echo "Log saved to: $LOG_FILE"