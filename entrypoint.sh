#!/usr/bin/env sh
set -e

# Function to stop nginx and php-fpm
stop() {
  echo "Stopping Nginx and PHP-FPM..."
  kill -TERM "$NGINX_PID" "$PHP_FPM_PID"
  echo "Nginx and PHP-FPM stopped."
}

# Trap the SIGTERM signal and call the stop function
trap stop TERM INT

# Start php-fpm and get its PID
php-fpm -D
PHP_FPM_PID=$!

# Start nginx and get its PID
nginx -g "pid /tmp/nginx.pid; daemon off;" &
NGINX_PID=$!

# Wait for both processes to finish
wait "$NGINX_PID"
wait "$PHP_FPM_PID"