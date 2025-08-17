#!/bin/bash
set -e

# Get port from Render environment variable, fallback to 8000
PORT=${PORT:-8000}

echo "Starting TDS Data Analyst Agent on port $PORT"

# Check if required environment variables are set
if [ -z "$gemini_api_1" ] && [ -z "$gemini_api_2" ] && [ -z "$gemini_api_3" ]; then
    echo "Warning: No Gemini API keys found. Set gemini_api_1, gemini_api_2, etc. in Render environment variables."
fi

# Start the application
exec uvicorn app:app --host 0.0.0.0 --port $PORT --workers 1