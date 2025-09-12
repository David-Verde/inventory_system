#!/bin/bash
set -e

# Elimina un archivo server.pid pre-existente.
rm -f /rails/tmp/pids/server.pid

# Luego ejecuta el comando principal del contenedor (lo que pusimos en CMD en el Dockerfile)
exec "$@"