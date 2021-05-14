#!/usr/bin/env bash

# starts a new server with the fadmin scenario for testing
# assumes latest version of factorio is in the PATR

source .env
[ ! -d server ] && mkdir server
cd server
[ ! -d scenarios ] && mkdir scenarios
[ ! -L scenarios/fadmin ] && ln -rs ../scenario scenarios/fadmin

[ ! -f config.ini ] && cat > config.ini << EOF
[path]
read-data=__PATH__executable__/../../data
write-data=.
EOF

echo "[\"$DEBUG_PLAYER\"]" > server-adminlist.json
factorio --config config.ini testing --start-server-load-scenario fadmin --rcon-bind "$RCON_HOST:$RCON_PORT" --rcon-password "$RCON_PWD" &

PID=$!
echo $PID > $(cd .. && realpath "$FACTORIO_PIDFILE")
trap "" SIGINT
wait $PID
