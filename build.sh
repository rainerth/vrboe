#!/bin/bash

# Build script for vrboe Hugo site
# Builds with --buildFuture (Termine in der Zukunft sichtbar) and Pagefind index.

set -e

echo "🏗️  Building Hugo site..."
hugo --cleanDestinationDir --buildFuture --minify

echo "🔍 Generating Pagefind search index..."
npx pagefind --site public --output-subdir pagefind

echo "✅ Build complete — public/ ready."
