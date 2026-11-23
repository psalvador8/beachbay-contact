#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/lambda"
rm -rf node_modules package.zip
npm ci
zip -q -r package.zip index.js node_modules
echo "Created lambda/package.zip"
