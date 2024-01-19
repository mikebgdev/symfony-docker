#!/bin/sh
set -e

if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

if [ "$1" = 'php-fpm' ] || [ "$1" = 'php' ] || [ "$1" = 'bin/console' ]; then
	projects_json="$PROJECTS_JSON"
	projects=$(echo "$projects_json" | jq '.[]')

	container_ip=$(ip -4 addr show eth0 | awk '$1 == "inet" {print $2}' | awk -F/ '{print $1}')

	for project in $(echo "$projects" | jq -c '.[]'); do
		name=$(echo "$project" | jq -r '.name')

		if [ ! -f $name/composer.json ]; then
			composer create-project "symfony/skeleton $SYMFONY_VERSION" $name --no-progress --no-interaction --no-install
		fi

		cd $name
		composer install --prefer-dist --no-progress --no-interaction

		chmod -R 775 var/cache/dev
		chown -R www-data:www-data var/cache/dev

		cd ..
	done
fi

exec docker-php-entrypoint "$@"
