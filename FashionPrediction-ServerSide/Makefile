clean: 
	docker stop fashion
	docker rm fashion
	docker rmi fashion

build:
	docker build -t fashion .

run:
	docker run --name fashion --network cloudwalker -p 4000:4000 -td fashion

