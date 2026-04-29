#!/bin/bash

# Build script for vrboe Hugo site
# Builds with --buildFuture (Termine in der Zukunft sichtbar) and Pagefind index.
# Works locally and on wme00-vrboe (where hugo lives in ~/bin/).

set -e

# Ensure ~/bin/hugo is reachable on the Hostsharing server
export PATH="$HOME/bin:$PATH"

echo "🏗️  Building Hugo site..."
hugo --cleanDestinationDir --buildFuture --minify

echo "🔍 Generating Pagefind search index..."
npx pagefind --site public --output-subdir pagefind

echo "✅ Build complete — public/ ready."
