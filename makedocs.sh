#!/usr/bin/env sh

jazzy \
    --clean \
    --author Renetik \
    --author_url https://renetik.github.io \
    --source-host github \
    --source-host-url https://github.com/renetik/renetik-ios-event \
    --module RenetikEvent \
    --swift-build-tool xcodebuild --build-tool-arguments -scheme,RenetikEvent-Package,-sdk,iphoneos
