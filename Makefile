# This will output the help for each task. thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


all: help
#
#build: ## Build containers
#	@docker-compose build

up: build ## Start docker composer
	@docker-compose up -d --force-recreate

down: ## Stop docker containers
	@docker-compose down

runin: ## Run command in app container
	@docker-compose exec -- app $(filter-out $@,$(MAKECMDGOALS))

cs-fix: ## Run CS fixer and fix
	@docker-compose exec -- app php vendor/bin/php-cs-fixer fix -v

pre-commit: cs-fix ## Prepare to commit commands

%:
	@:
