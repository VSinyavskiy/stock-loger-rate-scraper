DC  	           := docker-compose exec
PHP-SERVICE        := $(DC) php-fpm
SUPERVISOR-SERVICE := $(DC) supervisor
ARTISAN            := $(PHP-SERVICE) php artisan 
COMPOSER           := $(PHP-SERVICE) composer
SUPERVISOR         := $(SUPERVISOR-SERVICE) supervisorctl

.PHONY:
	run vendors keygen env permissions stop build start migrate back-build supervisor-restart

build:
	@docker-compose build

start:
	@docker-compose up -d

stop:
	@docker-compose down

permissions: 
	sudo chmod -R 777 storage/

env: 
	cp .env.example .env

keygen:
	@$(ARTISAN) key:generate

vendors:
	@$(COMPOSER) install

back-build:
	@$(COMPOSER) dump-autoload

migrate:
	@$(ARTISAN) migrate

ssh: 
	@$(PHP-SERVICE) /bin/sh 

supervisor-restart:
	@$(SUPERVISOR) reload

run:
	make env && make start && make vendors && make keygen && make permissions 
