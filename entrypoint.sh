#!/bin/bash
set -e

export RACK_ENV=production
bundle exec rake db:prepare

# Exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
