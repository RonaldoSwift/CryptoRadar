#!/bin/bash

set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ ! -d "$project_root/Tuist/.build" ]]; then
    echo "Tuist artifacts not found. Run 'tuist generate' first." >&2
    exit 1
fi

find "$project_root" -type f -name project.pbxproj -print0 |
    xargs -0 sed -i '' \
        -e 's/IPHONEOS_DEPLOYMENT_TARGET = 11\.0;/IPHONEOS_DEPLOYMENT_TARGET = 17.0;/g' \
        -e 's/IPHONEOS_DEPLOYMENT_TARGET = 12\.0;/IPHONEOS_DEPLOYMENT_TARGET = 17.0;/g' \
        -e 's/IPHONEOS_DEPLOYMENT_TARGET = 13\.0;/IPHONEOS_DEPLOYMENT_TARGET = 17.0;/g' \
        -e 's/IPHONEOS_DEPLOYMENT_TARGET = 14\.0;/IPHONEOS_DEPLOYMENT_TARGET = 17.0;/g' \
        -e 's/IPHONEOS_DEPLOYMENT_TARGET = 15\.0;/IPHONEOS_DEPLOYMENT_TARGET = 17.0;/g' \
        -e 's/IPHONEOS_DEPLOYMENT_TARGET = 16\.0;/IPHONEOS_DEPLOYMENT_TARGET = 17.0;/g'

echo "Updated generated dependency deployment targets to iOS 17."
