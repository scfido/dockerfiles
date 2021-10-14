#!/bin/sh
set -e

# if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
#   set -- node "$@"
# fi

# exec "$@"

echo "Environments:"
echo ".NET:        "$(dotnet --version)
echo "NodeJS:      "$(node --version)
echo "Power Shell: "$(pwsh --version)
echo "npm:         "$(npm --version)
echo "Yarn:        "$(npm --version)

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- node "$@"
fi

exec "$@"