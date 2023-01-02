#!/bin/bash
set -e

export RACK_ENV=production

if [ -f db/sqlite3/production.sqlite3 ]; then
    bundle exec rake db:migrate
else
    bundle exec rake db:setup
fi

# Exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
