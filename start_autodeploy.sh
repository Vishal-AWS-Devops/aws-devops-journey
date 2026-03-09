#!/bin/bash

# Kill old listener if running
echo "Stopping old listener if any..."
kill -9 $(ps aux | grep '[w]ebhook_listener.py' | awk '{print $2}') 2>/dev/null
sudo kill -9 $(sudo lsof -t -i :8000) 2>/dev/null

# Start ngrok for port 8000
echo "Starting ngrok tunnel..."
nohup ngrok http 8000 > ~/aws-devops-journey/ngrok.log 2>&1 &

# Give ngrok a few seconds to start
sleep 5

# Start webhook listener
echo "Starting webhook listener..."
nohup python3 ~/aws-devops-journey/webhook_listener.py > ~/aws-devops-journey/nohup.out 2>&1 &

echo "Setup complete!"
echo "Check ngrok URL in ngrok.log"
