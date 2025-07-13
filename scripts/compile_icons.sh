#!/bin/sh

DIRECTORY="$(pwd)/assets/resources/icons"
TARGET="$(pwd)/assets/resources/vectors"

echo "Checking directories..."
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Source directory does not exist: $DIRECTORY"
    exit 1
fi

mkdir -p "$TARGET"

process_files() {
    local src="$1"
    local dest="$2"

    echo "Processing directory: $src"

    for entry in "$src"/*; do
        if [ -d "$entry" ]; then
            local new_dir="$dest/$(basename "$entry")"
            echo "Creating directory: $new_dir"
            mkdir -p "$new_dir"
            process_files "$entry" "$new_dir"
        elif [ -f "$entry" ]; then
            echo "Compiling SVG: $entry"
            fvm dart run vector_graphics_compiler --input "$entry" --output "$dest/$(basename "${entry%.*}").vec"
        else
            echo "Warning: Skipping unknown entry: $entry"
        fi
    done
}

process_files "$DIRECTORY" "$TARGET"