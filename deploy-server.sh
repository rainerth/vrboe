#!/bin/bash

# Server deployment script for vrboe Hugo site
# Pulls latest commits from GitHub and rebuilds via build.sh.
# Usage: ./deploy-server.sh [--force]
#   --force: Force rebuild even if repository is up-to-date

FORCE_BUILD=false
[ "$1" = "--force" ] && FORCE_BUILD=true

REPO_DIR="$HOME/prj/vrboe"
LOG_FILE="$HOME/logs/vrboe-deploy.log"

mkdir -p "$HOME/logs"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "🚀 Starting vrboe site deployment..."

cd "$REPO_DIR" || {
    log "❌ Failed to change to repository directory: $REPO_DIR"
    exit 1
}

log "📡 Fetching latest changes from GitHub..."
git fetch

UPSTREAM=@{upstream}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ "$LOCAL" = "$REMOTE" ]; then
    if [ "$FORCE_BUILD" = true ]; then
        log "🔄 Repository is up-to-date but --force specified, rebuilding..."
    else
        log "✅ Repository is up-to-date"
        exit 0
    fi
elif [ "$LOCAL" = "$BASE" ]; then
    log "📥 Updates available, pulling..."
    git fetch --depth=1
    git reset --hard "$REMOTE"
elif [ "$REMOTE" = "$BASE" ]; then
    log "⚠️  Local repository has unpushed changes — manual intervention required"
    exit 1
else
    log "❌ Repository has diverged — manual intervention required"
    exit 1
fi

log "🏗️  Building site..."
if ./build.sh >>"$LOG_FILE" 2>&1; then
    log "✅ Build completed"
    log "📊 HTML files: $(find public -name '*.html' | wc -l), total size: $(du -sh public | cut -f1)"
    log "🎉 Deployment complete"
else
    log "❌ Build failed — see log above"
    exit 1
fi
