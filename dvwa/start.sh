#!/bin/bash
set -e

echo "Starting MySQL..."
service mysql start

echo "Starting Apache..."
service apache2 start

echo "Waiting for services to initialize..."
sleep 5

echo "Starting Filebeat..."
exec filebeat -e

