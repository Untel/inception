# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adda-sil <adda-sil@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/16 10:17:34 by adda-sil          #+#    #+#              #
#    Updated: 2022/04/24 15:02:23 by adda-sil         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME				= inception
SRCS_DIR			= srcs
ENTRY				= docker-compose.yml
CONFIG				= docker-compose.configure.yml
COMPOSE				= docker-compose --file ${SRCS_DIR}/${ENTRY}
COMPOSE_BUILD		= ${COMPOSE} --file ${SRCS_DIR}/${CONFIG}
A					=

VOLUMES_DIR			= ~/data

all:				
					@$(MAKE) deps
					@$(MAKE) $(NAME)

$(NAME):
					@$(MAKE) dep
					${COMPOSE_BUILD} up -d
					${COMPOSE} up --remove-orphans

start:
					@$(MAKE) deps
					${COMPOSE} up --remove-orphans

build:
					@$(MAKE) deps
					${COMPOSE_BUILD} up --build --remove-orphans

logger:
					$(COMPOSE) logs --tail="all" -t -f

log:
					$(COMPOSE) logs --tail="all" -t -f $(A)

deps:
					mkdir -p ${VOLUMES_DIR}/db
					mkdir -p ${VOLUMES_DIR}/www
					echo kill $(sudo netstat -anp | awk '/ LISTEN / {if($4 ~ ":80$") { gsub("/.*","",$7); print $7; exit } }')

cli:
					$(COMPOSE_BUILD) run --rm wpcli $(A)
configure:
					$(COMPOSE_BUILD) run --rm wpcli install
					$(COMPOSE_BUILD) run --rm static
					$(COMPOSE_BUILD) run --rm adminer

cmp:
					$(COMPOSE_BUILD) ${A}

stop:
					${COMPOSE_BUILD} stop

down:
					${COMPOSE_BUILD} down

clear:
					${COMPOSE_BUILD} down -v
					docker system prune -f

fclear:				clear
					sudo rm -rf ${VOLUMES_DIR}


nginx:
					${COMPOSE} exec nginx /bin/sh

mariadb:
					${COMPOSE} exec mariadb /bin/sh

wpcli:
					${COMPOSE_BUILD} exec wpcli /bin/sh

mysql_root:
					${COMPOSE} exec -u root mariadb mariadb -h localhost -u root

mysql:
					${COMPOSE} exec -u root mariadb mariadb -h localhost -u adda-sil -p

wordpress:
					${COMPOSE} exec wordpress /bin/sh

redis:
					${COMPOSE} exec redis /bin/sh

re:					
					@$(MAKE) deps
					${COMPOSE} up --build

fre:				
					$(MAKE) fclear
					${MAKE} build

.PHONY:				srcs