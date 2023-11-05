#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/purescript/purescript"
TOOL_NAME="purescript"
TOOL_TEST="purs --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if purescript is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename bin url
	version="$1"
	filename="$2"

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    bin="linux64"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    bin="macos"
  else
    fail "unrecognized operating system $OSTYPE"
  fi

  url="$GH_REPO/releases/download/v${version}/${bin}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

  local release_file="$install_path/purs-$version.tar.gz"
  (
    mkdir -p "$install_path/bin"
    download_release "$version" "$release_file"
    tar -xzf "$release_file" -C "$install_path" --strip-components=1 purescript/purs || fail "Could not extract $release_file"
    mv "$install_path/purs" "$install_path/bin"
    rm "$release_file"

		test -x "$install_path/bin/purs" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
