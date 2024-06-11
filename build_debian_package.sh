#!/bin/bash

# Define variables
PACKAGE_NAME="text-tool"
PACKAGE_VERSION="0.1"
MAINTAINER="Your Name <your.email@example.com>"

# Remove any existing Debian package files
rm -f ${PACKAGE_NAME}_${PACKAGE_VERSION}*.deb

# Clean up any previous build artifacts
rm -rf debian

# Create the Debian packaging directory structure
mkdir -p debian/DEBIAN
mkdir -p debian/usr/bin

# Create control file
cat > debian/DEBIAN/control <<EOF
Package: ${PACKAGE_NAME}
Version: ${PACKAGE_VERSION}
Architecture: all
Maintainer: ${MAINTAINER}
Description: Your package description
EOF

cp text_tool/main.py debian/usr/bin/text-tool

# Set executable permissions
chmod +x debian/usr/bin/text-tool

# Build the Debian package
dpkg-deb --build debian

# Rename the Debian package with version
mv debian.deb ${PACKAGE_NAME}_${PACKAGE_VERSION}.deb

# Install the Debian package
dpkg -i ${PACKAGE_NAME}_${PACKAGE_VERSION}.deb

# Create a test file
echo "This is a test file." > test.txt
echo "Another line." >> test.txt

# Run tests
TEST_SORT=$(text-tool sort --file test.txt --by alphabetically)
EXPECTED_SORT="Another line.
This is a test file."

TEST_SEARCH=$(text-tool search --file test.txt --keyword "test")
EXPECTED_SEARCH="This is a test file."

# Verify the test results
if [[ "$TEST_SORT" == "$EXPECTED_SORT" && "$TEST_SEARCH" == "$EXPECTED_SEARCH" ]]; then
    echo "All tests passed."
    # Copy the Debian package to the /output directory
    cp ${PACKAGE_NAME}_${PACKAGE_VERSION}.deb /output/
    echo "Debian package copied to /output."
else
    echo "Tests failed. text-tool not properly installed."
    echo "Sort command output:"
    echo "$TEST_SORT"
    echo "Expected output:"
    echo "$EXPECTED_SORT"
    echo "Search command output:"
    echo "$TEST_SEARCH"
    echo "Expected output:"
    echo "$EXPECTED_SEARCH"
fi

# List the contents of the current directory
ls -la
