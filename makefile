build:
	./setup.sh
run:
	docker-compose up -d
stop:
	docker-compose stop
remove:
	docker-compose rm -s
test:
	docker exec nginx sh -c 'nginx -t'