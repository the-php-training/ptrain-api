# Variables
DC=docker compose --file docker-compose.yml --env-file ./main/.env

.PHONY: up down sh logs setup test migrate rollback horizon app-log

up:
	$(DC) up -d --build
	$(DC) exec ptrain-api composer install

setup: up

down:
	$(DC) down

sh:
	$(DC) exec ptrain-api sh

test:
	$(DC) exec ptrain-api composer test

test-report:
	$(DC) exec ptrain-api vendor/bin/pest --coverage-html=report

logs:
	$(DC) logs -f --tail=10

migrate:
	$(DC) exec ptrain-api php artisan migrate

rollback:
	$(DC) exec ptrain-api php artisan migrate:rollback

horizon:
	$(DC) exec ptrain-api php artisan horizon

app-log:
	$(DC) exec ptrain-api tail -f storage/logs/laravel.log -n 0
