#!/bin/bash

set -euo pipefail
#set -x

#trap 'kill $(jobs -p)' EXIT # IS THIS NECESSARY? on linux, it kills all child processes when you ctrl-c

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p $DIR/dist/css
mkdir -p $DIR/dist/js

if [ ! -d "$DIR/node_modules" ]; then
  echo "Installing NPM modules"
  npm install
fi

# run sass once without --watch to force update. then run with --watch to keep watching
$DIR/node_modules/.bin/node-sass --output $DIR/dist/css --sourcemap=none $DIR/scss/
$DIR/node_modules/.bin/node-sass --output $DIR/dist/css --sourcemap=none --watch $DIR/scss/ &

$DIR/node_modules/.bin/babel --presets es2015,react --out-dir $DIR/dist/js/ --watch $DIR/js/
