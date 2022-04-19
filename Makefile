# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adda-sil <adda-sil@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/16 10:17:34 by adda-sil          #+#    #+#              #
#    Updated: 2022/04/19 03:39:29 by adda-sil         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME				= inception
SRCS_DIR			= srcs
ENTRY				= docker-compose.yml
COMPOSE				= docker-compose --file ${SRCS_DIR}/${ENTRY}
A					=

# include ${SRCS_DIR}/.env
# export

all:
					@$(MAKE) $(NAME)

$(NAME):
					${COMPOSE} up

cmp:
					$(COMPOSE) ${A}

stop:
					${COMPOSE} stop

down:
					${COMPOSE} down

clear:
					${COMPOSE} down -v

nginx:
					${COMPOSE} exec nginx /bin/sh

mariadb:
					${COMPOSE} exec mariadb /bin/sh

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

re:
					${COMPOSE} up --build

fre:				clear
					${COMPOSE} up --build

.PHONY:				srcs