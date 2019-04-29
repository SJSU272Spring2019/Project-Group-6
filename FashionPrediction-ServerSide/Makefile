clean: 
	docker stop fashion
	docker rm fashion
	docker rmi fashion

build:
	docker build -t fashion .

run:
	docker run --name fashion --network cloudwalker -p 4000:4000 -td fashion

#scp -i cmpe281-us-west-1.pem -r src centos@ec2-54-189-198-193.us-west-2.compute.amazonaws.com:/tmp

#scp -i cmpe281-us-west-1.pem Dockerfile centos@ec2-54-189-198-193.us-west-2.compute.amazonaws.com:/tmp

#scp -i cmpe281-us-west-1.pem Makefile centos@ec2-54-189-198-193.us-west-2.compute.amazonaws.com:/tmp