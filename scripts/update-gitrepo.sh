#!/bin/bash
# https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git
# https://mirrors.edge.kernel.org/pub/software/scm/git/docs/gitrevisions.html
#
# Server-side cron-driven repo updater for wme00-vrboe.
# Mirrors the BEG variant: pulls if remote is ahead, then runs hugo + pagefind.
# Install with:
#   scp scripts/update-gitrepo.sh wme00-vrboe:~/bin/update-gitrepo.sh
#   ssh wme00-vrboe 'chmod +x ~/bin/update-gitrepo.sh'

cd $HOME/prj/vrboe
git fetch

UPSTREAM=@{upstream}

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"

elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
    git fetch --depth=1
    git reset --hard $REMOTE
    git pull
    $HOME/bin/hugo --buildFuture --minify --cleanDestinationDir
    npx pagefind --site public --output-subdir pagefind

elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi
