#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start|stop|status> <service_name>"
    exit 1
fi

action="$1"
service_name="$2"

if ! command -v systemctl &> /dev/null; then
    echo "Error: systemctl command not found. This script requires systemd."
    exit 1
fi

case "$action" in
    start)
        echo "Starting service '$service_name'..."
        sudo systemctl start "$service_name"
        if [ $? -eq 0 ]; then
            echo "Service '$service_name' started successfully."
        else
            echo "Error: Failed to start service '$service_name'."
        fi
        ;;
    stop)
        echo "Stopping service '$service_name'..."
        sudo systemctl stop "$service_name"
        if [ $? -eq 0 ]; then
            echo "Service '$service_name' stopped successfully."
        else
            echo "Error: Failed to stop service '$service_name'."
        fi
        ;;
    status)
        echo "Checking status of service '$service_name'..."
        systemctl status "$service_name"
        ;;
    *)
        echo "Invalid action: '$action'. Please use 'start', 'stop', or 'status'."
        exit 1
        ;;
esac