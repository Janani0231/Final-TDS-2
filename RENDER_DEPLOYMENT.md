# Render Deployment Guide for TDS Data Analyst Agent

## Prerequisites
- Render account
- Gemini API keys from Google AI Studio

## Step 1: Prepare Your Repository
1. Make sure all files are committed to your git repository
2. Ensure you have the following files:
   - `app.py` (main application)
   - `requirements.txt` (Python dependencies)
   - `Dockerfile` (container configuration)
   - `entrypoint.sh` (startup script)
   - `render.yaml` (Render configuration)

## Step 2: Deploy on Render

### Option A: Using render.yaml (Recommended)
1. Connect your GitHub repository to Render
2. Render will automatically detect the `render.yaml` file
3. The service will be configured automatically

### Option B: Manual Configuration
1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click "New +" → "Web Service"
3. Connect your GitHub repository
4. Configure the service:
   - **Name**: `tds-data-analyst` (or your preferred name)
   - **Environment**: `Python`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `./entrypoint.sh`
   - **Plan**: `Starter` (or your preferred plan)

## Step 3: Environment Variables
Set these environment variables in Render:

### Required:
- `gemini_api_1`: Your first Gemini API key
- `gemini_api_2`: Your second Gemini API key (optional, for fallback)
- `gemini_api_3`: Your third Gemini API key (optional, for fallback)

### Optional:
- `GOOGLE_MODEL`: Model to use (default: gemini-2.5-pro)
- `LLM_TIMEOUT_SECONDS`: Timeout for LLM calls (default: 240)

## Step 4: Deploy
1. Click "Create Web Service"
2. Wait for the build to complete
3. Your service will be available at the provided URL

## Troubleshooting 502 Errors

### 1. Check Build Logs
- Go to your service in Render dashboard
- Click on "Logs" tab
- Look for any build or runtime errors

### 2. Common Issues and Solutions

#### Port Configuration
- Ensure your app listens on the port specified by the `PORT` environment variable
- Render automatically sets this variable

#### Missing Dependencies
- Check if all packages in `requirements.txt` are compatible
- Some packages might need system dependencies (handled in Dockerfile)

#### API Key Issues
- Verify your Gemini API keys are correctly set in environment variables
- Test your API keys locally before deploying

#### Memory Issues
- The starter plan has limited memory
- Consider upgrading to a higher plan if you encounter memory issues

### 3. Health Check Endpoints
Your app includes these health check endpoints:
- `/health` - Simple health check
- `/summary` - Detailed system diagnostics

### 4. Debugging Steps
1. Check the `/summary` endpoint for system information
2. Verify environment variables are set correctly
3. Check if the app is starting on the correct port
4. Ensure all required files are present in the container

## Testing Your Deployment
1. Visit your service URL
2. Test the `/health` endpoint
3. Try uploading a file and running analysis
4. Check the `/summary` endpoint for system status

## Performance Optimization
- The app uses a single worker (`--workers 1`) to avoid memory issues
- Consider upgrading your Render plan for better performance
- Monitor memory usage in the Render dashboard

## Support
If you continue to experience issues:
1. Check the Render community forums
2. Review the build and runtime logs
3. Test your app locally with Docker
4. Verify all environment variables are set correctly
