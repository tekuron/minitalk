# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: danz <danz@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/16 18:04:02 by danzamor          #+#    #+#              #
#    Updated: 2025/11/18 19:26:43 by danz             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

PROJECT = minitalk
SERVER	= server
CLIENT	= client
SERVER_BNS	= server_bonus
CLIENT_BNS	= client_bonus

SRC_DIR = src
OBJ_DIR = obj
LIB_DIR = libft

CC = gcc
CFLAGS = -Wall -Wextra -Werror -g3
RM = rm -rf
AR = ar rcs

LIB = $(LIB_DIR)/libft.a
INCLUDE = -I inc -I $(LIB_DIR)/inc

SERVER_SRCS = $(SRC_DIR)/server.c
CLIENT_SRCS = $(SRC_DIR)/client.c

SERVER_OBJS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SERVER_SRCS))
CLIENT_OBJS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(CLIENT_SRCS))

SERVER_SRCS_BNS = $(SRC_DIR)/server_bonus.c
CLIENT_SRCS_BNS = $(SRC_DIR)/client_bonus.c

SERVER_OBJS_BNS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SERVER_SRCS_BNS))
CLIENT_OBJS_BNS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(CLIENT_SRCS_BNS))

GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
CYAN = \033[0;36m
RESET = \033[0m

all: $(SERVER) $(CLIENT)

$(SERVER): $(LIB) $(SERVER_OBJS)
	@$(CC) $(CFLAGS) $(INCLUDE) $(SERVER_OBJS) $(LIB) -o $(SERVER)
	@echo "$(GREEN)$(PROJECT) built: $(SERVER)$(RESET)"

$(CLIENT): $(LIB) $(CLIENT_OBJS)
	@$(CC) $(CFLAGS) $(INCLUDE) $(CLIENT_OBJS) $(LIB) -o $(CLIENT)
	@echo "$(GREEN)$(PROJECT) built: $(CLIENT)$(RESET)"

$(LIB):
	@make -C $(LIB_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	@echo "$(CYAN)Compiling: $<$(RESET)"
	@$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@

bonus: $(SERVER_BNS) $(CLIENT_BNS)

$(SERVER_BNS): $(LIB) $(SERVER_OBJS_BNS)
	@$(CC) $(CFLAGS) $(INCLUDE) $(SERVER_OBJS_BNS) $(LIB) -o $(SERVER)
	@echo "$(GREEN)$(PROJECT) built: $(SERVER)$(RESET)"

$(CLIENT_BNS): $(LIB) $(CLIENT_OBJS_BNS)
	@$(CC) $(CFLAGS) $(INCLUDE) $(CLIENT_OBJS_BNS) $(LIB) -o $(CLIENT)
	@echo "$(GREEN)$(PROJECT) built: $(CLIENT)$(RESET)"

clean:
	@$(RM) $(OBJ_DIR)
	@make clean -C $(LIB_DIR)
	@echo "$(BLUE)$(PROJECT) object files removed$(RESET)"

fclean: clean
	@$(RM) $(SERVER) $(CLIENT)
	@make fclean -C $(LIB_DIR)
	@echo "$(BLUE)$(PROJECT) clean (executables and library removed)$(RESET)"

re: fclean all

.PHONY: all clean fclean re