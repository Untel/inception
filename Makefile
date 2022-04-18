# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adda-sil <adda-sil@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/16 10:17:34 by adda-sil          #+#    #+#              #
#    Updated: 2022/04/16 19:13:19 by adda-sil         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME				= inception
SRCS_DIR			= srcs
ENTRY				= docker-compose.yml
compose				= ${SRCS_DIR}/${ENTRY}

all:
					@$(MAKE) $(NAME)

$(NAME):
					docker-compose -f ${compose} up

stop_all:
					docker stop $(docker ps -a -q)

stop:
					docker-compose -f ${compose} down

clear:
					docker rm $(shell docker ps -a -q)

nginx:
					docker exec -it $(shell docker ps -a -q --filter name=srcs_nginx) /bin/sh

mariadb:
					docker exec -it $(shell docker ps -a -q --filter name=srcs_mariadb) /bin/sh

wordpress:
					docker exec -it $(shell docker ps -a -q --filter name=srcs_wordpress) /bin/sh

re:
					docker-compose -f ${compose} up --build
