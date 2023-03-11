#!/bin/sh
OUTPUT_FILE=Tests/featurehub-swift-sdkTests/GeneratedMocks.swift
echo "Generated mocks into $OUTPUT_FILE"

ID="Sources/featurehub-swift-sdk"

./cuckoo_run generate --testable "featurehub-swift-sdk" --output "$OUTPUT_FILE" "${ID}/featurehub_swift_sdk.swift" "${ID}/features.swift"