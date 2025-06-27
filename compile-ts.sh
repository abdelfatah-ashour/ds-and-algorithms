#!/bin/bash

# TypeScript File Compiler Script
# Usage: ./compile-ts.sh [file.ts] [options]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display usage
show_usage() {
    echo "Usage: $0 [file.ts] [options]"
    echo ""
    echo "Options:"
    echo "  -w, --watch     Watch for file changes and recompile"
    echo "  -o, --out DIR   Output directory (default: ./dist)"
    echo "  -c, --check     Type check only (no output)"
    echo "  -h, --help      Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 ds/stack.ts                    # Compile single file"
    echo "  $0 ds/stack.ts --watch            # Watch and recompile"
    echo "  $0 ds/stack.ts --out ./build      # Custom output directory"
    echo "  $0 ds/stack.ts --check            # Type check only"
    echo "  $0                                # Compile all .ts files"
}

# Default values
WATCH_MODE=false
TYPE_CHECK_ONLY=false
OUTPUT_DIR="./dist"
INPUT_FILE=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -w|--watch)
            WATCH_MODE=true
            shift
            ;;
        -c|--check)
            TYPE_CHECK_ONLY=true
            shift
            ;;
        -o|--out)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *.ts)
            INPUT_FILE="$1"
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            show_usage
            exit 1
            ;;
    esac
done

# Check if TypeScript is installed
if ! command -v tsc &> /dev/null; then
    echo -e "${RED}Error: TypeScript compiler (tsc) not found.${NC}"
    echo "Install it with: npm install -g typescript"
    exit 1
fi

# Build the tsc command
TSC_COMMAND="npx tsc"

if [ -n "$INPUT_FILE" ]; then
    # Compile specific file
    if [ ! -f "$INPUT_FILE" ]; then
        echo -e "${RED}Error: File '$INPUT_FILE' not found.${NC}"
        exit 1
    fi

    echo -e "${YELLOW}Compiling: $INPUT_FILE${NC}"

    if [ "$TYPE_CHECK_ONLY" = true ]; then
        TSC_COMMAND="$TSC_COMMAND --noEmit $INPUT_FILE"
    else
        TSC_COMMAND="$TSC_COMMAND --outDir $OUTPUT_DIR $INPUT_FILE"
    fi
else
    # Compile all files using tsconfig.json
    echo -e "${YELLOW}Compiling all TypeScript files...${NC}"

    if [ "$TYPE_CHECK_ONLY" = true ]; then
        TSC_COMMAND="$TSC_COMMAND --noEmit"
    else
        TSC_COMMAND="$TSC_COMMAND --outDir $OUTPUT_DIR"
    fi
fi

# Add watch mode if requested
if [ "$WATCH_MODE" = true ]; then
    TSC_COMMAND="$TSC_COMMAND --watch"
    echo -e "${YELLOW}Starting in watch mode... Press Ctrl+C to stop.${NC}"
fi

# Execute the command
echo -e "${YELLOW}Running: $TSC_COMMAND${NC}"
eval $TSC_COMMAND

# Check the result
if [ $? -eq 0 ]; then
    if [ "$TYPE_CHECK_ONLY" = false ]; then
        echo -e "${GREEN}✓ Compilation successful! Output in: $OUTPUT_DIR${NC}"
    else
        echo -e "${GREEN}✓ Type checking passed!${NC}"
    fi
else
    echo -e "${RED}✗ Compilation failed!${NC}"
    exit 1
fi
