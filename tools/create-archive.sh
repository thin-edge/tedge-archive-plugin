#!/bin/sh
set -ex

FILE=${FILE:-}
SOURCE_DIR=${SOURCE_DIR:-}

TYPE="$1"
shift

while [ $# -gt 0 ]; do
    case "$1" in
        --name)
            NAME="$2"
            shift
            ;;

        --file)
            FILE="$2"
            shift
            ;;

        --source|-s)
            SOURCE_DIR="$2"
            shift
            ;;
    esac
    shift
done

resolve_path() {
    dir=$(dirname "$1")
    FULL_PATH=$([ -d "$dir" ] && [ '-' != "$dir" ] && CDPATH='' cd -P -- "$dir" && pwd -P)
    echo "$FULL_PATH/$(basename "$1")"    
}

create_tarball() {
    OUTPUT_FILE=$(resolve_path "$1")
    (cd "$SOURCE_DIR" && tar cvzf "$OUTPUT_FILE" --owner=0 --group=0 --no-same-owner --no-same-permissions ".")
}

case "$TYPE" in
    tarball)
        create_tarball "$FILE"
        ;;
    zip)
        ;;
esac
