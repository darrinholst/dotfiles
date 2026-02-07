#!/bin/sh
echo "Path: $(pwd)"
echo "Git branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
echo "Last commit: $(git log -1 --format='%h %s' 2>/dev/null)"
