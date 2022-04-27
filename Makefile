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
COMPOSE				= docker-compose --file ${SRCS_DIR}/${ENTRY}
A					=

VOLUMES_DIR			= ~/data

all:
					@$(MAKE) $(NAME)

$(NAME):			
					@$(MAKE) deps
					${COMPOSE} up

logger:
					$(COMPOSE) logs --tail="all" -t -f

log:
					$(COMPOSE) logs --tail="all" -t -f $(A)

deps:
					mkdir -p ${VOLUMES_DIR}/mariadb
					mkdir -p ${VOLUMES_DIR}/wordpress
					echo kill $(sudo netstat -anp | awk '/ LISTEN / {if($4 ~ ":80$") { gsub("/.*","",$7); print $7; exit } }')

start:				
					@$(MAKE) deps
					$(COMPOSE) build
					$(COMPOSE) up -d
					@$(MAKE) configure
					@$(MAKE) stop
					@$(MAKE) all

cli:
					$(COMPOSE) run --rm wpcli $(A)
configure:
					$(COMPOSE) run --rm wpcli install


cmp:
					$(COMPOSE) ${A}

stop:
					${COMPOSE} stop

down:
					${COMPOSE} down

clear:
					${COMPOSE} down -v
					docker system prune -f

fclear:				clear
					sudo rm -rf ${VOLUMES_DIR}


nginx:
					${COMPOSE} exec nginx /bin/sh

mariadb:
					${COMPOSE} exec mariadb /bin/sh

wpcli:
					${COMPOSE} exec wpcli /bin/sh

mysql_root:
					${COMPOSE} exec -u root mariadb mariadb -h localhost -u root

mysql:
					${COMPOSE} exec -u root mariadb mariadb -h localhost -u adda-sil -p

adminer:
					${COMPOSE} exec adminer /bin/sh

wordpress:
					${COMPOSE} exec wordpress /bin/sh

test:
					${COMPOSE} exec test /bin/sh

re:					deps
					${COMPOSE} up --build

fre:				clear
					${COMPOSE} up --build

.PHONY:				srcs logger