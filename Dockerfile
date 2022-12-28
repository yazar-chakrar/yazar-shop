FROM node:16.17.1 as base

FROM base as development
WORKDIR /app
COPY package.json /app
RUN npm install 
COPY . . 
EXPOSE 8000
CMD ["npm", "run", "dev"]

FROM base as production
WORKDIR /app
COPY package.json /app
RUN npm install --only=production
COPY . . 
EXPOSE 8000
CMD ["npm", "run", "start"]

#List Images
#docker image ls

#list containers 
#docker ps

## 1-) Create Image
# docker build -t node-app-image .

## 2-) Create Container
# -v -v ${pwd}/src:/app/src // ${pwd} : working dir // sync while coding
# -p P1:P2 P1 for cont, P2 for local machine, access P1 from P2
# -v Volume
# docker run --name node-app-container -v ${pwd}/src:/app/src -d -p 4000:4000 -e CHOKIDAR_USEPOLLING=true node-app-image

## 3-) Delete Container
#  docker rm node-app-container -f 

## 4-) Show logs of running container
# docker logs node-app-container

## 5-) show running containers
#  docker ps

## 6-) run container and open bash
# docker exec -it node-app-container bash



# Working without stages
#FROM node:16.17.1
#WORKDIR /app
#COPY package.json /app
#ARG NODE_ENV
#RUN if ["$NODE_ENV" = "production"]; \
#    then npm install --only=production; \
#    else npm install; \
#    fi 
#COPY . . 
#EXPOSE 4000
#CMD ["npm", "run", "start-dev"]