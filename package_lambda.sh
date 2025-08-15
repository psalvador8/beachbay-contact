#!/bin/bash

# Move into the lambda directory
cd lambda || { echo "lambda directory not found"; exit 1; }

# Clean old node_modules and package.zip to start fresh
rm -rf node_modules package-lock.json package.zip

# Install dependencies locally
npm install

# Zip index.js and node_modules into package.zip
zip -r package.zip index.js node_modules

echo "Packaging complete! Created lambda/package.zip"
