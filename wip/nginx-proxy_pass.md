I have an application that has two k8s deployments called onboarding-server and frontend onboarding-server is a node server and frontend is a react application that is built and deployed using Nginx.

Here is a snippet which is returned when I run kubectl get all

NAME READY STATUS RESTARTS AGE
pod/frontend-deployment-578f898ffb-cc7gc 1/1 Running 0 15s
pod/node-deployment-7f4754fdf5-fnmls 1/1 Running 0 7d10h

NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
service/frontend-service LoadBalancer 10.100.200.64 10.167.198.105 80:31167/TCP 13d
service/node-service LoadBalancer 10.100.200.71 10.167.199.136 3200:32276/TCP 13d

NAME READY UP-TO-DATE AVAILABLE AGE
deployment.apps/frontend-deployment 1/1 1 1 5d12h
deployment.apps/node-deployment 1/1 1 1 7d10h

NAME DESIRED CURRENT READY AGE
replicaset.apps/frontend-deployment-578f898ffb 1 1 1 17s
replicaset.apps/node-deployment-7f4754fdf5 1 1 1 7d10h
And my nginx.conf config looks something like this

upstream node-service{
server node-service;
}

server {

    listen 80;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
        try_files $uri $uri/ /index.html;
    }


    location = /api {
      proxy_pass http://node-service;
    }

    error_page 404 /index.html;
    location = / {
      root /usr/share/nginx/html;
      internal;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
      root   /usr/share/nginx/html;
    }

}

In your FE you can deploy this config:

server {
listen 80;

location / {
include /etc/nginx/mime.types;
try_files $uri $uri/ /index.html;
}

location /be-svc/ {
proxy_pass "http://<be-svc>.<namespace>/";
}
}

After that your Dockerfile can be something like this:

FROM nginx:1.14

COPY build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf

COPY config/nginx/sites-available/api.conf /etc/nginx/conf.d
And just put the ingress like usual in front of your FE service. Hope it helps!
