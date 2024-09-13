.PHONY: update seed clean

update:
	npm install
	npm npm run prod
	composer install --no-interaction --optimize-autoloader --no-dev
	php craft up --interactive=0
	php craft queue/run --interactive=0
	php craft gc --delete-all-trashed --interactive=0
seed:
	php craft demos/seed
clean:
	php craft demos/seed/clean
