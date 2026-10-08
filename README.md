# Docker Mini Project: Flask app -> image -> container -> Docker Hub -> EC2

## 1. Build the image
    docker build -t flask-mini:v1 .
    docker images

## 2. Run the container
    docker run -d --name mini -p 5000:5000 flask-mini:v1
    docker ps
    docker logs mini
    curl localhost:5000/health

Open http://localhost:5000 (or http://<EC2-PUBLIC-IP>:5000 on EC2;
open port 5000 in the EC2 Security Group inbound rules).

## 3. Experiment
    # Override env var
    docker run -d --name mini2 -p 5001:5000 -e APP_VERSION=v2-test flask-mini:v1
    # Shell inside container
    docker exec -it mini bash
    # Stop and remove
    docker stop mini mini2 && docker rm mini mini2

## 4. Push to Docker Hub
    docker login
    docker tag flask-mini:v1 <your-dockerhub-username>/flask-mini:v1
    docker push <your-dockerhub-username>/flask-mini:v1

## 5. Deploy on another machine (fresh EC2)
    docker run -d -p 80:5000 --restart unless-stopped <your-dockerhub-username>/flask-mini:v1

## 6. Stretch goals
- Add docker-compose.yml with this app + a Redis visit counter
- Make a v2 (change the HTML), build, push, and redeploy
- Multi-stage build to shrink the image
- Push to AWS ECR instead of Docker Hub
