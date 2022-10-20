#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -rf /rails-app/tmp/pids/server.pid

rails db:create;

rails db:migrate;

exec "$@"