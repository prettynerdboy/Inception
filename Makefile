all:
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb
	cd srcs && docker-compose up -d --build

down:
	@cd srcs && docker-compose down

clean:
	@cd srcs && docker-compose down -v

fclean: clean
	@rm -rf $(HOME)/data
	@docker system prune -af

re: fclean all

.PHONY: all down clean fclean re