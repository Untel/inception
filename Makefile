# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adda-sil <adda-sil@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/16 10:17:34 by adda-sil          #+#    #+#              #
#    Updated: 2022/01/16 10:54:15 by adda-sil         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME				= inception
SRCS_DIR			= srcs
ENTRY				= docker-compose.yml

all:
					@$(MAKE) $(NAME)

$(NAME):			
					docker-compose up -f ${SRCS_DIR}/${ENTRY}