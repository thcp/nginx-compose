build:
	docker-compose build
run:
	docker-compose up -d
stop:
	docker-compose stop
stop:
	docker-compose restart	
remove:
	docker-compose rm -s
test:
	docker exec nginx sh -c 'nginx -t'