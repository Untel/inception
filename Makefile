# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adda-sil <adda-sil@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/16 10:17:34 by adda-sil          #+#    #+#              #
#    Updated: 2022/04/18 16:09:31 by adda-sil         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME				= inception
SRCS_DIR			= srcs
ENTRY				= docker-compose.yml
COMPOSE				= docker-compose --file ${SRCS_DIR}/${ENTRY}
A					=

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

wordpress:
					${COMPOSE} exec wordpress /bin/sh

re:
					${COMPOSE} up --build

fre:				clear
					${COMPOSE} up --build
