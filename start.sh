#!/bin/sh

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PORTS_FILE="/opt/modules-box/.tmp/user_ports.txt"

is_port_used() {
    port="$1"

    while IFS= read -r used_port; do
        [ "$used_port" = "$port" ] && return 0
    done < "$PORTS_FILE"

    return 1
}

generate_port() {
    while :; do
        port=$((3000 + $(od -An -N2 -tu2 /dev/urandom)))
        port=$((port % 62536 + 3000))

        if ! is_port_used "$port"; then
            echo "$port"
            return
        fi
    done
}

echo "starting transmission server..."

PORT=$(generate_port)

echo "selected port: $PORT"
echo "$PORT">&2

transmission-daemon -p "$PORT"