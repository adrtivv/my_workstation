#!/bin/bash

# exit the script on any non zero exit code command
set -e

# url of the web page to parse the nix rpm binary relative path.
BASE_URL="https://nix-community.github.io/nix-installers"

# fetch the web page html
HTML_CONTENT="$(curl -s -L ${BASE_URL})"

# parse the html to extract the relative url to the nix rpm package 
NIX_RPM_FILE_RELATIVE_PATH=$(echo ${HTML_CONTENT} | xmllint --html --xpath "string(//a[contains(@href, 'x86_64/nix-multi-user') and contains(@href, '.rpm')]/@href)" - 2>/dev/null)
# parse the html for sha256 hash of the nix rpm package
SHA256_HASH=$(echo ${HTML_CONTENT} | xmllint --html --xpath "string(//a[contains(@href, 'x86_64/nix-multi-user') and contains(@href, '.rpm')]/following-sibling::code[1])" - 2>/dev/null | tr -d '()')

# remove "." character from the start of relative url if present and append the relative url to the base url
NIX_RPM_FILE_DOWNLOAD_URL=${BASE_URL}${NIX_RPM_FILE_RELATIVE_PATH#.}

# create a temporary rpm file
NIX_RPM_FILE_LOCATION="/tmp/$(mktemp XXXXXX.rpm)"
# download the nix rpm package
curl -L ${NIX_RPM_FILE_DOWNLOAD_URL} -o ${NIX_RPM_FILE_LOCATION}
# create a temporary sha256 file
SHA256_VERIFICATION_FILE_LOCATION="/tmp/$(mktemp XXXXXX.sha256)"
# populate the sha256 verification file with required content
echo "${SHA256_HASH} ${NIX_RPM_FILE_LOCATION}"> ${SHA256_VERIFICATION_FILE_LOCATION}
# verify the sha256 signature of the downloaded nix rpm package
sha256sum -c ${SHA256_VERIFICATION_FILE_LOCATION}
# install the nix rpm package
sudo dnf install -y ${NIX_RPM_FILE_LOCATION}
